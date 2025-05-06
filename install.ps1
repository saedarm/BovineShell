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
        scoop bucket add bovineshell https://github.com/yourusername/bovineshell
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

# Display usage information
Write-Host "
╔═══════════════════════════════════════╗
║         Installation Complete!        ║
╚═══════════════════════════════════════╝
" -ForegroundColor Cyan

Write-Host "Try BovineShell now with: " -NoNewline
Write-Host "bovineshell 'Hello, I can talk!'" -ForegroundColor Yellow

Write-Host "
More examples:
- Different character: " -NoNewline
Write-Host "bovineshell -Message 'Penguin here' -Character tux" -ForegroundColor Yellow
Write-Host "- Movie trailer voice: " -NoNewline
Write-Host "bovineshell 'In a world...' -Speed -3" -ForegroundColor Yellow
Write-Host "- See all available voices: " -NoNewline
Write-Host "bovineshell-voices" -ForegroundColor Yellow

Write-Host "
For more information and examples, visit: https://github.com/yourusername/bovineshell
" -ForegroundColor Cyan

# Test BovineShell with a welcoming message
Write-Host "Launching BovineShell with a welcome message..." -ForegroundColor Magenta
bovineshell "Installation complete! BovineShell is ready to use!"
