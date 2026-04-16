#!/bin/bash

#Author: Juan Jose Solorzano
#Description: This script installs terminal settings and configurations, 
#             including Powerlevel10k, Hack Nerd Fonts, and various dependencies. 
# mail: juanjose.solorzano.c@gmail.com

if ! command -v sudo &>/dev/null; then
    echo "sudo is required to run this script."
    exit 1
fi

packages=("curl" "locate" "git" "kitty" "unzip" "zsh" "zsh-syntax-highlighting" "zsh-autosuggestions" "lsd" "ls-remote")
p10k="powerlevel10k"
linuxConfig="LinuxConfigurationFiles"
hackFont="HackNerdFont"
declare -A repos=(
    ["$p10k"]="https://github.com/romkatv/powerlevel10k.git"
    ["$linuxConfig"]="https://github.com/JuanJoseSolorzano/LinuxConfigurationFiles.git"
    ["$hackFont"]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
)

# install dependencies (git/locate/curl)
echo "------------------------------------------------------------"
echo "_> Dependencies Installation...."
echo "------------------------------------------------------------"

sudo apt update && sudo apt upgrade -y # Update the package lists and upgrade existing packages
# Installing packages
for package in "${packages[@]}"; do
    if ! dpkg -s "$package" &>/dev/null; then
        echo "Installing $package..."
        sudo apt install -y "$package"
        echo "------------------------------------------------------------"
        echo "[+] - $package installed"
        sleep 2
    else
        echo "[!] $package is already installed."
    fi
done
# Cloning repositories and setting up configurations.
for repo in "${!repos[@]}"; do
    if ! git ls-remote "${repos[$repo]}" &>/dev/null; then
        echo "[*] Cloning $repo..."
        if [[ "$repo" == "$hackFont" ]]; then
            curl -OL "$repo"
            sleep 1
            unzip Hack.zip -d /usr/share/fonts
            sleep 1
            rm -rf ~/Hack.zip
            echo "[+] - Nerd Fonts installed"
        else
            git clone --depth=1 "${repos[$repo]}" ~/$repo
            if [[ "$repo" == "$p10k" ]]; then
                echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
                echo "[+] - Powerlevel10k installed."
            elif [[ "$repo" == "$linuxConfig" ]]; then
                sleep 1
                cp ~/$linuxConfig/rcfiles/.zshrc ~/
                cp ~/$linuxConfig/rcfiles/.bashrc ~/
                cp -rf ~/$linuxConfig/kitty ~/.config/
                rm -rf ~/$linuxConfig
            fi
        fi
        echo "------------------------------------------------------------"
        sleep 2
    else
        echo "[!] $repo not found or already cloned."
    fi
done

echo "***************************************************************"
echo "Terminal Settings and Configurations have been installed."
echo "***************************************************************"

