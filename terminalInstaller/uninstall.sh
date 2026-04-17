#!/bin/bash

#Author: Juan Jose Solorzano
#Description: This script uninstalls terminal settings and configurations, 
#             including Powerlevel10k, Hack Nerd Fonts, and various dependencies.
# mail: juanjose.solorzano.c@gmail.com

packages=("kitty" "zsh" "zsh-syntax-highlighting" "zsh-common" "zsh-autosuggestions" "lsd")

for package in "${packages[@]}"; do
    if dpkg -s "$package" &>/dev/null; then
        echo "-----------------------------------------------"
        echo "[*] Removing $package..."
        echo "-----------------------------------------------"
        sudo apt purge --auto-remove "$package" -y
        sudo apt autoremove -y
        sudo apt autoclean -y
        echo "------------------------------------------------------------"
        echo "[+] - $package removed"
        sleep 2
        if [[ "$package" == "kitty" ]]; then
            sudo rm -rf ~/.config/kitty
        elif [[ "$package" == "zsh" ]]; then
            sudo rm -rf /usr/local/share/zsh
            sudo rm -f /usr/local/bin/zsh
            sudo rm -rf /usr/local/share/zsh
        fi
        sleep 3
    else
        echo "[!] $package is not installed."
    fi
done

# REMOVE HACK NERD FONTS
echo "-----------------------------------------------"
echo " > Removing Zsh"
echo "-----------------------------------------------"
sudo rm -rf /usr/share/fonts/HackNerdFont*
sudo rm -rf /usr/share/fonts/*.md
sleep 3
# REMOVE POWERLEVEL10K
echo "-----------------------------------------------"
echo " > Removing PowerLevel10K"
echo "-----------------------------------------------"
sudo rm -rf ~/powerlevel10k
sudo rm -f ~/.zshrc
sudo rm -f ~/.p10k.zsh
sleep 3

echo "***************************************************************"
echo "Terminal Settings and Configurations have been uninstalled."
echo "***************************************************************"
