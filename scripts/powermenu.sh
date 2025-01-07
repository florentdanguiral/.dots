#!/bin/bash

# Options du menu d'alimentation
OPTIONS="襤 Éteindre\n Redémarrer\n鈴 Suspendre\n Déconnexion"

# Affiche le menu avec Rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Choisir une action:")

# Exécute la commande correspondante
case "$CHOICE" in
    *Éteindre) systemctl poweroff ;;
    *Redémarrer) systemctl reboot ;;
    *Suspendre) systemctl suspend ;;
    *Déconnexion) pkill -KILL -u $USER ;;
    *) exit 1 ;;  # Quitte si aucune option valide n'est sélectionnée
esac

