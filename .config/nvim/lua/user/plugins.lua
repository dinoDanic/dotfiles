return require('packer').startup(function(use)
  -- essential
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons' 
  use 'nvim-lua/plenary.nvim'

  --lsp
  use "williamboman/nvim-lsp-installer"
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- treesitter
  use 'nvim-treesitter/nvim-treesitter'


  -- tree
  use 'kyazdani42/nvim-tree.lua'

  -- telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

  -- whichkey
  use "folke/which-key.nvim"

  -- cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer' -- buffer completation
  use 'hrsh7th/cmp-path' -- path completations
  use 'hrsh7th/cmp-cmdline' -- cmdline completations
  use 'hrsh7th/nvim-cmp'-- the completation plugin
  use 'saadparwaiz1/cmp_luasnip' 

  -- snippets
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  -- use 'rafamadriz/friendly-snippets'

  --auto closing tags
  use 'windwp/nvim-ts-autotag'

 -- comments
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- For comment block in react and diff languges

  -- git
  use 'lewis6991/gitsigns.nvim'

  --lualine
  use 'nvim-lualine/lualine.nvim'

  -- tabs
  use {'akinsho/bufferline.nvim', tag = "v2.*"}

  -- terminal
  use "akinsho/toggleterm.nvim"

  --autoparis
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  --buffer close without fucking up layout
  use "moll/vim-bbye"

  -- colro themes
  use "folke/tokyonight.nvim"
  use "ellisonleao/gruvbox.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }

end)
