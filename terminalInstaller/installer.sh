#!/bin/bash

#Author: Juan Jose Solorzano
#Description: This script installs terminal settings and configurations, 
#             including Powerlevel10k, Hack Nerd Fonts, and various dependencies. 
# mail: juanjose.solorzano.c@gmail.com

# Constants
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
MAGENTA='\e[36m'
NC='\e[0m' # No Color

separator="------------------------------------------------------------"
packages=("curl" "locate" "git" "kitty" "unzip" "zsh" "zsh-syntax-highlighting" "zsh-autosuggestions" "lsd", "bat")
p10k="powerlevel10k"
linuxConfig="LinuxConfigurationFiles"
hackFont="HackNerdFont"
declare -A repos=(
    ["$p10k"]="https://github.com/romkatv/powerlevel10k.git"
    ["$linuxConfig"]="https://github.com/JuanJoseSolorzano/LinuxConfigurationFiles.git"
    ["$hackFont"]="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
)

function printc {
    message=$2 
    color=$1
    case $color in
        "r")
            _color=$RED
        ;;
        "g")
            _color=$GREEN
        ;;
        "y")
            _color=$YELLOW
        ;;
        "m")
            _color=$MAGENTA
        ;;
        *)
            echo -e "${RED} No valid color ${NC}"
    esac 
    echo -e "${_color} $message"
}

if ! command -v sudo &>/dev/null; then
    echo -e "[!] sudo is required to run this script."
    exit 1
fi

# install dependencies (git/locate/curl)
printc m "$separator"
printc m "_> Dependencies Installation...."
printc m "$separator"

echo -e "${MAGENTA}"
sudo apt update && sudo apt upgrade -y # Update the package lists and upgrade existing packages
## Installing packages
for package in "${packages[@]}"; do
    if ! dpkg -s "$package" &>/dev/null; then
        {
            printc m "$separator"
            printc m "Installing $package..."
            printc m "$separator"
            echo -e "${MAGENTA}"
            sudo apt install -y "$package"
            printc g "$separator"
            printc g "[+] - $package installed "
            printc g "$separator"
            sleep 2
        } || {
            printc r "$separator"
            printc r "[!] Error --> in $repo"
            printc r "$separator"
            exit 1
        }
        
    else
        printc g "------------------------------------------------------------"
        printc g "[+] $package is already installed."
        printc g "------------------------------------------------------------"
    fi
done

# Cloning repositories and setting up configurations.
for repo in "${!repos[@]}"; do
    printc m "$separator"
    printc m "[*] Cloning $repo..."
    printc m "$separator"
    if [[ "$repo" == "$hackFont" ]]; then
        { # Try - Catch block
            curl -L "${repos[$repo]}" --output ~/"$repo.zip"
            sleep 1
            sudo unzip ~/"$repo.zip" -d /usr/share/fonts
            sleep 1
            sudo rm -rf ~/"$repo.zip"
            printc g "$separator"
            printc g "[+] - Nerd Fonts installed"
            printc g "$separator"
        } || {
            printc r "$separator"
            printc r "[!] Error --> in $repo"
            printc r "$separator"
            exit 1
        }
    else
        {
            echo -e "${MAGENTA}"
            git clone --depth=1 "${repos[$repo]}" ~/"$repo"
        } || {

            printc r "$separator"
            printc r "[!] Error --> in Cloning $repo"
            printc r "$separator"
            exit 1
        }
        if [[ "$repo" == "$p10k" ]]; then
            echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
            printc g "$separator"
            printc g "[+] - $repo installed."
            printc g "$separator"
        elif [[ "$repo" == "$linuxConfig" ]]; then
            sleep 1
            {
                cp ~/$linuxConfig/rcfiles/.zshrc ~/
                cp ~/$linuxConfig/rcfiles/.bashrc ~/
                cp -rf ~/$linuxConfig/kitty ~/.config/
                rm -rf ~/$linuxConfig
                printc g "$separator"
                printc g "[+] - $repo installed."
                printc g "$separator"
            } || {
                printc r "$separator"
                printc r "[!] Error --> in $repo"
                printc r "$separator"
                exit 1
            } 
        fi
    fi
    sleep 2
done

printc g "***************************************************************"
printc g "Terminal Settings and Configurations have been installed."
printc g "***************************************************************"

