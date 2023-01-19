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
 -- require('onedark').setup  {
 --     -- Main options --
 --     style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
 --     transparent = false,  -- Show/hide background
 --     term_colors = true, -- Change terminal color as per the selected theme style
 --     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
 --     cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
 --
 --     -- Change code style ---
 --     -- Options are italic, bold, underline, none
 --     -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
 --     code_style = {
 --         comments = 'italic',
 --         keywords = 'none',
 --         functions = 'none',
 --         strings = 'none',
 --         variables = 'none'
 --     },
 --
 --     -- Lualine options --
 --     lualine = {
 --         transparent = false, -- lualine center bar transparency
 --     },
 --
 --     -- Custom Highlights --
 --     colors = {}, -- Override default colors
 --     highlights = {}, -- Override highlight groups
 --
 --     -- Plugins Config --
 --     diagnostics = {
 --         darker = true, -- darker colors for diagnostic
 --         undercurl = true,   -- use undercurl instead of underline for diagnostics
 --         background = true,    -- use background color for virtual text
 --     },
 -- }
 --
 -- require('onedark').load()
 -- vim.cmd [[ highlight NvimTreeFolderIcon guifg=#7dcfff ]]
-- ONE DARKKKKKKKKKKKKKKKKKK ENDDDDDDDDDDDDDdd

-- vim.cmd [[hi LineNrAbove guifg=gray ]] 
-- vim.cmd [[hi LineNrBelow guifg=red ]]
-- vim.cmd [[hi LineNr guifg=#56B6C2 ]]


-- TOKYYYYYYYYYYYYO 
vim.cmd [[ colorscheme tokyonight]]
-- vim.cmd [[ colorscheme tokyonight-night]]
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
  require 'colorizer'.setup({
    '*';
}, { mode = 'foreground', names = false })
