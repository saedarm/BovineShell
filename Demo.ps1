# MooTalk Feature Demo Script
# Run this script to see a showcase of MooTalk's capabilities

Write-Host "`n🐮 MooTalk Features Demo 🔊`n" -ForegroundColor Cyan

# Helper function to pause between demonstrations
function Wait-WithMessage {
    param (
        [int]$Seconds = 3,
        [string]$Message = "Waiting..."
    )
    
    Write-Host $Message -ForegroundColor DarkGray
    $i = 0
    while ($i -lt $Seconds) {
        Write-Host "." -NoNewline -ForegroundColor DarkGray
        Start-Sleep -Seconds 1
        $i++
    }
    Write-Host "`n"
}

# 1. Basic usage
Write-Host "1. Basic usage:" -ForegroundColor Yellow
./MooTalk.ps1 "Hello! I'm MooTalk, the talking cow for Windows!"
Wait-WithMessage -Seconds 3 -Message "Moving to next example"

# 2. Different character
Write-Host "`n2. Different character:" -ForegroundColor Yellow
./MooTalk.ps1 -Message "I can transform into other characters too!" -Character tux
Wait-WithMessage -Seconds 3 -Message "Moving to next example"

# 3. Speed control
Write-Host "`n3. Speed control:" -ForegroundColor Yellow
Write-Host "   3.1 Slow speech:" -ForegroundColor DarkYellow
./MooTalk.ps1 -Message "I can talk really slowly..." -Speed -8
Wait-WithMessage -Seconds 6 -Message "Now for fast speech"

Write-Host "   3.2 Fast speech:" -ForegroundColor DarkYellow
./MooTalk.ps1 -Message "Or super duper fast!" -Speed 8
Wait-WithMessage -Seconds 3 -Message "Moving to next example"

# 4. Different voices (if available)
Write-Host "`n4. Different voices (if available):" -ForegroundColor Yellow
$voices = (Add-Type -AssemblyName System.Speech; New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer).GetInstalledVoices().VoiceInfo.Name
if ($voices.Count -gt 1) {
    ./MooTalk.ps1 -Message "I can use different voices too!" -Voice $voices[1]
}
else {
    ./MooTalk.ps1 -Message "I would show different voices, but only one is installed on this system."
}
Wait-WithMessage -Seconds 3 -Message "Moving to next example"

# 5. Using pipeline
Write-Host "`n5. Using pipeline input:" -ForegroundColor Yellow
Get-Date | ./MooTalk.ps1
Wait-WithMessage -Seconds 3 -Message "Moving to next example"

# 6. The dad joke
Write-Host "`n6. Dad joke time:" -ForegroundColor Yellow
./MooTalk.ps1 "I'm afraid for the calendar. Its days are numbered." -Character sheep
Wait-WithMessage -Seconds 3 -Message "Moving to grand finale"

# 7. The finale - dramatic movie trailer
Write-Host "`n7. The finale - dramatic movie trailer:" -ForegroundColor Yellow
./MooTalk.ps1 "In a world where terminals are silent... one cow dares to speak. MooTalk - it's not just ASCII anymore." -Speed -3 -Character dragon

Write-Host "`n🎉 Demo complete! 🎉`n" -ForegroundColor Green
Write-Host "Check out more examples and usage options in the README.md file."
Write-Host "Visit https://github.com/yourusername/mootalk for updates and contributions."
