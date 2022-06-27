local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[ packadd packer.nvim ]]
end

local present, packer = pcall(require, 'packer')
if not present then
  print 'Unable to load plugins!'
  return
end

packer.init(require'config'.packer)
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/impatient.nvim'
  use 'feline-nvim/feline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'SmiteshP/nvim-navic'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'glepnir/dashboard-nvim',
    config = function() require 'plugins.config.dashboard' end,
  }
  use 'NTBBloodbath/rest.nvim'
  use 'folke/zen-mode.nvim'
  use 'ggandor/leap.nvim'
  use 'baskerville/vim-sxhkdrc'
  use 'elkowar/yuck.vim'
  use 'fladson/vim-kitty'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- Color schemes
  use 'yashguptaz/calvera-dark.nvim'
  use 'shaunsingh/moonlight.nvim'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'marko-cerovac/material.nvim'
  use 'bluz71/vim-nightfly-guicolors'
  use 'shaunsingh/nord.nvim'
  use 'mangeshrex/uwu.vim'
  use 'rebelot/kanagawa.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'catppuccin/nvim', as = 'catppuccin' }

  use {
    'lukas-reineke/indent-blankline.nvim',
    after = 'nvim-treesitter',
    setup = function()
      require('utils').on_file_open 'indent-blankline.nvim'
    end,
    config = function()
      require 'plugins.config.blankline'
    end,
  }


  use {
    'nvim-treesitter/nvim-treesitter',
    setup = function()
      require('utils').on_file_open 'nvim-treesitter'
    end,
    cmd = require('config').treesitter.cmds,
    run = ':TSUpdate',
    config = function()
      require 'plugins.config.treesitter'
    end,
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'sindrets/diffview.nvim'
  use {
    'TimUntersberger/neogit',
    after = 'plenary.nvim',
    config = function()
      require 'plugins.config.neogit'
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    setup = function()
      require('utils').packer_lazy_load 'gitsigns.nvim'
    end,
    -- config = function()
    --   require 'plugins.config.gitsigns'
    -- end,
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require 'plugins.config.toggleterm'
    end,
  }

  -- Keys
  use {
    'folke/which-key.nvim',
    setup = function()
      require('utils').packer_lazy_load 'which-key.nvim'
    end,
    -- config = function()
    --   require 'whichkey'
    -- end,
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    opt = true,
    cmd = require('config').lsp.cmds,
    setup = function()
      require('utils').on_file_open 'nvim-lsp-installer'
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    after = 'nvim-lsp-installer',
    module = 'lspconfig',
    config = function()
      require 'plugins.config.lsp'
    end,
  }

  use {
    'rafamadriz/friendly-snippets',
    module = 'cmp_nvim_lsp',
    event = 'InsertEnter',
  }

  use {
    'hrsh7th/nvim-cmp',
    after = 'friendly-snippets',
    config = function()
      require 'plugins.config.cmp'
    end,
  }

  use {
    'L3MON4D3/LuaSnip',
    wants = 'friendly-snippets',
    after = 'nvim-cmp',
    config = function()
      require 'plugins.config.luasnip'
    end,
  }

  use {
    'saadparwaiz1/cmp_luasnip',
    after = 'LuaSnip',
  }

  use {
    'hrsh7th/cmp-nvim-lua',
    after = 'cmp_luasnip',
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
    after = 'cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-buffer',
    after = 'cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-path',
    after = 'cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    after = 'cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    after = 'cmp-nvim-lua',
  }

  use {
    'mtoohey31/cmp-fish',
    after = 'cmp-nvim-lua',
  }

  use {
    'numToStr/Comment.nvim',
    module = 'Comment',
    keys = { 'gc', 'gb ' },
    config = function()
      require('Comment').setup()
    end,
  }

  -- use {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   setup = function ()
  --     require('utils').on_file_open 'null-ls.nvim'
  --   end,
  --   config = function ()
  --     require 'plugins.config.null_ls'
  --   end
  -- }

  -- Lsp Helpers
  use 'folke/trouble.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'onsails/lspkind.nvim'
  use 'simrat39/rust-tools.nvim'
  use 'p00f/clangd_extensions.nvim'
  use 'lukas-reineke/lsp-format.nvim'
  use 'folke/lua-dev.nvim'

  -- UI
  use {
    'kyazdani42/nvim-tree.lua',
    -- ft = 'dashboard?'
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require 'plugins.config.nvimtree'
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      require 'plugins.config.telescope'
    end,
    requires = {
      'nvim-telescope/telescope-media-files.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }

  use 'folke/todo-comments.nvim'
  use 'rcarriga/nvim-notify'
  use 'b0o/incline.nvim'
  use {
    'j-hui/fidget.nvim',
    config = function ()
      require('fidget').setup{}
    end
  }
  -- use {
  --   'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  --   config = function ()
  --     require('lsp_lines').register_lsp_virtual_lines()
  --   end
  -- }

  use 'ARM9/arm-syntax-vim'
  use 'jparise/vim-graphql'

  if packer_bootstrap then
    packer.sync()
  end
end)
