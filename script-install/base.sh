#!/bin/bash

pkg=(
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
)

for pkg in "${pkg[@]}"; do
  sudo pacman -S "$pkg" --noconfirm
done

