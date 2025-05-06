<#
.SYNOPSIS
Lists all available text-to-speech voices for BovineShell

.DESCRIPTION
This script lists all installed text-to-speech voices on your Windows system
that can be used with BovineShell. It displays information about each voice
including name, gender, age, and culture.

.EXAMPLE
./bovineshell-voices.ps1

.NOTES
Author: Your Name
Version: 1.0
Requires: Windows 10/11, PowerShell 5.1+
#>

# Add the System.Speech assembly
Add-Type -AssemblyName System.Speech

# Create a new SpeechSynthesizer instance
$synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

# Get all installed voices
$voices = $synth.GetInstalledVoices()

# Display header with ASCII art cow
$cowArt = @"
  __________________
< Available Voices! >
  ------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"@

Write-Output $cowArt
Write-Output "`nFound $($voices.Count) installed voice(s) on your system.`n"
Write-Output "Use these voices with BovineShell by specifying the -Voice parameter:`n"
Write-Output "Example: bovineshell -Message 'Hello world' -Voice 'VOICE_NAME'`n"
Write-Output "========================================================="

# Iterate through each voice and display its information
foreach ($voice in $voices) {
    $info = $voice.VoiceInfo
    
    # Use different colors for each voice for better readability
    Write-Host "`nVOICE NAME: " -NoNewline -ForegroundColor Cyan
    Write-Host "$($info.Name)" -ForegroundColor Yellow
    
    Write-Host "Gender: " -NoNewline -ForegroundColor Cyan
    Write-Host "$($info.Gender)" -ForegroundColor White
    
    Write-Host "Age: " -NoNewline -ForegroundColor Cyan
    Write-Host "$($info.Age)" -ForegroundColor White
    
    Write-Host "Culture: " -NoNewline -ForegroundColor Cyan
    Write-Host "$($info.Culture)" -ForegroundColor White
    
    # Optionally speak a sample using this voice
    Write-Host "Sample: " -NoNewline -ForegroundColor Cyan
    Write-Host "(speaking)" -ForegroundColor Green
    
    # Select the current voice and speak a sample
    $currentVoice = $info.Name
    $synth.SelectVoice($currentVoice)
    $synth.Speak("Hello, I am $currentVoice, a voice for BovineShell.")
    
    Write-Output "--------------------------------------------------------"
}

# Display usage example with the first voice found
if ($voices.Count -gt 0) {
    $exampleVoice = $voices[0].VoiceInfo.Name
    Write-Host "`nExample command with the first voice:" -ForegroundColor Magenta
    Write-Host "bovineshell ""Hello world"" -Voice ""$exampleVoice""" -ForegroundColor Yellow
}

# Clean up
$synth.Dispose()
