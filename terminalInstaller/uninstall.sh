#!/bin/bash

# REMOVE KITTY
echo "-----------------------------------------------"
echo " > Removing Kitty Terminal"
echo "-----------------------------------------------"
sudo apt purge --auto-remove kitty -y
sudo apt autoremove -y
sudo apt autoclean -y
rm -rf ~/.config/kitty
sleep 3

# REMOVE HACK NERD FONTS
echo "-----------------------------------------------"
echo " > Removing Zsh"
echo "-----------------------------------------------"
rm -rf /usr/share/fonts/HackNerdFont*
rm -rf /usr/share/fonts/*.md
sleep 3

# REMOVE ZSH
echo "-----------------------------------------------"
echo " > Removing Zsh"
echo "-----------------------------------------------"
sudo apt purge zsh -y
sudo apt autoremove -y
sudo rm -rf /usr/local/share/zsh
sudo rm -f /usr/local/bin/zsh
sudo apt purge zsh-common -y
sudo apt autoremove -y
sudo rm -rf /usr/local/share/zsh
sleep 3

# REMOVE POWERLEVEL10K
echo "-----------------------------------------------"
echo " > Removing PowerLevel10K"
echo "-----------------------------------------------"
rm -rf ~/powerlevel10k
rm -f ~/.zshrc
rm -f ~/.p10k.zsh
sleep 3

echo "***************************************************************"
echo "Terminal Settings and Configurations have been uninstalled."
echo "***************************************************************"
