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
For more information and examples, visit: https://github.com/saedarm/bovineshell
" -ForegroundColor Cyan

# Try to run BovineShell directly from its installed location
Write-Host "Launching BovineShell with a welcome message..." -ForegroundColor Magenta
try {
    # Find installation path
    $installPath = scoop prefix bovineshell
    if (Test-Path "$installPath\BovineShell.ps1") {
        & "$installPath\BovineShell.ps1" "Installation complete! BovineShell is ready to use!"
        Write-Host "`nNOTE: You may need to restart your PowerShell session for the 'bovineshell' command to work globally." -ForegroundColor Yellow
    } else {
        Write-Host "BovineShell script not found at expected location. Please restart your PowerShell session and try running 'bovineshell' directly." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Could not run BovineShell directly. Please restart your PowerShell session and try running 'bovineshell' directly." -ForegroundColor Yellow
}
