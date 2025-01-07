#!/bin/bash

# Boucle infinie pour écouter les changements de piste
playerctl --player=spotify metadata --format "{{mpris:artUrl}}" --follow | while read -r art_url; do
   # Récupérer le titre de la chanson et l'artiste
   song=$(playerctl --player=spotify metadata --format "{{ artist }} - {{ title }}")

   # Télécharger l'image de la pochette de l'album temporairement
   wget -q "$art_url" -O /tmp/spotify_cover.jpg

   # Envoyer la notification avec l'image de la pochette
   notify-send "Now playing" "$song" --icon=/tmp/spotify_cover.jpg
done

