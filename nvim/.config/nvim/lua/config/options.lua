vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.smartcase = true

-- vim.opt.timeoutlen = 300
-- vim.opt.updatetime = 50

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true


vim.opt.cmdheight = 0

vim.api.nvim_command 'autocmd CmdlineEnter * set cmdheight=1'
vim.api.nvim_command 'autocmd CmdlineLeave * set cmdheight=0'
vim.api.nvim_command 'autocmd RecordingEnter * set cmdheight=1'
vim.api.nvim_command 'autocmd RecordingLeave * set cmdheight=0'


vim.g.netrw_liststyle = 3

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

