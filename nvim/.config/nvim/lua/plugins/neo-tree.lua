return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { '<leader>e', ':Neotree position=current toggle reveal<CR>', desc = 'NeoTree reveal', silent = true },

    },
    config = function()
      require('neo-tree').setup {
        popup_border_style = 'rounded',
        close_if_last_window = true,
        enable_git_status = false,
        enable_diagnostics = false,
        event_handlers = {
          {
            event = 'file_opened',
            handler = function(file_path)
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
      }
    end,
  }
}
