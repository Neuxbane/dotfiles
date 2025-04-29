#!/usr/bin/env bash
# settings/settings.sh - Simulated settings app for bpswm dotfiles
#
# NOTE: This is a simulation for github.dev. On a real system, extend this for GUI/TUI or integrate with dmenu/rofi.
#
# Features: Theme selection, wallpaper setting, user management, network settings (stubs)

source "$(dirname "$0")/../framework/framework.sh"

show_menu() {
  echo "==== bpswm Settings ===="
  echo "1) Switch Theme"
  echo "2) Set Wallpaper"
  echo "3) User Management"
  echo "4) Network Settings"
  echo "5) Exit"
  echo -n "Select an option: "
}

switch_theme() {
  echo "Available themes:"
  for theme in ../themes/*; do
    [ -d "$theme" ] && echo "- $(basename "$theme")"
  done
  echo -n "Enter theme name: "
  read theme_name
  echo "Theme switched to $theme_name (simulate by updating config)"
}

set_wallpaper() {
  echo -n "Enter wallpaper path (image/video): "
  read wp
  echo "Wallpaper set to $wp (simulate by updating config)"
}

user_management() {
  echo "User management (stub): add/remove/change users here."
}

network_settings() {
  echo "Network settings (stub): configure Wi-Fi/Ethernet here."
}

while true; do
  show_menu
  read choice
  case $choice in
    1) switch_theme ;;
    2) set_wallpaper ;;
    3) user_management ;;
    4) network_settings ;;
    5) echo "Exiting settings."; break ;;
    *) echo "Invalid option." ;;
  esac
done
