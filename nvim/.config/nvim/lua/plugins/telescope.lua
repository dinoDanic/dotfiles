return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    -- we use mini.icons
    -- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<c-enter>'] = 'to_fuzzy_refine',
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-d>'] = 'delete_buffer',
          },
          n = {
            ['d'] = require('telescope.actions').delete_buffer,
            ['q'] = require('telescope.actions').close,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown"
        },
        live_grep = {
          theme = "ivy"
        },
        keymaps = {
          theme = "ivy"
        },
        oldfiles = {
          theme = "dropdown"
        },
        buffers = {
          theme = "cursor"
        }
      }
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope git_status theme=ivy<cr>', {
      desc = '[ ] Show edited git files',
    })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end
}
