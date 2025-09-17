#!/bin/bash
# Sync Zellij theme with current Omarchy theme

# Get current Omarchy theme
CURRENT_THEME=$(readlink ~/.config/omarchy/current/theme 2>/dev/null | xargs basename)

if [ -z "$CURRENT_THEME" ]; then
    echo "Could not detect current Omarchy theme"
    exit 1
fi

echo "Current Omarchy theme: $CURRENT_THEME"

# Map Omarchy themes to Zellij themes
case "$CURRENT_THEME" in
    "catppuccin")
        ZELLIJ_THEME="catppuccin-frappe"
        ;;
    "catppuccin-latte")
        ZELLIJ_THEME="catppuccin-macchiato"
        ;;
    "gruvbox")
        ZELLIJ_THEME="gruvbox-dark"
        ;;
    "nord")
        ZELLIJ_THEME="nord"
        ;;
    "kanagawa")
        ZELLIJ_THEME="kanagawa"
        ;;
    "everforest")
        ZELLIJ_THEME="everforest-dark"
        ;;
    "tokyo-night")
        ZELLIJ_THEME="tokyo-night-dark"
        ;;
    "rose-pine")
        ZELLIJ_THEME="dracula"
        ;;
    "osaka-jade")
        ZELLIJ_THEME="ayu_dark"
        ;;
    "matte-black")
        ZELLIJ_THEME="ansi"
        ;;
    "ristretto")
        ZELLIJ_THEME="molokai-dark"
        ;;
    *)
        ZELLIJ_THEME="gruvbox-dark"  # default fallback
        ;;
esac

# Backup current config
cp ~/.config/zellij/config.kdl ~/.config/zellij/config.kdl.backup

# Update Zellij config - comment out all active themes first
sed -i 's/^theme /\/\/ theme /' ~/.config/zellij/config.kdl

# Uncomment and activate the target theme (handle both formats with and without space after //)
sed -i "s/^\/\/ theme \"$ZELLIJ_THEME\"/theme \"$ZELLIJ_THEME\"/" ~/.config/zellij/config.kdl
sed -i "s/^\/\/theme \"$ZELLIJ_THEME\"/theme \"$ZELLIJ_THEME\"/" ~/.config/zellij/config.kdl

# Handle the special case where gruvbox-dark has a comment
if [ "$ZELLIJ_THEME" = "gruvbox-dark" ]; then
    sed -i 's/^\/\/ theme "gruvbox-dark" \/\/ zelena/theme "gruvbox-dark" \/\/ zelena/' ~/.config/zellij/config.kdl
fi

echo "Updated Zellij theme to: $ZELLIJ_THEME"

# Reload Zellij sessions if any are running
if pgrep -x zellij > /dev/null; then
    echo "Zellij is running. You may need to restart sessions to see theme changes."
fi