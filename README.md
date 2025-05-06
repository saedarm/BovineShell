# BovineShell 🐮🔊

> The Windows Terminal Cow That Actually Speaks!

BovineShell brings your terminal to life by combining the classic cowsay ASCII art with Windows text-to-speech capabilities. Now your terminal cows don't just display messages - they speak them out loud!



## Quick Install

### Option 1: One-Line Install (Recommended)

Copy and paste this one-liner in PowerShell to install everything:

```powershell
iex (iwr -useb https://github.com/saedarm/BovineShell/blob/main/Install.ps1
```

This script will:
1. Install Scoop if it's not already installed
2. Add the BovineShell bucket
3. Install BovineShell and its dependencies

### Option 2: Manual Install

If you prefer to install step-by-step:

```powershell
# Install Scoop if you don't have it
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Install cowsay (dependency)
scoop install cowsay

# Add the BovineShell bucket
scoop bucket add BovineShell https://github.com/saedarm/BovineShell

# Install BovineShell
scoop install BovineShell
```

## Basic Usage

```powershell
BovineShell "Hello, I can talk!"
```

This displays an ASCII cow and speaks the message using your default Windows voice.

## Advanced Examples

### Different Characters

```powershell
BovineShell -Message "I am a penguin" -Character tux
BovineShell -Message "Roar!" -Character dragon
```

To see all available characters:
```powershell
cowsay -l
```

### Voice Options

BovineShell uses the Windows System.Speech capabilities which come with the following voices pre-installed:

- **Microsoft David Desktop** - Male English (US) voice
- **Microsoft Zira Desktop** - Female English (US) voice 
- **Microsoft Mark Desktop** - Male English (US) voice (on some systems)

These voices are available immediately without any additional setup.

Change the voice:
```powershell
BovineShell -Message "I sound different now" -Voice "Microsoft Zira Desktop"
```

List available voices on your system:
```powershell
BovineShell-voices
```

### Adding More Voices

Want more variety in your talking cows? You can add additional voices to Windows:

1. **Through Windows Settings**:
   - Open Settings > Time & Language > Speech
   - Under "Voices", click "Add voices"
   - Select additional languages to install their voices

2. **Language Packs**:
   - Open Settings > Time & Language > Language
   - Add a language with text-to-speech capabilities
   - After installation, the new voices will be available

3. **Third-Party Voices**:
   - You can install third-party SAPI 5-compatible voices from providers like:
     - Ivona
     - CereProc
     - Acapela
     - Cepstral

### Speech Speed

```powershell
# Slow speech
BovineShell -Message "I am speaking very slowly" -Speed -8

# Fast speech
BovineShell -Message "I am speaking very quickly" -Speed 8
```

## Hilarious Examples

The Dramatic Movie Trailer:
```powershell
BovineShell "In a world where terminals are silent, one cow dares to speak. BovineShell - coming to command prompts near you." -Voice "Microsoft David Desktop" -Speed -3 -Character dragon
```

The Existential Cow:
```powershell
BovineShell "Sometimes I wonder if I'm real or just an ASCII representation of a bovine entity. Do I exist only when someone runs a command?" -Character cow -Speed -2
```

The Ultimate System Report:
```powershell
"Hello $env:saedarm! I've noticed you're running Windows $((Get-WmiObject -Class Win32_OperatingSystem).Version) on this $((Get-WmiObject -Class Win32_ComputerSystem).Model). You have $((Get-WmiObject -Class Win32_ComputerSystem).NumberOfProcessors) processor(s) and $(((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB).ToString('F2')) GB of RAM. That's $(if ((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB -gt 16) {'quite impressive'} else {'not too shabby'})!" | BovineShell -Character tux
```

## Practical Uses

- Add audio notifications to scripts
- Make your PowerShell profile greet you when you open a terminal
- Use as an alarm or timer notification
- Create entertaining presentations
- Improve accessibility with audio feedback

## Requirements

- Windows 10/11
- PowerShell 5.1+
- Internet connection (for installation only)

## License

MIT

---

Made with ❤️ for the terminal
