#!/bin/bash

#   ---Variables---
requirements=$(curl  -s "https://raw.githubusercontent.com/Hjack737/Ubuntu-Start-Script/refs/heads/main/requirements.txt")
Apps=$(curl  -s "https://raw.githubusercontent.com/Hjack737/Ubuntu-Start-Script/refs/heads/main/apps.txt")
APP_NAME=""
NO_APP=false


if [[ $EUID -ne 0 ]]; then
   echo "Please run this Program as root :3" 
   exit 1
fi

#---check added variables--
while [[ $# -gt 0 ]]; do
  case "$1" in
    -noapp)
      NO_APP=true
      if [[ -n "$2" && "$2" != -* ]]; then
        APP_NAME="$2"
        shift 2 
      else
        shift 1 
      fi
      ;;
  esac
done


sudo add-apt-repository ppa:neovim-ppa/stable #neovim

sudo apt update && sudo apt upgrade -y

#   ---Install Requirments---
for item in $requirements 
do
    
    if [[ "$APP_NAME" != *"$item"* ]]; then
        if ! dpkg -s "$item" &> /dev/null; then
            echo "Installing $item..."
            sudo apt install "$item" -y
        else
            echo "$item is installed"
        fi 
    fi 
done
#   ---Install Apps---
for item in $Apps 
do
    if ! dpkg -s "$item" &> /dev/null; then
        echo "Installing $item..."
        sudo apt install $item -y
    else
        echo "$item is installed"
    fi
done

# ---Configure neovim---

if [[ "$APP_NAME" != *"neovim"* ]]; then
        if ! dpkg -s "$item" &> /dev/null; then
            echo "Installing $item..."
            sudo apt install "$item" -y
        else
            echo "$item is installed"
        fi 


    if [[ ! -e "~/.config/nvim" ]]; then
        sudo mkdir -p ~/.config/nvim
    fi
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git

    # --Terminal setup---
    wget "https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip"
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip"

    sudo unzip "./JetBrainsMono-1.0.3.zip"
    sudo cp "./JetBrainsMono-1.0.3/ttf/*" "~/.fonts"
    sudo unzip "FiraCode.zip" -d ~/.fonts
    sudo unzip "CascadiaCode.zip" -d ~/.fonts
    sudo rm -rf ./JetBrainsMono-1.0.3.zip
    sudo rm -rf ./JetBrainsMono-1.0.3
    sudo rm -rf ./FiraCode.zip
    sudo rm -rf ./CascadiaCode.zip
    fc-cache -f -v

    cd $HOME


    git clone "https://github.com/marlonrichert/zsh-autocomplete"
    sudo touch ~/.zshrc
    cat << 'EOF' | tee ~/.zshrc

    eval "$(starship init zsh)"

    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh
EOF

    wget -O StarShipInstall-HJ.sh  https://starship.rs/install.sh
    chmod +x StarShipInstall-HJ.sh
    sudo ./StarShipInstall-HJ.sh -y

    zshPth=$(which zsh)

    read -p "Which Starship theme do you want?: 
    1) tokyo-night
    2) gruvbox-rainbow
    3) catppuccin-powerline
    (default 1): " starshippreset

    if [[ $starshippreset == "1" ]]; then
        starshippreset="tokyo-night"
    elif [[ $starshippreset == "2" ]]; then
        starshippreset="gruvbox-rainbow"
    elif [[ $starshippreset == "3" ]]; then
        starshippreset="catppuccin-powerline"
    else 
        echo "Kein Valider Preset"
    fi

    starship preset $starshippreset -o ~/.config/starship.toml
fi 