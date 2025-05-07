# BovineShell Direct Installer
# This script installs BovineShell directly without using Scoop

Write-Host "
╔═══════════════════════════════════════╗
║       BovineShell Direct Install      ║
║  The Windows Terminal Cow That Speaks ║
╚═══════════════════════════════════════╝
" -ForegroundColor Cyan

# Create installation directory
$installDir = "$env:USERPROFILE\BovineShell"
if (-not (Test-Path $installDir)) {
    Write-Host "Creating installation directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

# Function to check if cowsay is installed
function Test-CowsayExists {
    return $null -ne (Get-Command cowsay -ErrorAction SilentlyContinue)
}

# Install cowsay if needed
if (-not (Test-CowsayExists)) {
    Write-Host "Installing cowsay dependency..." -ForegroundColor Yellow
    if ($null -ne (Get-Command scoop -ErrorAction SilentlyContinue)) {
        scoop install cowsay
        Write-Host "✓ cowsay installed via Scoop" -ForegroundColor Green
    } else {
        Write-Host "! Scoop not found. Please install cowsay manually." -ForegroundColor Red
        Write-Host "  You can install it by running: " -NoNewline
        Write-Host "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; iwr -useb get.scoop.sh | iex; scoop install cowsay" -ForegroundColor Yellow
        $continue = Read-Host "Continue anyway? (y/n)"
        if ($continue -ne "y") {
            Write-Host "Installation aborted." -ForegroundColor Red
            exit
        }
    }
}

# Download the main script
Write-Host "Downloading BovineShell scripts..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/saedarm/BovineShell/main/BovineShell.ps1" -OutFile "$installDir\BovineShell.ps1"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/saedarm/BovineShell/main/Voices.ps1" -OutFile "$installDir\Voices.ps1"
    Write-Host "✓ Scripts downloaded successfully" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to download scripts. Error: $_" -ForegroundColor Red
    exit 1
}

# Create shortcut functions in PowerShell profile
$profileContent = @"

# BovineShell Functions
function bovineshell { & "$installDir\BovineShell.ps1" @args }
function bovineshell-voices { & "$installDir\Voices.ps1" @args }

"@

# Check if profile exists, create if it doesn't
if (-not (Test-Path $PROFILE)) {
    Write-Host "Creating PowerShell profile..." -ForegroundColor Yellow
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

# Add functions to profile
Write-Host "Adding BovineShell to PowerShell profile..." -ForegroundColor Yellow
Add-Content -Path $PROFILE -Value $profileContent
Write-Host "✓ Profile updated successfully" -ForegroundColor Green

# Display installation completion message
Write-Host "
╔═══════════════════════════════════════╗
║         Installation Complete!        ║
╚═══════════════════════════════════════╝
" -ForegroundColor Cyan

Write-Host "IMPORTANT: You need to restart your PowerShell session to start using BovineShell." -ForegroundColor Yellow

Write-Host "`nAfter restarting PowerShell, try BovineShell with: " -NoNewline
Write-Host "bovineshell 'Hello, I can talk!'" -ForegroundColor Green

Write-Host "
More examples:
- Different character: " -NoNewline
Write-Host "bovineshell -Message 'Penguin here' -Character tux" -ForegroundColor Green
Write-Host "- Movie trailer voice: " -NoNewline
Write-Host "bovineshell 'In a world...' -Speed -3" -ForegroundColor Green
Write-Host "- See all available voices: " -NoNewline
Write-Host "bovineshell-voices" -ForegroundColor Green

Write-Host "
Installation directory: $installDir
" -ForegroundColor Cyan

Write-Host "Please restart your PowerShell session now to start using BovineShell." -ForegroundColor Magenta
