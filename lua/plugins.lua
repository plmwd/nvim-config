-- Shamelessly _borrowed_ from https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua
-- TODO: lsp-installer, lspoconfig, lspkind, lsp_signature in lsp.lua
local packer = nil

local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init {
      disable_commands = true,
      ensure_dependences = true,
    }
  end

  local use = packer.use
  packer.reset()
  use 'wbthomason/packer.nvim'


  -- LSP ------------------------------
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    'onsails/lspkind-nvim',
    'folke/trouble.nvim',
    'ray-x/lsp_signature.nvim',
    -- TODO: figure out how to set this up without being annoying
    -- 'kosayoda/nvim-lightbulb',
    {
      'brymer-meneses/grammar-guard.nvim',
      requires = {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
      },
    }
  }


  -- Completion ------------------------------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'petertriho/cmp-git' },
      { 'f3fora/cmp-spell', after = 'nvim-cmp' },
    },
    config = [[ require('config.cmp') ]],
    event = 'InsertEnter *',
  }


  -- Debugger ------------------------------
  use {
    {
      'mfussenegger/nvim-dap',
      -- setup = [[ require('config.dap_setup') ]],
      config = [[ require('config.dap') ]],
      requires = 'jbyuki/one-small-step-for-vimkind',
      wants = 'one-small-step-for-vimkind',
      module = 'dap',
    },
    {
      'rcarriga/nvim-dap-ui',
      requires = 'nvim-dap',
      after = 'nvim-dap',
      config = function() require('dapui').setup() end,
    },
    {
      'simrat39/rust-tools.nvim',
      after = 'nvim-dap',
      requires = { "mfussenegger/nvim-dap" },
      config = function() require("rust-tools").setup({}) end
    },
  }


  -- UI ------------------------------
  use {
    'hoob3rt/lualine.nvim',
    'akinsho/toggleterm.nvim',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
  }

  use {
    {
      'nvim-telescope/telescope.nvim',
      -- setup = [[ require('config.telescope_setup') ]],
      config = [[ require('config.telescope') ]],
      cmd = 'Telescope',
      module = {'Telescope', 'telescope', 'telescope.builtin'},
      requires = {
        'nvim-lua/popup.nvim', -- required by media files
        'nvim-telescope/telescope-media-files.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'kyazdani42/nvim-web-devicons',
        'ahmedkhalf/project.nvim',
      }
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- VCS ------------------------------
  use {
    'TimUntersberger/neogit',
    'tpope/vim-fugitive',
    'sindrets/diffview.nvim',
  }


  -- Util ------------------------------
  use {
    'windwp/nvim-autopairs',
    'tpope/vim-surround',
    'windwp/nvim-ts-autotag',
    {'numToStr/Comment.nvim', config = [[ require('Comment').setup() ]] },
    'andweeb/presence.nvim',
    'mizlan/iswap.nvim',
    'wakatime/vim-wakatime',
    'edluffy/specs.nvim',
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'glepnir/dashboard-nvim',
    'folke/zen-mode.nvim',
    'ThePrimeagen/refactoring.nvim',
  }

  -- TODO: maybe choose new event, or load on cmd
  use {
    'sudormrfbin/cheatsheet.nvim',
    event = 'VimEnter',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }

  use {
    'mvllow/modes.nvim',
    event = 'BufRead',
    -- TODO: move to plugin/..
    -- config = function()
    --   vim.opt.cursorline = true
    --   require('modes').setup()
    -- end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    -- config = function()
      -- TODO: move to plugin/..
      -- require('indent_blankline').setup {
      --   show_current_context = true,
      --   show_current_context_start = true,
      -- }
    -- end
  }

  -- TODO: Look at surround.vim
  -- use {
  --  config = function() require('nvim-autopairs').setup{} end,
  --  -- opt = true,
  -- }


  -- TODO: Do I need this?
  -- use {
  --   'mfussenegger/nvim-lint',
  --   config = function()
  --     require('lint').linters_by_ft = {
  --       typescript = {'eslint'},
  --     }
  --   end,
  -- }



  use {
    'lewis6991/gitsigns.nvim',
    event = 'VimEnter',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup() end
  }

  -- use 'ggandor/lightspeed.nvim'
  -- TODO: reconfigure - off by one and would like to default to the first match like normal vim
  -- (key bindings)

  use {
    'ahmedkhalf/project.nvim',
    event = 'VimEnter', -- TODO: is this really needed?
    config = function() require("project_nvim").setup {} end,
  }


  -- Filetypes ------------------------------
  use {
    'baskerville/vim-sxhkdrc',
  }

  -- vimtex is a pretty plugin
  use {
    'lervag/vimtex',
    ft = 'tex',
  }


  -- Color schemes ------------------------------
  use {
    'shaunsingh/moonlight.nvim',
    'folke/tokyonight.nvim',
    'EdenEast/nightfox.nvim',
    'marko-cerovac/material.nvim',
    'bluz71/vim-nightfly-guicolors',
    'shaunsingh/nord.nvim',
    'mangeshrex/uwu.vim',
    { 'rose-pine/neovim', as = 'rose-pine' },
    { 'catppuccin/nvim', as = 'catppuccin' },
  }
end

-- Makes init() be called before each packer command
local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
