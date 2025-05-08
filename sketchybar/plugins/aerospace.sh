#!/usr/bin/env bash

# Load color variables
source "$CONFIG_DIR/../variables.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
      background.drawing=on \
      background.color=$FOAM \
      label.color=$HIGHLIGHT
else
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=$FOREGROUND
fi
