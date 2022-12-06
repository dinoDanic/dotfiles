local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-tree/nvim-web-devicons"
  
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-nvim-lsp" 
  use "saadparwaiz1/cmp_luasnip" -- snippet completions 
  
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
	use "onsails/lspkind.nvim" -- vs-code like icons for autocompletion

   -- snippets
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- null ls
  use "jose-elias-alvarez/null-ls.nvim"

  -- telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

  -- treesiter
  use 'nvim-treesitter/nvim-treesitter'

  -- lualine
  use 'nvim-lualine/lualine.nvim' 

  -- auto closgin 
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }
  use {
    "windwp/nvim-ts-autotag", 
      config = function() require("nvim-ts-autotag").setup {} end
  } 

  -- git 
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- comments
use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup {
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end
  }

  -- nvim tree
  use 'nvim-tree/nvim-tree.lua'

  -- which key
  use "folke/which-key.nvim" 

  -- bufferline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}

  -- toggle terminal
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}

  --buffer close without fucking up layout
  use "moll/vim-bbye"

  -- projects
  use "ahmedkhalf/project.nvim"

  -- colors
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"
  use 'navarasu/onedark.nvim'
  -- use "xiyaowong/nvim-transparent"
  
  -- useless
--   use {
--     'tamton-aquib/duck.nvim',
--     config = function()
--         vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
--         vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
--     end
-- }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
