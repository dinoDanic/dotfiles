local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height 
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  undofile = true,                         -- enable persistent undo
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 50,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 1,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

-- theme
--
-- vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha white
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

--set Lines colors and colorscheme for catppuccin
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[hi LineNrAbove guifg=#8AADF4 ]] 
-- vim.cmd [[hi LineNrBelow guifg=#8AADF4 ]]
-- vim.cmd [[hi LineNr guifg=#A6E3A1 ]]

--set Lines colors and colorscheme for onedark
vim.cmd [[colorscheme onedark]]
vim.cmd [[hi LineNrAbove guifg=#ABB2BF ]] 
vim.cmd [[hi LineNrBelow guifg=#ABB2BF ]]
vim.cmd [[hi LineNr guifg=#56B6C2 ]]

-- Line colors and colorscheme for gruvboxg

-- vim.cmd [[colorscheme gruvbox]]
-- vim.cmd [[hi LineNrAbove guifg=#b16286 ]] 
-- vim.cmd [[hi LineNrBelow guifg=#b16286 ]]
-- vim.cmd [[hi LineNr guifg=#d3869b  ]]

-- Load the colorscheme
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme gruvbox]]
