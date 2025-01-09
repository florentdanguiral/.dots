#!/bin/bash

# Nom de l'écran interne
INTERNE="eDP-1"  # Remplacez ceci par le nom de votre écran interne si nécessaire

# Vérifie si l'écran est activé via hyprctl
if hyprctl monitors | grep -q "$INTERNE.*disabled: false"; then
    # Si l'écran est activé, on le désactive
    hyprctl keyword "monitor $INTERNE off"
    echo "L'écran interne a été désactivé."
else
    # Si l'écran est désactivé, on l'active
    hyprctl keyword "monitor $INTERNE on"
    echo "L'écran interne a été activé."
fi

