# Rubix Windows PowerShell Installer
# Run in PowerShell: irm https://raw.githubusercontent.com/tek-sys-hub/Rubix-Mobile-Framework-2.0/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "      Rubix Programming Language Windows Installer        " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$RubixDir = Join-Path $HOME ".rubix"
$BinDir = Join-Path $RubixDir "bin"
$RuntimeDir = Join-Path $RubixDir "runtime"

New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
New-Item -ItemType Directory -Force -Path $RuntimeDir | Out-Null

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($ScriptDir -and (Test-Path (Join-Path $ScriptDir "bin\rubix.cmd"))) {
    Write-Host "Installing from local repository directory..." -ForegroundColor Green
    Copy-Item (Join-Path $ScriptDir "bin\*") $BinDir -Recurse -Force
    if (Test-Path (Join-Path $ScriptDir "runtime\*")) {
        Copy-Item (Join-Path $ScriptDir "runtime\*") $RuntimeDir -Recurse -Force
    }
} else {
    Write-Host "Cloning Rubix toolchain from GitHub..." -ForegroundColor Green
    $TempClone = Join-Path $env:TEMP ("rubix_clone_" + [System.Guid]::NewGuid().ToString())
    git clone https://github.com/tek-sys-hub/Rubix-Mobile-Framework-2.0.git $TempClone
    Copy-Item (Join-Path $TempClone "bin\*") $BinDir -Recurse -Force
    Copy-Item (Join-Path $TempClone "runtime\*") $RuntimeDir -Recurse -Force
    Remove-Item -Recurse -Force $TempClone
}

# Add to User Environment Variable PATH
$UserPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$BinDir*") {
    Write-Host "Adding $BinDir to User Environment PATH..." -ForegroundColor Yellow
    $NewPath = "$UserPath;$BinDir"
    [System.Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    $env:Path = "$env:Path;$BinDir"
    Write-Host "Successfully added to Windows Environment Variables!" -ForegroundColor Green
} else {
    Write-Host "Rubix is already in User PATH." -ForegroundColor Gray
}

# Install VS Code Extension if VS Code is available
if (Get-Command code -ErrorAction SilentlyContinue) {
    $VsixPath = Join-Path $ScriptDir "editors\vscode\rubix-lang-1.0.0.vsix"
    if (-not (Test-Path $VsixPath)) {
        $VsixPath = Join-Path $RubixDir "editors\vscode\rubix-lang-1.0.0.vsix"
    }
    if (Test-Path $VsixPath) {
        Write-Host "Installing Rubix VS Code Extension..." -ForegroundColor Green
        code --install-extension $VsixPath --force | Out-Null
    }
}

Write-Host ""
Write-Host "Testing Rubix Windows CLI..." -ForegroundColor Cyan
& (Join-Path $BinDir "rubix.cmd") --version

Write-Host ""
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "Please restart your PowerShell or Command Prompt to apply PATH changes." -ForegroundColor Cyan
Write-Host "Test by running: rubix --version" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
