@echo off
setlocal enabledelayedexpansion
REM Rubix Programming Language - Native Windows CLI Driver
REM Repository: tek-sys-hub/Rubix-Mobile-Framework-2.0
REM 100% Pure Rubix native execution on Windows

set "SCRIPT_DIR=%~dp0"

where powershell.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%rubix.ps1" %*
    exit /b %ERRORLEVEL%
)

where pwsh.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%rubix.ps1" %*
    exit /b %ERRORLEVEL%
)

echo error: PowerShell was not found on this system.
echo Please run Windows PowerShell to execute Rubix on Windows.
exit /b 1
