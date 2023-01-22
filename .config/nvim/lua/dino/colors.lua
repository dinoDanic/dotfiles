-- FOXXXXXXXXXXXXXX
-- vim.cmd [[colorscheme carbonfox]]

-- NVIM TREEEEEEEEE
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#CE8DE2 ]])

-- CATPUCCIONOOOOOO
-- vim.cmd [[colorscheme catppuccin-frappe]]

-- DRACULA
-- vim.cmd[[colorscheme dracula]]

-- NIGHTFOX
-- vim.cmd[[colorscheme nightfox]]

-- ONE DARKKKKKKKKK
-- require('onedark').load()


-- ROSE PINE
require("rose-pine").setup()
vim.cmd('colorscheme rose-pine')
vim.cmd[[hi NonText guifg=bg]]

-- TOKYYYYYYYYYYYYO
-- vim.cmd [[ colorscheme tokyonight]]
-- vim.cmd [[ highlight NvimTreeIndentMarker guifg=#7dcfff ]]
-- vim.cmd [[ hi LineNrAbove guifg=#5A67AC ]]
-- vim.cmd [[ hi LineNrBelow guifg=#5A67AC ]]


-- transparent
-- vim.cmd [[hi! Normal ctermbg=NONE guibg=NONE]]
-- vim.cmd [[ hi! NonText ctermbg=NONE guibg=NONE]]
-- vim.cmd [[ hi! EndOfBuffer guibg=NONE ctermbg=NONE]]

-- require("transparent").setup({
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     "all"
--   },
--   exclude = {}, -- table: groups you don't want to clear
-- })
--

-- Colorize
require 'colorizer'.setup({
  '*';
}, { mode = 'foreground', names = false })


-- Global
vim.cmd[[hi clear SpellBad]]
vim.cmd[[hi SpellBad cterm=underline gui=undercurl]]
