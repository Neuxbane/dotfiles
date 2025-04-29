# bpswm Dotfiles Project Requirements

## Overview
This repository provides modular, user-friendly, and extensible dotfiles for the bpswm window manager. It includes an installer, theming support, and a settings application, all designed for easy customization and future expansion.

## Features & Requirements

### 1. Installer Script (`install.sh`)
- Interactive shell script, similar to `archinstall`.
- Saves installer configuration for repeatable setups.
- Uses symbolic links (not copy or move) to link dotfiles into the user's home/config directories.
- Executes installation steps based on the saved configuration.
- Allows re-running with the same or updated configuration.

### 2. Theming System
- Supports multiple themes.
- Each theme is a directory under `themes/`.
- Users can add their own theme directories and declare their own functionality.
- Includes a `kawaii` theme by default, featuring a rounded shape bar.
- Themes should support rich animations, vibrant colors, transparency, and other modern visual effects.
- All themes must utilize the shared visual framework/toolkit for animations, color, transparency, and dependency management.

### 2a. Visual Framework
- Build a shared framework/toolkit to provide:
  - Common animation, color, and transparency utilities for themes and the settings app.
  - Centralized management of third-party libraries and dependencies for visual effects.
  - APIs and helpers to ensure consistency and reusability across all themes.
  - Easy extensibility for new themes and plugins.

### 3. Settings Application
- A settings app (GUI or TUI) to configure:
  - Themes (switch between available themes)
  - Wallpaper (set image or video backgrounds)
  - User management (add/remove users, change user settings)
  - Network settings (Wi-Fi, Ethernet, etc.)
- Extensible for future configuration options.

### 4. Documentation
- Clear instructions for:
  - Installation using `install.sh`
  - Adding new themes
  - Using the settings app

### 5. Project Structure
- `/install.sh`
- `/themes/kawaii/` (with theme files)
- `/settings/` (settings app code)
- `/README.md`

### 6. Optional/Future Features
- More prebuilt themes.
- Plugin system for the settings app.
- Automated tests for installer and settings app.

---

Please review these requirements and features. Let us know if you have suggestions or want to adjust the scope before development begins.