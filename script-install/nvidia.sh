#!/bin/bash

nvidia_pkg=(
  linux-headers
  nvidia-dkms
  nvidia-settings
  nvidia-utils
)

for pkg in "${nvidia_pkg[@]}"; do
  sudo pacman -S "$pkg" --noconfirm
done

sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf 2>&1 | tee -a "$LOG"
echo "options nvidia_drm modeset=1 fbdev=1" | sudo tee "/etc/modprobe.d/nvidia.conf" 2>&1 | tee -a "$LOG"
