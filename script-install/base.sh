#!/bin/bash

pkg=(
  hyprland
  hyprpaper
  hypridle
  waybar
  wl-roots
  rofi
  xdg-desktop-portal-hyprland
  polkit-kde-agent
  firefox
  network-manager-applet
  kitty
  fastfetch
  mako
  swaylock-effects
  swayidle
  ripgrep
  fd
  zsh
  firefox
  nodejs
  wl-clipboard
  npm
  kitty
  openssh
  rofi
  waybar
  stow
  less
  lua51
  luarocks
  imagemagick
  thunar
  yazi
  nwg-look
  python
  papirus-icon-theme
  hyprpicker
  qbittorrent 
  mpv
  kanshi
  chromium
  zsh
  
)

for pkg in "${pkg[@]}"; do
  sudo pacman -S "$pkg" --noconfirm
done

