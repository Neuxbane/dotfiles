#!/usr/bin/env bash
# install.sh - Interactive installer for bpswm dotfiles
#
# Features:
# - Interactive menu for initial setup
# - Saves configuration to install.conf
# - Uses symlinks for dotfiles
# - Prepares for theme and settings integration
# - Can be re-run to update config or re-link files

CONFIG_FILE="install.conf"
DOTFILES_DIR="$(pwd)"
HOME_DOTFILES="$HOME/.dotfiles"

# Dependency check and install (Arch Linux only)
REQUIRED_DEPS=(bash ln grep)
OPTIONAL_DEPS=(lemonbar polybar feh)

install_yay() {
  echo "yay not found. Installing yay..."
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay-installer
  (cd /tmp/yay-installer && makepkg -si --noconfirm)
  rm -rf /tmp/yay-installer
}

install_dep() {
  dep="$1"
  if command -v yay &>/dev/null; then
    yay -S --noconfirm "$dep"
  else
    if ! command -v pacman &>/dev/null; then
      echo "This installer only supports Arch Linux (pacman/yay). Please install $dep manually."
      return 1
    fi
    install_yay
    if command -v yay &>/dev/null; then
      yay -S --noconfirm "$dep"
    else
      echo "Failed to install yay. Please install $dep manually."
      return 1
    fi
  fi
}

check_deps() {
  echo "Checking required dependencies..."
  for dep in "${REQUIRED_DEPS[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      echo "$dep not found. Attempting to install..."
      install_dep "$dep" || { echo "Failed to install $dep. Exiting."; exit 1; }
    fi
  done
  echo "Checking optional dependencies (for full experience)..."
  for dep in "${OPTIONAL_DEPS[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
      echo "Optional: $dep not found. You may want to install it for extra features."
    fi
  done
}

check_deps

save_config() {
  echo "THEME=$THEME" > "$CONFIG_FILE"
  echo "WALLPAPER=$WALLPAPER" >> "$CONFIG_FILE"
}

load_config() {
  [ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"
}

link_dotfiles() {
  echo "Linking dotfiles..."
  mkdir -p "$HOME_DOTFILES"
  for d in framework settings themes; do
    ln -sf "$DOTFILES_DIR/$d" "$HOME_DOTFILES/$d"
  done
  ln -sf "$DOTFILES_DIR/autostart.sh.example" "$HOME_DOTFILES/autostart.sh"
  echo "Symlinks created in $HOME_DOTFILES."
}

choose_theme() {
  echo "Available themes:"
  for theme in themes/*; do
    [ -d "$theme" ] && echo "- $(basename "$theme")"
  done
  echo -n "Enter theme name: "
  read THEME
}

choose_wallpaper() {
  echo -n "Enter wallpaper path (image/video): "
  read WALLPAPER
}

main_menu() {
  echo "==== bpswm Dotfiles Installer ===="
  echo "1) Choose Theme"
  echo "2) Set Wallpaper"
  echo "3) Link Dotfiles"
  echo "4) Save Config"
  echo "5) Exit"
  echo -n "Select an option: "
}

load_config
while true; do
  main_menu
  read choice
  case $choice in
    1) choose_theme ;;
    2) choose_wallpaper ;;
    3) link_dotfiles ;;
    4) save_config ; echo "Config saved to $CONFIG_FILE" ;;
    5) echo "Exiting installer."; break ;;
    *) echo "Invalid option." ;;
  esac
done
