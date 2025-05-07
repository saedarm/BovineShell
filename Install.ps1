# BovineShell Installer Script
# This script installs Scoop if needed, then installs BovineShell and its dependencies

Write-Host "
╔═══════════════════════════════════════╗
║         BovineShell Installer         ║
║  The Windows Terminal Cow That Speaks ║
╚═══════════════════════════════════════╝
" -ForegroundColor Cyan

# Function to check if a command exists
function Test-CommandExists {
    param ($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Step 1: Install Scoop if it's not already installed
if (-not (Test-CommandExists "scoop")) {
    Write-Host "Step 1: Installing Scoop package manager..." -ForegroundColor Yellow
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        Write-Host "✓ Scoop installed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to install Scoop. Error: $_" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "✓ Scoop is already installed." -ForegroundColor Green
}

# Step 2: Install cowsay (dependency)
if (-not (Test-CommandExists "cowsay")) {
    Write-Host "Step 2: Installing cowsay dependency..." -ForegroundColor Yellow
    try {
        scoop install cowsay
        Write-Host "✓ cowsay installed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to install cowsay. Error: $_" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "✓ cowsay is already installed." -ForegroundColor Green
}

# Step 3: Add the BovineShell bucket if it doesn't exist
Write-Host "Step 3: Adding BovineShell bucket to Scoop..." -ForegroundColor Yellow
$bucketExists = $false
$buckets = scoop bucket list
if ($buckets -match "bovineshell") {
    $bucketExists = $true
}

if (-not $bucketExists) {
    try {
        scoop bucket add bovineshell https://github.com/saedarm/BovineShell
        Write-Host "✓ BovineShell bucket added successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to add BovineShell bucket. Error: $_" -ForegroundColor Red
        exit 1
    }
}
else {
    Write-Host "✓ BovineShell bucket is already added." -ForegroundColor Green
}

# Step 4: Install BovineShell
Write-Host "Step 4: Installing BovineShell..." -ForegroundColor Yellow
try {
    scoop install bovineshell
    Write-Host "✓ BovineShell installed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "✗ Failed to install BovineShell. Error: $_" -ForegroundColor Red
    exit 1
}

# Display installation completion message
Write-Host "
╔═══════════════════════════════════════╗
║         Installation Complete!        ║
╚═══════════════════════════════════════╝
" -ForegroundColor Cyan

Write-Host "IMPORTANT: You need to restart your PowerShell session before using BovineShell." -ForegroundColor Yellow

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
For more information and examples, visit: https://github.com/saedarm/BovineShell
" -ForegroundColor Cyan

# Do NOT try to run the command here as it won't be available until PowerShell is restarted
Write-Host "Please restart your PowerShell session now to start using BovineShell." -ForegroundColor Magenta
