return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons' 
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim' 
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use "folke/which-key.nvim"
  use 'goolord/alpha-nvim'
  use "ahmedkhalf/project.nvim"
  use 'romgrk/barbar.nvim'
  use 'windwp/nvim-ts-autotag'
  use 'windwp/nvim-autopairs'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use "akinsho/toggleterm.nvim"
  use 'nvim-lua/plenary.nvim'

  --lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use "williamboman/nvim-lsp-installer"

  -- cmp
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  -- formater
  use 'jose-elias-alvarez/null-ls.nvim'

  -- colro themes
  use "EdenEast/nightfox.nvim"
  use 'folke/tokyonight.nvim'
end)
