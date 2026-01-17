return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
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
          theme = "dropdown"
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
    vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope git_status theme=ivy<cr>',
      { desc = '[ ] Show edited git files', })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end
}
