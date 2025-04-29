#!/usr/bin/env bash
set -euo pipefail

# Determine sudo usage
if [[ $EUID -ne 0 ]]; then
    SUDO='sudo'
else
    SUDO=''
fi

# Update package database
echo "Updating package database..."
$SUDO pacman -Sy

# Install official packages
echo "Installing official packages..."
$SUDO pacman -S --needed xorg xorg-xinit kitty alacritty rofi dunst polybar picom nitrogen flameshot \
    pulseaudio pavucontrol brightnessctl playerctl redshift neofetch btop feh thunar pcmanfm git base-devel

# Ensure yay (AUR helper) is installed
if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# Install AUR packages
echo "Installing AUR packages..."
yay -S --needed bpswm i3lock-color ttf-comic-mono-nerd ttf-quicksand ttf-jetbrains-mono-nerd \
    tela-icon-theme beautyline-icon-theme papirus-icon-theme sweet-gtk-theme sweet-cursors

# Ensure chezmoi is installed
if ! command -v chezmoi >/dev/null 2>&1; then
    echo "Installing chezmoi..."
    $SUDO pacman -S --needed chezmoi
fi

# Apply dotfiles with chezmoi from this directory
echo "Applying dotfiles with chezmoi..."
chezmoi init --apply "$PWD"

# Configure .xinitrc to start bpswm
echo "Setting up .xinitrc for bpswm..."
echo 'exec bpswm' > ~/.xinitrc

echo "\nAll done! You can now start your session with 'startx'."