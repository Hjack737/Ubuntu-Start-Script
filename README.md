# Ubuntu Installtion Script
#### A Quick script to get the most important things set up on a new installation
## Requirements
- Ubuntu (this probably works on other distros too)
- Internet
- root permission


## How To
1. Download the latest [Installer.sh](https://github.com/Hjack737/Ubuntu-Start-Script/releases/latest/download/installer.sh)
2. use ` chmod +x installer.sh `
3. start the installer **with root** `sudo ./installer.sh`
4.  you can also not install an app with `-noapp 'appname'`

## What does it do
### Downloaded Apps

The Script downloads often used apps like 

- unzip (to unzip files)
- zsh (for a better terminal)
- VSCode
- Localsend
- WinBoat
- neovim
- chrome (I'm trapped in this)

### configuration
This Script cofigures following applications

- LazyVim (for neovim) 
- Fonts
    - JetBrain Mono
    - FiraCode
    - CascadiaCode
- zsh plugins:
    - Autosuggestions
    - Syntax Highlighting
    - autocomplete
- starship
- Starship Themes:
    - [Tokyo night](https://starship.rs/presets/tokyo-night)
    - [Gruvbox Rainbow](https://starship.rs/presets/gruvbox-rainbow)
    - [cappuccin Powerline](https://starship.rs/presets/catppuccin-powerline)
