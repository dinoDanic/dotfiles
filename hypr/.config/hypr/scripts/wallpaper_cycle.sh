#!/bin/bash

# Wallpaper paths
WALLS=("~/walls/an_astronaut_playing_a_piano.png" "~/walls/a_woman_standing_in_front_of_a_window.jpg")

CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Get current wallpaper from config
CURRENT=$(grep "wallpaper = " "$CONFIG_FILE" | cut -d',' -f2)

# Find current index
CURRENT_INDEX=-1
for i in "${!WALLS[@]}"; do
    if [[ "${WALLS[$i]}" == "$CURRENT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# Get next wallpaper
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLS[@]} ))
NEXT_WALL="${WALLS[$NEXT_INDEX]}"

# Ensure all wallpapers are preloaded
for wall in "${WALLS[@]}"; do
    hyprctl hyprpaper preload "$wall"
done

# Apply new wallpaper
hyprctl hyprpaper wallpaper ",$NEXT_WALL"
