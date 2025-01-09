#!/bin/bash

bluetooth_pkg=(
  bluez 
  blueman 
  blueman-utils 
)

for pkg in "${bluetooth_pkg[@]}"; do
  sudo pacman -S "$pkg" --noconfirm
done

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
