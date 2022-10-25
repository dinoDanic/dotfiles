require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
--
--set Lines colors and colorscheme for catppuccin
vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[hi LineNrAbove guifg=#8AADF4 ]] 
-- vim.cmd [[hi LineNrBelow guifg=#8AADF4 ]]
-- vim.cmd [[hi LineNr guifg=#A6E3A1 ]]

--set Lines colors and colorscheme for onedark

-- vim.cmd [[colorscheme onedark]]
-- vim.cmd [[hi LineNrAbove guifg=#ABB2BF ]] 
-- vim.cmd [[hi LineNrBelow guifg=#ABB2BF ]]
-- vim.cmd [[hi LineNr guifg=#56B6C2 ]]
 

-- transparent 
 -- vim.cmd [[hi! Normal ctermbg=NONE guibg=NONE]]
 -- vim.cmd [[ hi! NonText ctermbg=NONE guibg=NONE]]
 -- vim.cmd [[ hi! EndOfBuffer guibg=NONE ctermbg=NONE]]

-- Line colors and colorscheme for gruvboxg

-- vim.cmd [[colorscheme gruvbox]]
-- vim.cmd [[hi LineNrAbove guifg=#b16286 ]] 
-- vim.cmd [[hi LineNrBelow guifg=#b16286 ]]
-- vim.cmd [[hi LineNr guifg=#d3869b  ]]

-- Load the colorscheme
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme gruvbox]]

