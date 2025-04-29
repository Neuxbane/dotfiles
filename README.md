# 💖 bpswm Kawaii Pink Rice

A highly customized, aesthetic-focused ricing setup for `bpswm` on **Arch Linux**, themed around **Kawaii Pink**. This configuration is designed to be cute, modern, and fully featured while remaining performant and functional.

---

## 📦 Project Requirements

### 🖥️ Base System
- Arch Linux (rolling release)
- Xorg display server
- `.xinitrc` session management (no display manager)

### 🧠 Window Manager
- `bpswm` – Binary space partitioning tiling window manager  
  GitHub: https://github.com/baskerville/bpswm

### 🎨 Appearance & Theming
- **Color Scheme**: Custom pastel Kawaii Pink
- **GTK Theme**: `Sweet`, `Layan-pink`, or similar
- **Icon Pack**: `Tela-circle-pink`, `BeautyLine`, `Papirus-Kawaii`
- **Fonts**: `Comic Mono Nerd Font`, `Quicksand`, `JetBrainsMono Nerd Font`
- **Cursor Theme**: `Sweet-cursors`, `Bibata-Modern-Ice`

### ⚙️ Essential Tools
| Function               | Tool                          |
|------------------------|-------------------------------|
| Terminal               | `Kitty` / `Alacritty`         |
| Bar                    | `polybar`                     |
| Compositor             | `picom-ibhagwan`              |
| Application Launcher   | `rofi`                        |
| Notification Daemon    | `dunst`                       |
| Wallpaper Setter       | `feh` / `nitrogen`            |
| Lock Screen            | `i3lock-color` / `betterlockscreen` |
| Audio Control          | `pulseaudio`, `pavucontrol`   |
| Brightness             | `brightnessctl`               |
| Screenshots            | `flameshot`                   |
| Clipboard Manager      | `clipmenu` / `cliphist`       |
| Power Menu             | Custom `rofi` script          |
| File Manager           | `pcmanfm` / `Thunar`          |

### 🎵 Extras
- **Media Controls**: `playerctl`
- **System Info**: `neofetch`, `btop`
- **Wallpaper Transition**: `swww`
- **Night Mode**: `redshift` or `gammastep`

### 🧰 Dotfiles Management
- **chezmoi** – Git-integrated, portable dotfile manager  
  Installation: `yay -S chezmoi`

---

## 📁 Suggested Directory Structure
```
~/.config/
├── bpswm/
├── polybar/
├── rofi/
├── picom/
├── dunst/
├── kitty/ or alacritty/
├── wallpapers/
├── scripts/
└── gtk-3.0/
```

---

## 🖼️ Screenshots
> _Add screenshots here to showcase the setup._

---

## 🚀 Installation
1. Clone the dotfiles repo:
   ```bash
   chezmoi init <your-dotfiles-repo>
   chezmoi apply
   ```

2. Install all packages:
   ```bash
   sudo pacman -S --needed xorg xorg-xinit kitty alacritty rofi dunst polybar picom nitrogen flameshot \
       pulseaudio pavucontrol brightnessctl playerctl redshift neofetch btop feh thunar pcmanfm \
       git base-devel
   yay -S bpswm i3lock-color ttf-comic-mono-nerd ttf-quicksand ttf-jetbrains-mono-nerd \
       tela-icon-theme beautyline-icon-theme papirus-icon-theme sweet-gtk-theme sweet-cursors
   ```

3. Set `.xinitrc` to launch `bpswm`:
   ```bash
   echo 'exec bpswm' > ~/.xinitrc
   startx
   ```

---

## 📚 Credits
- [bpswm](https://github.com/baskerville/bpswm)
- Icon packs and themes from AUR and GNOME-Look
- Inspired by various Kawaii and pink-themed rices

---

## 🧸 License
MIT License. Free to customize and share.

