-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Custom keymaps
vim.keymap.set('i', 'jj', '<Esc>')

-- diagnostics
-- Delete conflicting LazyVim keymaps to avoid timeout delay
vim.keymap.del('n', '<leader>dpp')
vim.keymap.del('n', '<leader>dph')
vim.keymap.del('n', '<leader>dps')

vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Show diagnostic float' })

-- quit
-- Delete conflicting LazyVim keymaps
vim.keymap.del('n', '<leader>qq')
vim.keymap.del('n', '<leader>qd')
vim.keymap.del('n', '<leader>ql')
vim.keymap.del('n', '<leader>qs')
vim.keymap.del('n', '<leader>qS')

vim.keymap.set('n', '<leader>q', '<cmd>q!<cr>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = '[W]rite file' })

-- comment (using ts-comments.nvim)
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'Toggle comment line', remap = true })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Toggle comment for selection', remap = true })

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and stay in visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and stay in visual mode' })

vim.keymap.set('n', '<leader>c', function()
  Snacks.bufdelete()
end, { desc = 'Close buffer' })

-- map("n", "<leader>bd", function()
--   Snacks.bufdelete()
-- end, { desc = "Delete Buffer" })

vim.keymap.del('n', '<leader>l')

--- lsp
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code actions' })
vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{async = true}<cr>', { desc = 'Format buffer' })


vim.keymap.del('n', '<leader><leader>')

vim.keymap.set('n', '<leader><leader>', function()
  require("snacks").picker.git_status()
end, {
  desc = 'Show git changed files',
})
