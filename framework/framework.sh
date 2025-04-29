#!/usr/bin/env bash
# framework.sh - Core utilities for bpswm dotfiles theming and settings
# Source this file in themes and settings scripts to access shared functions

# Load all modules in the framework directory
framework_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for module in "$framework_dir"/modules/*.sh; do
  [ -e "$module" ] && source "$module"
done

# Example: Color utility
set_color() {
  # Usage: set_color <color_code>
  echo -ne "\e[38;5;${1}m"
}

# Example: Transparency utility (for picom or similar)
set_transparency() {
  # Usage: set_transparency <opacity>
  # This is a stub; actual implementation depends on compositor
  echo "Set transparency to $1 (implement in theme or compositor config)"
}

# Example: Animation utility (stub)
run_animation() {
  # Usage: run_animation <type> <params>
  echo "Run animation: $1 with params: $2 (implement in theme)"
}

# ...add more shared utilities as needed...
