BovineShell 🐮🔊

The Windows Terminal Cow That Actually Speaks!

BovineShell brings your terminal to life by combining the classic cowsay ASCII art with Windows text-to-speech capabilities. Now your terminal cows don't just display messages - they speak them out loud!
Show Image
Quick Install
Copy and paste this one-liner in PowerShell to install everything:
powershelliex (iwr -useb https://raw.githubusercontent.com/saedarm/BovineShell/main/DirectInstall.ps1)
This script will:

Install cowsay if needed
Download BovineShell scripts to your user profile
Set up the necessary command shortcuts

IMPORTANT: After installation, restart your PowerShell session to start using BovineShell.
Basic Usage
powershellbovineshell "Hello, I can talk!"
This displays an ASCII cow and speaks the message using your default Windows voice.
Available Characters
BovineShell can display any of these characters (instead of the default cow):
beavis.zen    bong          cower         dragon-and-cow  flaming-sheep  kitty          moofasa        ren            stegosaurus    tux
bud-frogs     bunny         daemon        elephant        ghostbusters   koala          moose          satanic        stimpy         udder
cheese        calvin        default       elephant-in-snake  head-in      kosh           mutilated      sheep          suse           vader-koala
cock          cock-and-bail dragon        eyes             hellokitty    luke-koala     pony           skeleton       three-eyes     vader
cow           cow-and-bull  dragon2       fat-cow         kiss           mech-and-cow   pumpkin        snowman        turkey         www
To use a different character:
powershellbovineshell -Message "I am a penguin" -Character tux
bovineshell -Message "Roar!" -Character dragon
To see the list of available characters:
powershellcowsay -l
Voice Options
BovineShell uses the Windows System.Speech capabilities which come with the following voices pre-installed:

Microsoft David Desktop - Male English (US) voice
Microsoft Zira Desktop - Female English (US) voice
Microsoft Mark Desktop - Male English (US) voice (on some systems)

These voices are available immediately without any additional setup.
Change the voice:
powershellbovineshell -Message "I sound different now" -Voice "Microsoft Zira Desktop"
List available voices on your system:
powershellbovineshell-voices
Adding More Voices
Want more variety in your talking cows? You can add additional voices to Windows:

Through Windows Settings:

Open Settings > Time & Language > Speech
Under "Voices", click "Add voices"
Select additional languages to install their voices


Language Packs:

Open Settings > Time & Language > Language
Add a language with text-to-speech capabilities
After installation, the new voices will be available



Speech Speed
powershell# Slow speech (dramatic effect)
bovineshell -Message "I am speaking very slowly" -Speed -8

# Fast speech (excitement)
bovineshell -Message "I am speaking very quickly" -Speed 8
Fun Examples
The Movie Trailer Voice
powershellbovineshell "In a world where terminals are silent, one cow dares to speak. BovineShell - coming to command prompts near you." -Voice "Microsoft David Desktop" -Speed -3 -Character dragon
The Koala Greeter
powershellbovineshell "G'day mate! I'm a koala, not a cow. I prefer eucalyptus leaves over grass any day!" -Character koala -Voice "Microsoft Zira Desktop" -Speed 1
The Existential Cow
powershellbovineshell "Sometimes I wonder if I'm real or just an ASCII representation of a bovine entity. Do I exist only when someone runs a command?" -Character cow -Speed -2
The System Reporter
powershell$uptime = (Get-Uptime).TotalHours
$uptimeRounded = [math]::Round($uptime, 2)
bovineshell "Your computer has been running for $uptimeRounded hours without a break. Maybe it's time for some udderly refreshing rest?" -Character cow
The Ultimate System Report
powershell"Hello $env:USERNAME! I've noticed you're running Windows $((Get-WmiObject -Class Win32_OperatingSystem).Version) on this $((Get-WmiObject -Class Win32_ComputerSystem).Model). You have $((Get-WmiObject -Class Win32_ComputerSystem).NumberOfProcessors) processor(s) and $(((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB).ToString('F2')) GB of RAM. That's $(if ((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory/1GB -gt 16) {'quite impressive'} else {'not too shabby'})!" | bovineshell -Character tux
Practical Uses

Add audio notifications to scripts
Make your PowerShell profile greet you when you open a terminal
Use as an alarm or timer notification
Create entertaining presentations
Improve accessibility with audio feedback

PowerShell Profile Integration
Add this to your PowerShell profile to receive a greeting each time you open a new terminal:
powershell# Add to your PowerShell profile
$hour = (Get-Date).Hour
$greeting = if ($hour -lt 12) {"Good morning"} elseif ($hour -lt 18) {"Good afternoon"} else {"Good evening"}
bovineshell "$greeting $env:USERNAME! Your terminal is ready." -Character tux
Requirements

Windows 10/11
PowerShell 5.1+
Internet connection (for installation only)

License
MIT

Made with ❤️ for the terminal
