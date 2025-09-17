# Zellij + Omarchy Theme Sync

This setup automatically syncs your Zellij theme with your current Omarchy theme.

## Files in this folder:
- `sync-zellij-theme.sh` - The main sync script
- `zellij-theme-watcher.service` - Auto-watcher service
- `zellij-theme-sync.service` - Manual sync service
- `config.kdl` - Main Zellij configuration
- `config.kdl.backup` - Backup of original config

## Usage:

### Manual sync:
```bash
~/.config/zellij/sync-zellij-theme.sh
```

### Enable auto-sync (recommended):
```bash
# Copy service file to systemd user directory
cp ~/.config/zellij/zellij-theme-watcher.service ~/.config/systemd/user/

# Enable the watcher service to automatically sync when theme changes
systemctl --user enable zellij-theme-watcher.service
systemctl --user start zellij-theme-watcher.service

# Check status
systemctl --user status zellij-theme-watcher.service
```

### Add to shell profile (optional):
Add this alias to your `~/.bashrc` or `~/.zshrc`:
```bash
alias sync-zellij="~/.config/zellij/sync-zellij-theme.sh"
```

## Theme Mappings:
- catppuccin → catppuccin-frappe
- catppuccin-latte → catppuccin-macchiato  
- gruvbox → gruvbox-dark
- nord → nord
- kanagawa → kanagawa
- everforest → everforest-dark
- tokyo-night → tokyo-night-dark
- rose-pine → dracula
- osaka-jade → ayu_dark
- matte-black → ansi
- ristretto → molokai-dark
- (others) → gruvbox-dark (fallback)

## Notes:
- Zellij sessions need to be restarted to see theme changes
- The script backs up your config to `config.kdl.backup` before making changes
- The auto-watcher requires `inotify-tools` package