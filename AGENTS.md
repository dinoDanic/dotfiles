# Agent Guidelines for ~/.config

## Build/Test Commands
- **Raycast Extensions**: `ray build -e dist`, `ray develop`, `ray lint`, `ray lint --fix`
- **No global test suite** - configuration files only
- **Fish Shell**: Source with `source ~/.config/fish/config.fish`
- **Tmux**: Reload with `<prefix>R` or `tmux source ~/.config/tmux/.tmux.conf`

## Code Style & Conventions

### General
- Use **2-space indentation** for all files (Lua, JS, Fish, config files)
- Prefer **kebab-case** for file/directory names
- Use **camelCase** for JavaScript variables/functions
- Use **snake_case** for Fish shell functions

### JavaScript (Raycast)
- Import `@raycast/api` components at top
- Use TypeScript-style imports: `import { Component } from "module"`
- Prefer async/await over promises
- Use descriptive variable names
- Keep line length reasonable (~80-100 chars)

### Lua (Neovim)
- Use **require** statements at top of files
- Prefer `vim.keymap.set()` over `vim.api.nvim_set_keymap()`
- Use descriptive keymap descriptions: `{ desc = 'Description' }`
- Group related keymaps together with comments

### Configuration Files
- TOML: Use lowercase keys, group related settings
- Fish: Use functions for complex operations, aliases for simple shortcuts
- Tmux: Use descriptive bind names, group by functionality

## Project Structure
This is a **dotfiles repository** containing personal configuration files for macOS development tools.