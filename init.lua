-- Simple single file nvim config
--
-- Layout:
-- 	Options & settings
-- 	Keybindings
-- 	Packer setup
-- 	Plugin setup
-- 	LSP setup
--
--
local cmd = vim.cmd
local o = vim.opt
local g = vim.g
local wo = vim.wo
local map = function(mode, lhs, rhs, opts)
	opts = opts or {noremap=true, silent=true}
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- require('impatient').enable_profile()
--------------------------------------------------------
--
--									Options
--
--------------------------------------------------------
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.completeopt = 'menu,menuone,noselect'
o.foldexpr = 'expr'
o.cursorline = true
o.mouse = 'a'
o.termguicolors = true

g.mapleader = ' '
g.maplocalleader = ','
g.tokyonight_style = 'night'
g.dashboard_default_executive = 'telescope'
g.material_style = 'deep ocean'

wo.colorcolumn = '81'

colorscheme = 'material'


-- Disable default plugins
g.loaded_gzip         = 1
g.loaded_tar          = 1
g.loaded_tarPlugin    = 1
g.loaded_zipPlugin    = 1
g.loaded_2html_plugin = 1
g.loaded_netrw        = 1
g.loaded_netrwPlugin  = 1
g.loaded_matchit      = 1
g.loaded_matchparen   = 1
g.loaded_spec         = 1

--------------------------------------------------------
--
--									Keybindings
--
--------------------------------------------------------
cmd[[
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
	nnoremap <leader>fe <cmd>lua require('telescope.builtin').file_browser()<cr>
	nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>fm <cmd>lua require('telescope.builtin').man_pages()<cr>
	nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
	nnoremap <leader>fp <cmd>Telescope projects<cr>

	nnoremap <leader>fca <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME'})<cr>

	nnoremap <leader>fcn <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/nvim'})<cr>
	nnoremap <leader>fcx <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/xmonad'})<cr>
	nnoremap <leader>fcs <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/sway'})<cr>
	nnoremap <leader>fcd <cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/repos/dwm'})<cr>

	nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
	nnoremap <leader>fw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

	nnoremap <leader>xx <cmd>TroubleToggle<cr>
	nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
	nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
	nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
	nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

]]

map('n', '<leader>?', '<cmd>Cheatsheet<cr>')
map('n', '<esc>', '<cmd>noh<cr>')
map('n', 'cp', '<cmd>ISwap<cr>')
map('n', 'cP', '<cmd>ISwapWith<cr>')
map('n', '<C-s>', '<cmd>w<cr>')
map('i', '<C-s>', '<cmd>w<cr>')


--------------------------------------------------------
--
--									Additional Settings
--
--------------------------------------------------------
default_installed_servers = {
	'rust_analyzer',
	'sumneko_lua',
	'bashls',
	'clangd',
	'cmake',
	'cssls',
	'denols',
	'texlab',
	'pyright',
	'vimls',
}


--------------------------------------------------------
--
--									Packer Setup
--
--------------------------------------------------------
-- Borrowed from NvChad :)
-- packer_lazy_load = function(plugin, timer)
--    if plugin then
--       timer = timer or 0
--       vim.defer_fn(function()
--          require("packer").loader(plugin)
--       end, timer)
--    end
-- end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'lewis6991/impatient.nvim'
	use {
		'williamboman/nvim-lsp-installer',
		after = 'cmp-nvim-lsp',
		config = lsp_setup,
	}

	use 'dstein64/vim-startuptime'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

	-- LSP source for nvim-cmp
  use {
		'hrsh7th/cmp-nvim-lsp',
		after = 'nvim-cmp',
	}

	-- Snippets source for nvim-cmp
  use {
		'saadparwaiz1/cmp_luasnip',
		after = 'nvim-cmp',
	}

	-- Snippets plugin
  use {
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
	}

	use {
		'hrsh7th/cmp-buffer',
		after = 'nvim-cmp',
	}

	use {
		'hrsh7th/nvim-cmp',
		after = 'LuaSnip',
		config = cmp_setup,
		requires = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
			'windwp/nvim-autopairs',
		}
	}

	use {
		'windwp/nvim-autopairs',
		config = function() require('nvim-autopairs').setup{} end,
	}

	use {
		'sudormrfbin/cheatsheet.nvim',
		event = 'VimEnter',
		-- config = function()
		-- 	require("cheatsheet").setup({
		-- 		bundled_cheatsheets = {
		-- 				-- only show the default cheatsheet
		-- 				enabled = { "default" },
		-- 		},
		-- 		bundled_plugin_cheatsheets = true,
		-- 	})
		-- end,

		requires = {
			{'nvim-telescope/telescope.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-lua/plenary.nvim'},
		}
	}

	-- Lua
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		after = 'nvim-cmp',
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		config = ts_setup,
		run = ':TSUpdate',
	}

	use {
		'kyazdani42/nvim-web-devicons',
		module = 'nvim-web-devicons',
	}

	use {
		'nvim-telescope/telescope.nvim',
		config = tele_setup,
		module = 'telescope',
		cmd = 'Telescope',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'kyazdani42/nvim-web-devicons',
			'ahmedkhalf/project.nvim',
		}
	}

	use {
    "nvim-lua/plenary.nvim",
    module = "plenary"
  }

	use 'glepnir/dashboard-nvim'

	use {
		'lewis6991/gitsigns.nvim',
		event = 'VimEnter',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup()
		end
	}


	use {
		'ellisonleao/glow.nvim',
		filetype = 'markdown',
		run = ':GlowInstall',
	}

	use {
		'mizlan/iswap.nvim',
		config = function()
			require('iswap').setup({
				autoswap = true,
			})
		end,
	}

	--[[
	use {
		'phaazon/hop.nvim',
		as = 'hop',
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	}
	--]]

	use 'ggandor/lightspeed.nvim'


	use {
		'lervag/vimtex',
		ft = 'latex',
	}

	use 'RRethy/nvim-treesitter-textsubjects'

	use {
		'hoob3rt/lualine.nvim',
		config = lualine_setup,
		requires = {
			'kyazdani42/nvim-web-devicons',
			'folke/tokyonight.nvim',
		}
	}

	use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
	}

	use {
		"ahmedkhalf/project.nvim",
		event = 'VimEnter',
		-- requires = {'nvim-telescope/telescope.nvim'},
		config = function()
			require("project_nvim").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}



	-- Color schemes
	use 'shaunsingh/moonlight.nvim'
	use 'folke/tokyonight.nvim'
	use 'EdenEast/nightfox.nvim'
	use 'marko-cerovac/material.nvim'
	use 'bluz71/vim-nightfly-guicolors'
	use 'shaunsingh/nord.nvim'
	use 'mangeshrex/uwu.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

--------------------------------------------------------
--
--										LSP Setup
--
--------------------------------------------------------

function lsp_on_attach()
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

function lsp_setup()
	local lsp_installer = require("nvim-lsp-installer")

	-- Automatically install default servers
	vim.defer_fn(function()
		local lsp_installer_servers = require'nvim-lsp-installer.servers'
		local lsp_installer_win_open = false

		for _, server_name in pairs(default_installed_servers) do
			local ok, server = lsp_installer_servers.get_server(server_name)
			if ok then
					if not server:is_installed() then
							server:install()
							if not lsp_installer_win_open then
								vim.cmd('LspInstallInfo<cr>')
								lsp_installer_win_open = true
							end
					end
			end
		end
	end, 1000)

	lsp_installer.on_server_ready(function(server)
			local opts = {}
			local on_attach = lsp_on_attach

			-- Add additional capabilities supported by nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

			opts.on_attach = on_attach
			opts.capabilities = capabilities
			-- (optional) Customize the options passed to the server
			-- if server.name == "tsserver" then
			--     opts.root_dir = function() ... end
			-- end

			-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
			server:setup(opts)
			vim.cmd [[ do User LspAttachBuffers ]]
	end)
end

------------ Plugin Configuration ------------
-- luasnip setup

-- nvim-cmp setup
function cmp_setup()
	local luasnip = require 'luasnip'
	local cmp = require 'cmp'
	cmp.setup {
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		mapping = {
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<Tab>'] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end,
			['<S-Tab>'] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end,
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
	}

		-- you need setup cmp first put this after cmp.setup()
	require("nvim-autopairs.completion.cmp").setup({
		map_cr = true, --  map <CR> on insert mode
		map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
		auto_select = true, -- automatically select the first item
		insert = false, -- use insert confirm behavior instead of replace
		map_char = { -- modifies the function or method delimiter by filetypes
			all = '(',
			tex = '{'
		}
	})

end

function tele_setup()
	require'telescope'.setup({
		defaults = {
			theme = 'dropdown'
		}
	})
	require('telescope').load_extension('projects')
end

function ts_setup()
	vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')

	require'nvim-treesitter.configs'.setup{
		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},

		textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
        }
    },

	}
end

function lualine_setup()
	local alt_theme_name = {
		material = 'material-nvim',
	}

	require('lualine').setup({
		options = {
			theme = alt_theme_name[colorscheme] or colorscheme,
			section_separators = {'', ''},
			component_separators = {'|', '|'}
		}
	})
end

--------------------------------------------------------
--
--									Autocommands
--
--------------------------------------------------------

cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]]

cmd('colorscheme ' .. colorscheme)
