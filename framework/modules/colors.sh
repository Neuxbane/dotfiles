# colors.sh - Color utility functions for themes and settings

# Set foreground color (256-color)
set_fg_color() {
  # Usage: set_fg_color <color_code>
  echo -ne "\e[38;5;${1}m"
}

# Set background color (256-color)
set_bg_color() {
  # Usage: set_bg_color <color_code>
  echo -ne "\e[48;5;${1}m"
}

# Reset colors
reset_colors() {
  echo -ne "\e[0m"
}
