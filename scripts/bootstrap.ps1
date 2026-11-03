[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ArgumentList = @()
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$AppRoot = Join-Path $ProjectRoot 'app'
$EntryPoint = Join-Path $AppRoot 'FGO_AI.exe'
$ProfilePath = Join-Path $AppRoot 'profiles\fgo_cn_1600x900.yaml'
$ManifestPath = Join-Path $ProjectRoot 'release-manifest.json'
$LogDirectory = Join-Path $ProjectRoot 'logs'
$LogPath = Join-Path $LogDirectory 'setup.log'
$RepairRoot = Join-Path $ProjectRoot '.repair'
$ManifestUrl = 'https://raw.githubusercontent.com/Helloworld-1895/FGO_AI/main/release-manifest.json'

New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null

function Write-SetupLog {
    param([string]$Message)
    $line = '[{0}] {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    Write-Host $line
    Add-Content -LiteralPath $LogPath -Value $line -Encoding UTF8
}

function Test-LocalApp {
    if (-not ((Test-Path -LiteralPath $EntryPoint -PathType Leaf) -and
        (Test-Path -LiteralPath $ProfilePath -PathType Leaf))) { return $false }
    if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) { return $true }
    try {
        $manifest = Get-Content -LiteralPath $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
        foreach ($required in @($manifest.required_files)) {
            $relative = ([string]$required.path).Replace('/', '\')
            $file = Join-Path $AppRoot $relative
            if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { return $false }
            if ($required.sha256) {
                $actual = (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLowerInvariant()
                if ($actual -ne ([string]$required.sha256).ToLowerInvariant()) { return $false }
            }
        }
        return $true
    } catch { return $false }
}

function Invoke-App {
    param([string[]]$Arguments)
    if (($Arguments -contains '--self-test') -or ($Arguments -contains '--self-test-cuda')) {
        Push-Location -LiteralPath $AppRoot
        try {
            & $EntryPoint @Arguments | Out-Host
            return $LASTEXITCODE
        } finally { Pop-Location }
    }
    if ($Arguments) {
        $process = Start-Process -FilePath $EntryPoint -ArgumentList $Arguments -WorkingDirectory $AppRoot -PassThru
    } else {
        $process = Start-Process -FilePath $EntryPoint -WorkingDirectory $AppRoot -PassThru
    }
    return 0
}

function Get-Manifest {
    if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
        Write-SetupLog '本地发布清单缺失，正在从 GitHub 获取修复清单'
        Invoke-WebRequest -UseBasicParsing -Uri $ManifestUrl -OutFile $ManifestPath -TimeoutSec 30
    }
    $manifest = Get-Content -LiteralPath $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not $manifest.archive_sha256 -and $manifest.version) {
        $localVersion = [string]$manifest.version
        if ($localVersion -notmatch '^\d+\.\d+\.\d+$') { throw 'Invalid local release version' }
        $pinnedManifestUrl = $ManifestUrl.Replace('/main/', ('/v' + $localVersion + '/'))
        if ($manifest.variant -eq 'CUDA') { $pinnedManifestUrl = $pinnedManifestUrl.Replace('release-manifest.json', 'release-manifest-cuda.json') }
        Write-SetupLog ('正在获取同版本修复清单：v' + $localVersion)
        $response = Invoke-WebRequest -UseBasicParsing -Uri $pinnedManifestUrl -TimeoutSec 30
        $pinnedManifest = $response.Content | ConvertFrom-Json
        if ([string]$pinnedManifest.version -ne $localVersion) { throw 'Repair manifest version mismatch' }
        if ($manifest.variant -and ([string]$pinnedManifest.variant -ne [string]$manifest.variant)) { throw 'Repair manifest variant mismatch' }
        $manifest = $pinnedManifest
    }
    foreach ($name in @('version', 'archive_url', 'archive_sha256')) {
        if (-not $manifest.$name) { throw "发布清单缺少字段：$name" }
    }
    if (([uri]$manifest.archive_url).Scheme -ne 'https' -or
        ([uri]$manifest.archive_url).Host -notin @('github.com', 'objects.githubusercontent.com')) {
        throw '发布清单下载地址不是受支持的 HTTPS GitHub 地址'
    }
    if ($manifest.archive_sha256 -notmatch '^[0-9a-fA-F]{64}$') { throw '发布清单中的 SHA-256 无效' }
    $manifest | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $ManifestPath -Encoding UTF8
    return $manifest
}

function Repair-App {
    $manifest = Get-Manifest
    if (Test-Path -LiteralPath $RepairRoot) { Remove-Item -LiteralPath $RepairRoot -Recurse -Force }
    New-Item -ItemType Directory -Path $RepairRoot -Force | Out-Null
    $archivePath = Join-Path $RepairRoot ('FGO_AI-v' + $manifest.version + '.zip')
    $extractRoot = Join-Path $RepairRoot 'extract'
    try {
        Write-SetupLog '本地运行包缺失或不完整，正在下载修复包'
        Invoke-WebRequest -UseBasicParsing -Uri ([string]$manifest.archive_url) -OutFile $archivePath -TimeoutSec 600
        $actualHash = (Get-FileHash -LiteralPath $archivePath -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($actualHash -ne ([string]$manifest.archive_sha256).ToLowerInvariant()) {
            throw "修复包 SHA-256 不匹配：$actualHash"
        }
        Expand-Archive -LiteralPath $archivePath -DestinationPath $extractRoot -Force
        $candidate = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter 'FGO_AI.exe' -File | Select-Object -First 1
        if (-not $candidate) { throw '修复包缺少 FGO_AI.exe' }
        $stagedApp = $candidate.Directory.FullName
        $stagedProfile = Join-Path $stagedApp 'profiles\fgo_cn_1600x900.yaml'
        if (-not (Test-Path -LiteralPath $stagedProfile -PathType Leaf)) { throw '修复包缺少默认配置' }
        $userProfile = Join-Path $AppRoot 'profiles\user.yaml'
        if (Test-Path -LiteralPath $userProfile -PathType Leaf) { Copy-Item -LiteralPath $userProfile -Destination (Join-Path $stagedApp 'profiles\user.yaml') -Force }
        $userSecrets = Join-Path $AppRoot 'secrets'
        if (Test-Path -LiteralPath $userSecrets -PathType Container) { Copy-Item -LiteralPath $userSecrets -Destination $stagedApp -Recurse -Force }
        $backup = $null
        if (Test-Path -LiteralPath $AppRoot) {
            $backup = Join-Path $ProjectRoot ('.app-backup-' + [guid]::NewGuid().ToString('N'))
            Move-Item -LiteralPath $AppRoot -Destination $backup
        }
        try {
            Move-Item -LiteralPath $stagedApp -Destination $AppRoot
        }
        catch {
            if ($backup -and (Test-Path -LiteralPath $backup)) { Move-Item -LiteralPath $backup -Destination $AppRoot }
            throw
        }
        if ($backup -and (Test-Path -LiteralPath $backup)) { Write-SetupLog ('已保留旧 app 备份（含自定义模板等本地数据），确认迁移后可手动清理：' + $backup) }
        Write-SetupLog '修复包安装完成'
    }
    finally {
        if (Test-Path -LiteralPath $RepairRoot) { Remove-Item -LiteralPath $RepairRoot -Recurse -Force -ErrorAction SilentlyContinue }
    }
}

try {
    if (-not (Test-LocalApp)) { Repair-App }
    if (-not (Test-LocalApp)) { throw '运行包仍不完整，请重新下载 Release 并完整解压' }
    $exitCode = Invoke-App -Arguments $ArgumentList
    exit $exitCode
}
catch {
    Write-SetupLog ('失败：' + $_.Exception.Message)
    Write-Error $_.Exception.Message
    exit 1
}
