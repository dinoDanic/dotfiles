#!/bin/bash

WALLS_DIR="$HOME/walls"
STATE_FILE="$HOME/.cache/wallpaper_cycle_state"

if [ ! -d "$WALLS_DIR" ]; then
    echo "Error: Wallpapers directory $WALLS_DIR not found"
    exit 1
fi

WALLS=($(find "$WALLS_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | sort))

if [ ${#WALLS[@]} -eq 0 ]; then
    echo "Error: No wallpapers found in $WALLS_DIR"
    exit 1
fi

if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

CURRENT_INDEX=$(cat "$STATE_FILE")

if [ "$CURRENT_INDEX" -ge ${#WALLS[@]} ]; then
    CURRENT_INDEX=0
fi

WALLPAPER="${WALLS[$CURRENT_INDEX]}"

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"

NEXT_INDEX=$((CURRENT_INDEX + 1))
if [ "$NEXT_INDEX" -ge ${#WALLS[@]} ]; then
    NEXT_INDEX=0
fi

echo "$NEXT_INDEX" > "$STATE_FILE"

echo "Switched to wallpaper: $(basename "$WALLPAPER")"
