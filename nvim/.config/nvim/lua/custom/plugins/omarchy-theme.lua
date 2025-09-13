local M = {}

local omarchy_theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")

local function load_omarchy_theme()
  if vim.fn.filereadable(omarchy_theme_path) == 1 then
    local success, theme_config = pcall(dofile, omarchy_theme_path)
    if success and theme_config then
      return theme_config
    else
      vim.notify("Failed to load Omarchy theme config", vim.log.levels.WARN)
      return nil
    end
  end
  return nil
end

local function get_theme_plugins()
  local theme_config = load_omarchy_theme()
  if not theme_config then
    return {}
  end

  local plugins = {}
  for _, plugin_spec in ipairs(theme_config) do
    if plugin_spec[1] and plugin_spec[1] ~= "LazyVim/LazyVim" then
      table.insert(plugins, plugin_spec)
    end
  end
  
  return plugins
end

local function get_colorscheme()
  local theme_config = load_omarchy_theme()
  if not theme_config then
    return nil
  end

  for _, plugin_spec in ipairs(theme_config) do
    if plugin_spec[1] == "LazyVim/LazyVim" and plugin_spec.opts and plugin_spec.opts.colorscheme then
      return plugin_spec.opts.colorscheme
    end
  end
  
  return nil
end

local function apply_colorscheme()
  local colorscheme = get_colorscheme()
  if colorscheme then
    vim.schedule(function()
      local success, _ = pcall(vim.cmd.colorscheme, colorscheme)
      if success then
        vim.notify("Applied Omarchy theme: " .. colorscheme, vim.log.levels.INFO)
      else
        vim.notify("Failed to apply colorscheme: " .. colorscheme, vim.log.levels.WARN)
      end
    end)
  end
end

M.setup_theme_sync = function()
  local group = vim.api.nvim_create_augroup("OmarchyThemeSync", { clear = true })
  
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = group,
    callback = function()
      vim.defer_fn(apply_colorscheme, 100)
    end,
  })

  local theme_file = vim.fn.expand("~/.config/omarchy/current/theme")
  if vim.fn.isdirectory(theme_file) == 1 then
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "OmarchyThemeChanged",
      callback = apply_colorscheme,
    })

    local timer = vim.uv.new_timer()
    local last_theme = vim.uv.fs_readlink(theme_file)
    
    timer:start(1000, 1000, vim.schedule_wrap(function()
      local current_theme = vim.uv.fs_readlink(theme_file)
      if current_theme ~= last_theme then
        last_theme = current_theme
        vim.api.nvim_exec_autocmds("User", { pattern = "OmarchyThemeChanged" })
      end
    end))
  end
end

local theme_plugins = get_theme_plugins()

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
}

for _, plugin in ipairs(theme_plugins) do
  table.insert(plugins, plugin)
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.setup_theme_sync()
  end,
})

return plugins