<div align="center">

# ⚡ Terminal Installer

**One-script setup for a beautiful, powerful terminal environment on Linux.**

![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

---

## What Gets Installed

| Component | Description |
|---|---|
| [Zsh](https://www.zsh.org/) | Modern shell replacing bash |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | Blazing fast, highly customizable Zsh theme |
| [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) | Programming font with icon glyphs support |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | GPU-accelerated terminal emulator |
| [lsd](https://github.com/lsd-rs/lsd) | Modern `ls` replacement with icons and colors |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Fish-shell-like syntax highlighting for Zsh |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Command suggestions based on history |

---

## Prerequisites

- A Debian/Ubuntu-based Linux distribution
- `sudo` privileges
- Internet connection

---

## Installation

```bash
git clone https://github.com/JuanJoseSolorzano/LinuxConfigurationFiles.git
cd LinuxConfigurationFiles/terminalInstaller
chmod +x installer.sh
./installer.sh
```

The script will:

1. Update and upgrade system packages
2. Install all required dependencies
3. Clone and configure Powerlevel10k
4. Download and install Hack Nerd Fonts to `/usr/share/fonts`
5. Copy `.zshrc`, `.bashrc`, and Kitty config from the dotfiles repo

---

## Uninstallation

To cleanly remove everything that was installed:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This will:

- Purge all installed packages
- Remove Kitty config (`~/.config/kitty`)
- Remove Zsh system files
- Delete Hack Nerd Fonts from `/usr/share/fonts`
- Remove Powerlevel10k (`~/powerlevel10k`)
- Delete `~/.zshrc` and `~/.p10k.zsh`

---

## File Structure

```
terminalInstaller/
├── installer.sh      # Full setup script
└── uninstall.sh      # Clean removal script
```

---

## Author

**Juan Jose Solorzano**
📧 [juanjose.solorzano.c@gmail.com](mailto:juanjose.solorzano.c@gmail.com)

---

<div align="center">

*If this helped your setup, feel free to ⭐ the repo!*

</div>
