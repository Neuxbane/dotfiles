#!/usr/bin/env bash
# install.sh - archinstall-style guided installer for bpswm dotfiles

CONFIG_FILE="install.conf"
DOTFILES_DIR="$(pwd)"
HOME_DOTFILES="$HOME/.dotfiles"

REQUIRED_DEPS=(bash ln grep bpswm xorg-server xorg-xinit)
OPTIONAL_DEPS=(lemonbar polybar feh picom dmenu rofi)

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
  echo "[Step 1/5] Checking required dependencies..."
  local missing=()
  for dep in "${REQUIRED_DEPS[@]}"; do
    if ! command -v "$dep" &>/dev/null && ! pacman -Qq "$dep" &>/dev/null; then
      echo "$dep not found. Attempting to install..."
      install_dep "$dep" || { echo "Failed to install $dep. Exiting."; exit 1; }
      missing+=("$dep")
    fi
  done
  if [ ${#missing[@]} -eq 0 ]; then
    echo "All required dependencies are installed."
  else
    echo "Installed missing dependencies: ${missing[*]}"
  fi
  echo "Checking optional dependencies (for full experience)..."
  for dep in "${OPTIONAL_DEPS[@]}"; do
    if ! command -v "$dep" &>/dev/null && ! pacman -Qq "$dep" &>/dev/null; then
      echo "Optional: $dep not found. You may want to install it for extra features."
    fi
  done
}

save_config() {
  echo "THEME=$THEME" > "$CONFIG_FILE"
  echo "WALLPAPER=$WALLPAPER" >> "$CONFIG_FILE"
}

load_config() {
  [ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"
}

link_dotfiles() {
  echo "[Step 5/5] Linking dotfiles..."
  mkdir -p "$HOME_DOTFILES"
  for d in framework settings themes; do
    ln -sf "$DOTFILES_DIR/$d" "$HOME_DOTFILES/$d"
  done
  ln -sf "$DOTFILES_DIR/autostart.sh.example" "$HOME_DOTFILES/autostart.sh"
  mkdir -p "$HOME/.config/bpswm"
  ln -sf "$HOME_DOTFILES/autostart.sh" "$HOME/.config/bpswm/autostart.sh"
  echo "Symlinks created in $HOME_DOTFILES and autostart linked to ~/.config/bpswm/autostart.sh."
}

choose_theme() {
  echo "[Step 2/5] Theme Selection"
  echo "Available themes:"
  local i=1
  local themes=()
  for theme in themes/*; do
    [ -d "$theme" ] && themes+=("$(basename "$theme")")
  done
  for t in "${themes[@]}"; do
    echo "  $i) $t"; ((i++));
  done
  echo -n "Select a theme [1-${#themes[@]}]: "
  read idx
  THEME="${themes[$((idx-1))]}"
}

choose_wallpaper() {
  echo "[Step 3/5] Wallpaper Selection"
  echo -n "Enter wallpaper path (image/video): "
  read WALLPAPER
}

summary() {
  echo "\n[Step 4/5] Configuration Summary:"
  echo "  Theme:     $THEME"
  echo "  Wallpaper: $WALLPAPER"
  echo "  Dotfiles:  $HOME_DOTFILES"
  echo "  Autostart: ~/.config/bpswm/autostart.sh"
  echo ""
  echo "Proceed with installation? (y/n)"
  read confirm
  [[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
}

# Main guided flow
load_config
check_deps
choose_theme
choose_wallpaper
summary
save_config
link_dotfiles
echo "\nInstallation complete! You can now start bpswm and enjoy your new setup."
