@echo off
setlocal
cd /d "%~dp0"
if /i "%~1"=="--self-test" (
  powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\bootstrap.ps1" %*
  exit /b %ERRORLEVEL%
)
wscript.exe "%~dp0launcher_hidden.vbs" %*
exit /b 0
