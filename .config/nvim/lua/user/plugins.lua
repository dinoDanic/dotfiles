return require('packer').startup(function(use)
  -- essential
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons' 
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim' 
  use 'kyazdani42/nvim-tree.lua'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-treesitter/nvim-treesitter'

  use 'nvim-lualine/lualine.nvim'
  use "folke/which-key.nvim"
  use 'goolord/alpha-nvim'
  use "ahmedkhalf/project.nvim"
  --use 'romgrk/barbar.nvim'
  use "akinsho/toggleterm.nvim"

  -- tabs
  use {'akinsho/bufferline.nvim', tag = "v2.*"}

  --auto
  use 'windwp/nvim-ts-autotag'

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

  -- comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  --auto paris for { enter }
  use "windwp/nvim-autopairs"

  -- colro themes
  use "EdenEast/nightfox.nvim"
  use "folke/tokyonight.nvim"


end)
