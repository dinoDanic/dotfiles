-- FOXXXXXXXXXXXXXX
-- vim.cmd [[colorscheme carbonfox]]


-- NVIM TREEEEEEEEE
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#CE8DE2 ]])

-- CATPUCCIONOOOOOO
-- require("catppuccin").setup {
--     flavour = "mocha" -- mocha, macchiato, frappe, latte
-- }
-- vim.cmd [[colorscheme catppuccin-mocha]]



-- ONE DARKKKKKKKKK
-- vim.cmd [[colorscheme onedark]]
require('onedark').setup {
    -- style = 'dark'
}
require('onedark').load()

-- vim.cmd [[hi LineNrAbove guifg=#ABB2BF ]] 
-- vim.cmd [[hi LineNrBelow guifg=#ABB2BF ]]
-- vim.cmd [[hi LineNr guifg=#56B6C2 ]]


-- TOKYYYYYYYYYYYYO 
-- vim.cmd [[ colorscheme tokyonight-night]]
-- vim.cmd [[ highlight NvimTreeFolderIcon guifg=#7dcfff ]]
-- vim.cmd [[ highlight NvimTreeIndentMarker guifg=#7dcfff ]]
-- vim.cmd [[ hi LineNrAbove guifg=#fff ]] 
-- vim.cmd [[ hi LineNrBelow guifg=#fff ]]
-- vim.cmd [[ hi LineNr guifg=#00ffd2 ]]
 

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
  -- require 'colorizer'.setup({
  --   '*';
  -- }, { mode = 'foreground', names = false })
