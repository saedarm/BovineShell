<#
.SYNOPSIS
BovineShell - A talking cow for your Windows terminal

.DESCRIPTION
BovineShell combines the classic cowsay ASCII art with Windows text-to-speech capabilities.
It displays an ASCII cow (or other character) that speaks your message using the Windows speech synthesis engine.

.PARAMETER Message
The message for the cow to say (default: "Moo! I can talk!")

.PARAMETER Voice
The voice to use (run bovineshell-voices.ps1 to see available voices)

.PARAMETER Speed
Speech rate from -10 (very slow) to 10 (very fast)

.PARAMETER Character
The character to display (e.g., cow, tux, dragon, etc.)
To see all available characters, run 'cowsay -l'

.EXAMPLE
bovineshell "Hello, I can talk!"

.EXAMPLE
bovineshell -Message "I am a penguin" -Character tux -Speed 2

.EXAMPLE
Get-Date | bovineshell

.NOTES
Author: Your Name
Version: 1.0
Requires: Windows 10/11, PowerShell 5.1+, cowsay (via Scoop)
#>

param(
    [Parameter(Position=0, ValueFromPipeline=$true, Mandatory=$false)]
    [string]$Message = "Moo! I can talk!",
    
    [Parameter(Mandatory=$false)]
    [string]$Voice = "",
    
    [Parameter(Mandatory=$false)]
    [ValidateRange(-10, 10)]
    [int]$Speed = 0,
    
    [Parameter(Mandatory=$false)]
    [string]$Character = "cow"
)

begin {
    # Check if cowsay is installed
    try {
        $null = Get-Command cowsay -ErrorAction Stop
    }
    catch {
        Write-Error "Error: cowsay is not installed or not in your PATH. Please install it via Scoop: scoop install cowsay"
        exit 1
    }
    
    # Function to get cowsay output
    function Get-CowsayOutput {
        param (
            [string]$Text,
            [string]$Character
        )
        
        $cowsayArgs = @()
        if ($Character -ne "cow") {
            $cowsayArgs += "-f"
            $cowsayArgs += $Character
        }
        $cowsayArgs += $Text
        
        try {
            $output = & cowsay @cowsayArgs
            return $output
        }
        catch {
            Write-Error "Error running cowsay: $_"
            exit 1
        }
    }
    
    # Initialize speech synthesis
    try {
        Add-Type -AssemblyName System.Speech
        $script:synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
        
        # Set voice if specified
        if ($Voice -ne "") {
            try {
                $availableVoices = $script:synth.GetInstalledVoices().VoiceInfo.Name
                if ($availableVoices -contains $Voice) {
                    $script:synth.SelectVoice($Voice)
                }
                else {
                    Write-Warning "Voice '$Voice' not found. Available voices: $($availableVoices -join ', ')"
                    Write-Warning "Using default voice instead."
                }
            }
            catch {
                Write-Warning "Error selecting voice: $_"
                Write-Warning "Using default voice instead."
            }
        }
        
        # Set speech rate
        $script:synth.Rate = $Speed
    }
    catch {
        Write-Error "Error initializing speech synthesis: $_"
        Write-Warning "Speech functionality will be disabled."
        $script:speechEnabled = $false
    }
}

process {
    # If input is from pipeline, ensure it's converted to string
    if ($_ -ne $null) {
        $Message = $_.ToString()
    }
    
    # Display the cow with the message
    $cowOutput = Get-CowsayOutput -Text $Message -Character $Character
    Write-Output $cowOutput
    
    # Speak the message
    if ($script:synth -ne $null) {
        try {
            $script:synth.Speak($Message)
        }
        catch {
            Write-Error "Error speaking message: $_"
        }
    }
}

end {
    # Clean up speech synthesis resources
    if ($script:synth -ne $null) {
        $script:synth.Dispose()
    }
}
