#!/bin/bash

# install dependencies (git/locate/curl)
echo "------------------------------------------------------------"
echo "Dependencies Installation...."
echo "------------------------------------------------------------"
sudo apt update && sudo apt upgrade -y && sudo apt install curl
echo "------------------------------------------------------------"
echo "[+] - Curl installed"
sleep 2
sudo apt install locate -y
echo "------------------------------------------------------------"
echo "[+] - Locate installed"
sleep 2
sudo apt install git
echo "------------------------------------------------------------"
echo "[+] - Git installed"
sleep 2
# KITTY TERMINAL
sudo apt install kitty -y
echo "------------------------------------------------------------"
echo "[+] - Kitty Terminal installed"
sleep 2
# Nerd Fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
sleep 1
sudo 7z x Hack.zip -o/usr/share/fonts
sleep 1
rm -rf Hack.zip
echo "------------------------------------------------------------"
echo "[+] - Nerd Fonts installed"
sleep 2
# ZSH SHELL
sudo apt install zsh -y
sleep 2
sudo apt install zsh-syntax-highlighting
sleep 2
sudo apt install zsh-autosuggestions
sleep 2
sudo apt install lsd # icons
sleep 2
echo "------------------------------------------------------------"
echo "[+] - ZSH installed."
sleep 2
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
sleep 2
echo "------------------------------------------------------------"
echo "[+] - Powerlevel10k installed."

git clone https://github.com/JuanJoseSolorzano/LinuxConfigurationFiles.git
sleep 1
cp LinuxConfigurationFiles/rcfiles/.zshrc ~/ 
cp LinuxConfigurationFiles/rcfiles/.bashrc ~/ 
sleep 1
cp -rf LinuxConfigurationFiles/kitty ~/.config/
rm -rf LinuxConfigurationFiles

echo "***************************************************************"
echo "Terminal Settings and Configurations have been installed."
echo "***************************************************************"

