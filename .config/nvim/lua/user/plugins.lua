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
  use "williamboman/nvim-lsp-installer"
  use 'jose-elias-alvarez/null-ls.nvim'

  -- cmp
  use 'hrsh7th/nvim-cmp'-- the completation plugin
  use 'hrsh7th/cmp-buffer' -- buffer completation
  use 'hrsh7th/cmp-path' -- path completations
  use 'hrsh7th/cmp-cmdline' -- cmdline completations
  use 'hrsh7th/cmp-nvim-lsp'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  -- use 'saadparwaiz1/cmp_luasnip' -- i think i dont need this
  use 'rafamadriz/friendly-snippets'

  -- comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  --auto paris for { enter }
  use "windwp/nvim-autopairs"

  --diagnostics
    --jj
  -- use {
  --   "folke/trouble.nvim",
  --   config = function()
  --     require("trouble").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  -- colro themes
  use "EdenEast/nightfox.nvim"
  use "folke/tokyonight.nvim"
  use 'ful1e5/onedark.nvim'

end)
