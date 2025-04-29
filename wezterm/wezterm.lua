-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

-- Appearancec
config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
config.font_size = 14.0
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 100
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 0,
}

-- For example, changing the color scheme:
config.colors = theme.colors()
config.window_frame = theme.window_frame()

-- open link
config.keys = {
  {
    key = "l",
    mods = "CMD",
    action = wezterm.action.QuickSelectArgs {
      label = "Open URL",
      patterns = { "https?://\\S+" },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        if url and url:match("^https?://") then
          wezterm.open_with(url)
        else
          window:toast_notification("WezTerm", "No valid URL found", nil, 4000)
        end
      end),
    },
  },
}

-- and finally, return the configuration to wezterm
return config
