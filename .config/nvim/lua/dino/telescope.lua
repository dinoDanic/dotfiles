local actions = require "telescope.actions"

require('telescope').setup{
  defaults = {

  find_command = { "fd", "-t=f", "-a" },
	path_display = { "absolute" },
  wrap_results = true,


    layout_config = {
      vertical = { width = 0 }
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
  pickers = {
    find_files = {
      -- theme = "ivy",
      theme = "dropdown",
      -- wrap_results = true
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
  }
}
