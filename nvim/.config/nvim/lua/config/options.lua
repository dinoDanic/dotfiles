vim.opt.number = true               -- Show absolute line numbers
vim.opt.relativenumber = true       -- Show relative line numbers (for easier movement)
vim.opt.clipboard = 'unnamedplus'   -- Use system clipboard for yank/paste
vim.opt.breakindent = false         -- Do NOT indent wrapped lines
vim.opt.undofile = true             -- Enable persistent undo (survives restarts)
vim.opt.ignorecase = true           -- Ignore case when searching...
vim.opt.smartcase = true            -- ...unless the search has uppercase letters
vim.opt.splitright = true           -- Vertical splits open to the right
vim.opt.splitbelow = true           -- Horizontal splits open below
vim.opt.scrolloff = 10              -- Keep 10 lines visible above/below cursor
vim.opt.signcolumn = "yes"          -- Always show the sign column (no layout shift)
vim.opt.tabstop = 2                 -- A tab character is displayed as 2 spaces
vim.opt.shiftwidth = 2              -- Indent size for >> << commands
vim.opt.softtabstop = 2             -- Number of spaces when pressing <Tab>
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.smarttab = true             -- Smarter tab behavior at line start
vim.opt.smartindent = true          -- Smart auto-indenting for code
vim.opt.autoindent = true           -- Copy indent from previous line
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.showmode = false            -- Hide mode indicator (-- INSERT --)
vim.opt.showcmd = false             -- Hide partial command display
vim.opt.laststatus = 0              -- Hide the statusline entirely
vim.opt.termguicolors = true
vim.opt.showmatch = true

-- Hide command line when not in use
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

-- auto resize screen
-- Create an autocommand group for auto resizing
vim.api.nvim_create_augroup('autoequalize', { clear = true })

vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResized' }, {
  callback = function()
    vim.cmd 'wincmd ='
  end,
  group = 'autoequalize',
})
