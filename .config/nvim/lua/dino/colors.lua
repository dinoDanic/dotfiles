-- FOXXXXXXXXXXXXXX
vim.cmd [[colorscheme carbonfox]]



-- NVIM TREEEEEEEEE
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#CE8DE2 ]])

-- CATPUCCIONOOOOOO
-- require("catppuccin").setup {
--     flavour = "mocha" -- mocha, macchiato, frappe, latte
-- }
-- vim.cmd [[colorscheme catppuccin-mocha]]



-- ONE DARKKKKKKKKK
-- vim.cmd [[colorscheme onedark]]
-- vim.cmd [[hi LineNrAbove guifg=#ABB2BF ]] 
-- vim.cmd [[hi LineNrBelow guifg=#ABB2BF ]]
-- vim.cmd [[hi LineNr guifg=#56B6C2 ]]


-- TOKYYYYYYYYYYYYO 
-- vim.cmd [[ colorscheme tokyonight-moon]]
-- vim.cmd [[ highlight NvimTreeIndentMarker guifg=#7dcfff ]]
-- vim.cmd [[ highlight NvimTreeFolderIcon guifg=#7dcfff ]]
-- vim.cmd [[ hi LineNrAbove guifg=#7dcfff ]] 
-- vim.cmd [[ hi LineNrBelow guifg=#7dcfff ]]
-- vim.cmd [[ hi LineNr guifg=#7dcfff ]]
 

-- transparent 
-- vim.cmd [[hi! Normal ctermbg=NONE guibg=NONE]]
-- vim.cmd [[ hi! NonText ctermbg=NONE guibg=NONE]]
-- vim.cmd [[ hi! EndOfBuffer guibg=NONE ctermbg=NONE]]


-- Colorize
  require 'colorizer'.setup({
    '*';
  }, { mode = 'foreground', names = false })
