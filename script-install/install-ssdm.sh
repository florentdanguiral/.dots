#!/bin/bash

# Mettre à jour le système
echo "Mise à jour du système..."
sudo pacman -Syu --noconfirm

# Installer SDDM
echo "Installation de SDDM..."
sudo pacman -S sddm --noconfirm

# Activer SDDM au démarrage
echo "Activation de SDDM au démarrage..."
sudo systemctl enable sddm.service

# Démarrer SDDM
echo "Démarrage de SDDM..."
sudo systemctl start sddm.service

echo "Installation et configuration de SDDM terminées."
sudo pacman -S slock

