#!/bin/bash

# Interactive theme picker script
# Allows user to select between catppuccin and tokyonight themes
# Copies both neovim.lua and hyprpaper.conf files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$(dirname "$SCRIPT_DIR")"

echo "🎨 Theme Picker"
echo "==============="
echo ""
echo "Select a theme:"
echo "1) catppuccin"
echo "2) tokyonight"
echo "3) dracula"
echo ""
read -p "Enter your choice (1-2): " choice

case $choice in
    1)
        THEME="catppuccin"
        ;;
    2)
        THEME="tokyonight"
        ;;
    3)
        THEME="dracula"
        ;;
    *)
        echo "❌ Invalid choice. Please select 1 or 2."
        exit 1
        ;;
esac

echo ""
echo "Selected theme: $THEME"
echo ""

# Define source and destination paths
NEOVIM_SRC="$THEMES_DIR/$THEME/neovim.lua"
NEOVIM_DEST="$HOME/.config/nvim/lua/custom/themes/init.lua"
HYPRPAPER_SRC="$THEMES_DIR/$THEME/hyprpaper.conf"
HYPRPAPER_DEST="$HOME/.config/hypr/hyprpaper.conf"

# Check if theme files exist
if [ ! -f "$NEOVIM_SRC" ]; then
    echo "❌ Error: $NEOVIM_SRC not found"
    exit 1
fi

if [ ! -f "$HYPRPAPER_SRC" ]; then
    echo "❌ Error: $HYPRPAPER_SRC not found"
    exit 1
fi

# Create directories if they don't exist
mkdir -p "$(dirname "$NEOVIM_DEST")"
mkdir -p "$(dirname "$HYPRPAPER_DEST")"

# Copy files
echo "📋 Copying theme files..."
cp "$NEOVIM_SRC" "$NEOVIM_DEST"
echo "✓ Copied neovim config: $NEOVIM_DEST"

cp "$HYPRPAPER_SRC" "$HYPRPAPER_DEST"
echo "✓ Copied hyprpaper config: $HYPRPAPER_DEST"

echo ""
echo "🎉 Theme switched to $THEME successfully!"
echo ""

# Restart hyprpaper to apply new wallpaper
echo "🔄 Restarting hyprpaper..."
pkill hyprpaper && hyprpaper &

echo ""
echo "📝 Next steps:"
echo "   • Restart Neovim to apply the new theme"
echo "   • Wallpaper has been updated automatically"
