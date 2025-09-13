-- [[ Basic Autocommands ]]
--
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Omarchy theme synchronization
-- Watch for changes in Omarchy theme and apply them automatically
vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
  desc = 'Sync with Omarchy theme changes',
  group = vim.api.nvim_create_augroup('omarchy-theme-sync', { clear = true }),
  callback = function()
    local omarchy_theme_path = vim.fn.expand('~/.config/omarchy/current/theme/neovim.lua')
    if vim.fn.filereadable(omarchy_theme_path) == 1 then
      local success, theme_config = pcall(dofile, omarchy_theme_path)
      if success and theme_config then
        for _, plugin_spec in ipairs(theme_config) do
          if plugin_spec[1] == 'LazyVim/LazyVim' and plugin_spec.opts and plugin_spec.opts.colorscheme then
            local colorscheme = plugin_spec.opts.colorscheme
            if vim.g.colors_name ~= colorscheme then
              vim.schedule(function()
                local apply_success, _ = pcall(vim.cmd.colorscheme, colorscheme)
                if apply_success then
                  vim.notify('Synced with Omarchy theme: ' .. colorscheme, vim.log.levels.INFO)
                end
              end)
            end
            break
          end
        end
      end
    end
  end,
})
