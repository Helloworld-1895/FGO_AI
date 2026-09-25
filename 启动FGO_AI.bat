@echo off
setlocal
cd /d "%~dp0"
if exist "%~dp0app\FGO_AI.exe" (
  start "FGO AI" "%~dp0app\FGO_AI.exe"
  exit /b 0
)
echo 未找到 app\FGO_AI.exe，请从 GitHub Releases 下载并完整解压发布包。
pause
exit /b 1
