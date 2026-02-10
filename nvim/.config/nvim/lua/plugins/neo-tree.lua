return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      -- { '<leader>e', ':Neotree position=current toggle reveal<CR>', desc = 'NeoTree reveal', silent = true },
      { '<leader>e', ':Neotree toggle reveal<CR>', desc = 'NeoTree reveal', silent = true },

    },
    config = function()
      require('neo-tree').setup {
        window = {
          mappings = {
            ["/"] = "noop", -- disable neo-tree's filter, use native vim search
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
        popup_border_style = 'rounded',
        close_if_last_window = true,
        enable_git_status = false,
        enable_diagnostics = false,
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            indent_size = 2,
          },
        },
        event_handlers = {
          {
            event = 'file_opened',
            handler = function()
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
      }
      -- netrw-like line numbers for Neo-tree
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
        end,
      })
    end,
  }
}
