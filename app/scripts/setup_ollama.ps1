param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$OllamaVersion = "0.40.17"
)
$ErrorActionPreference = "Stop"
$root = (Resolve-Path $ProjectRoot).Path
$target = Join-Path $root "tmp/build/ollama"
$models = Join-Path $root "tmp/build/ollama-models"
$exe = Join-Path $target "ollama.exe"
New-Item -ItemType Directory -Force -Path $target, $models | Out-Null
if (-not (Test-Path -LiteralPath $exe)) {
    $zip = Join-Path $target "ollama.zip"
    $part = "$zip.part"
    $url = "https://github.com/ollama/ollama/releases/download/v$OllamaVersion/ollama-windows-amd64.zip"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $downloaded = $false
    for ($attempt = 1; $attempt -le 4; $attempt++) {
        $resumeText = if (Test-Path -LiteralPath $part) { "，从已有进度继续" } else { "" }
        Write-Output "正在下载 Ollama 程序包（尝试 $attempt/4$resumeText）"
        $downloadCompleted = $false
        try {
            # BITS 支持 HTTP Range，网络中断后可从 .part 继续；不可用时回退到普通请求。
            try {
                Start-BitsTransfer -Source $url -Destination $part -DisplayName "Ollama" -Description "下载 Ollama 程序包" -Priority Foreground -RetryInterval 10 -RetryTimeout 300 -Resume
            } catch {
                if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
                    & curl.exe --fail --location --retry 3 --retry-delay 2 --continue-at - --output $part $url
                    if ($LASTEXITCODE -ne 0) { throw "curl 下载失败（退出码 $LASTEXITCODE）" }
                } else {
                    Invoke-WebRequest -Uri $url -OutFile $part -UseBasicParsing -TimeoutSec 300
                }
            }
            if ((Get-Item -LiteralPath $part).Length -lt 1MB) { throw "下载文件大小异常" }
            $downloadCompleted = $true
            Move-Item -LiteralPath $part -Destination $zip -Force
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $archive = [System.IO.Compression.ZipFile]::OpenRead($zip)
            try {
                if (-not ($archive.Entries | Where-Object { $_.FullName -match '(^|/)ollama\.exe$' })) {
                    throw "压缩包内未找到 ollama.exe"
                }
            } finally { $archive.Dispose() }
            $downloaded = $true
            break
        } catch {
            Write-Output "Ollama 程序包下载/校验失败：$($_.Exception.Message)"
            if ($downloadCompleted -and (Test-Path -LiteralPath $zip)) {
                # 文件已完整下载但校验失败，不能把损坏 ZIP 当作可续传数据。
                Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
            } elseif (Test-Path -LiteralPath $zip) {
                Move-Item -LiteralPath $zip -Destination $part -Force -ErrorAction SilentlyContinue
            }
            if ($attempt -lt 4) { Start-Sleep -Seconds ([Math]::Min(2 * $attempt, 8)) }
        }
    }
    if (-not $downloaded) { throw "重试 4 次仍无法下载有效的 Ollama 程序包，请检查网络或使用手动配置。" }
    try {
        Expand-Archive -LiteralPath $zip -DestinationPath $target -Force
    } catch {
        Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
        throw "Ollama 压缩包解压失败：$($_.Exception.Message)"
    }
    if (-not (Test-Path -LiteralPath $exe)) { throw "解压完成但缺少 ollama.exe，请重试或手动安装。" }
}
$env:OLLAMA_MODELS = $models
Write-Output "OLLAMA_READY=$exe"
Write-Output "OLLAMA_MODELS=$models"
