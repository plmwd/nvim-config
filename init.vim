set tabstop=2
set softtabstop=2
set shiftwidth=2
set completeopt=menu,menuone,noselect
set foldexpr=expr
set cursorline
set mouse=a
set termguicolors
set scrolloff=5
set tw=80
set cc=+1
set ignorecase
set smartcase
set noswapfile
set showtabline=2

let g:mapleader=" "
let g:maplocalleader=","
let g:tokyonight_style="night"
let g:dashboard_default_executive="telescope"
let g:material_style="deep ocean"
let g:vimtex_view_method="zathura"

syn enable
" For some reason only works once vim is loaded...idfk why
lua vim.defer_fn(function() vim.cmd'syn on' end, 0)
colorscheme tokyonight

"--------------------------------------------------------
"--
"--									Keybindings
"--
"--------------------------------------------------------
nnoremap ; :
nnoremap : ;

nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>. <cmd>Telescope find_files<cr>
nnoremap <leader>] gt
nnoremap <leader>[ gT

" Fuzzy finders
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><space> <cmd>Telescope live_grep<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fe <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fm <cmd>Telescope man_pages<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>fca <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME'})<cr>
nnoremap <leader>fcn <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/nvim'})<cr>
nnoremap <leader>fcx <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/xmonad'})<cr>
nnoremap <leader>fcs <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/sway'})<cr>
nnoremap <leader>fck <cmd>lua require('telescope.builtin').find_files({ cwd = '$XDG_CONFIG_HOME/kitty'})<cr>
nnoremap <leader>fcd <cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/repos/dwm'})<cr>

" LSP
nnoremap <leader>lr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>lw <cmd>Telescope lsp_workspace_symbols<cr>

" Diagnostics (trouble)
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>

" Plugin management (packer)
nnoremap <leader>pc <cmd>PackerCompile<cr>
nnoremap <leader>ps <cmd>PackerSync<cr>

" Debugging (nvim-dap)
nnoremap <leader>db <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>dc <cmd>lua require'dap'.continue()<cr>
nnoremap <leader>di <cmd>lua require'dap'.step_into()<cr>
nnoremap <leader>do <cmd>lua require'dap'.step_over()<cr>
nnoremap <leader>dr <cmd>lua require'dap'.repl.open()<cr>

" Other
nnoremap <leader>? <cmd>Cheatsheet<cr>
nnoremap <esc> <cmd>noh<cr>
nnoremap cp <cmd>ISwap<cr>
nnoremap cP <cmd>ISwapWith<cr>
nnoremap <C-s> <cmd>w<cr>
nnoremap H ^
nnoremap L $
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <bs> <C-^>
nnoremap <tab> <C-w>w
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>ww <cmd>w<cr>
nnoremap <leader>wq <cmd>wq<cr>
nnoremap <leader>q <cmd>q<cr>
nnoremap <leader>wQ <cmd>wqa<cr>
nnoremap / ms/
nnoremap ? ms?
nnoremap * ms*

inoremap <C-e> <cmd>noh<cr>
inoremap <C-s> <cmd>w<cr>

"--------------------------------------------------------
"--
"--									Autocommands
"--
"--------------------------------------------------------
augroup packer_user_config
	autocmd!
	autocmd BufWritePost init.vim source <afile> | PackerCompile
augroup end

augroup latex
	autocmd!
	autocmd BufEnter *.tex setlocal spell
	autocmd BufEnter *.tex syn on
	" autocmd BufRead,BufNewFile *.tex syn match TexCmdNoSpell /"\\\w\+"/ contains=@NoSpell
augroup end

"--------------------------------------------------------
"--
"--									Syntax Highlighting
"--
"--------------------------------------------------------
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

"--------------------------------------------------------
"--
"--									Lua Config
"--
"--------------------------------------------------------
lua << EOF
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

default_installed_ts_support = {
	'lua',
	'rust',
	'bash',
	'c',
	'cpp',
	'css',
	'go',
	'html',
	'java',
	'javascript',
	'vim',
}

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
								vim.cmd('LspInstallInfo')
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

			if server.name == "texlab" then
				opts.root_dir = require'lspconfig/util'.root_pattern({'.git', 'main.tex'})
			end
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
		-- If you want insert `(` after select function or method item
end

function tele_setup()
	require'telescope'.setup({
		defaults = {
			layout_strategy = 'flex',
			winblend = 5,
			theme = 'dropdown',
		}
	})
	require('telescope').load_extension('projects')
end

function ts_setup()
	vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')

	require'nvim-treesitter.configs'.setup{
		ensure_installed = 'maintained',
		highlight = {
			enable = true,
		},

		--indent = {
		--	enable = true,
		--},

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

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

if not packer_bootstrap then
	-- require('impatient').enable_profile()
end

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	-- use 'lewis6991/impatient.nvim'
	use {
		'williamboman/nvim-lsp-installer',
		-- event = 'VimEnter',
		after = 'cmp-nvim-lsp',
		config = lsp_setup,
	}

	use 'dstein64/vim-startuptime'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

	use {
		"luukvbaal/nnn.nvim",
		config = function() require("nnn").setup() end
	}

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

	use 'wakatime/vim-wakatime'
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
		-- opt = true,
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

	use 'mfussenegger/nvim-dap'
	use { 
		"rcarriga/nvim-dap-ui", 
		requires = {"mfussenegger/nvim-dap"},
		config = function() require("dapui").setup() end
	}
	use {
		'simrat39/rust-tools.nvim',
		requires = {"mfussenegger/nvim-dap"},
		config = function() require("rust-tools").setup({}) end
	}



	use {
		'nvim-telescope/telescope.nvim',
		config = tele_setup,
		module = 'telescope',
		cmd = 'Telescope',
		event = 'VimEnter',
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


	--[[
	use {
		'ellisonleao/glow.nvim',
		filetype = 'markdown',
		run = ':GlowInstall',
	}
	--]]

	use {
		'mizlan/iswap.nvim',
		config = function()
			require('iswap').setup({
				autoswap = true,
			})
		end,
		event = 'InsertEnter',
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
		ft = 'tex',
	}

	use {
		'RRethy/nvim-treesitter-textsubjects',
		after = 'nvim-treesitter',
	}


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
		'ahmedkhalf/project.nvim',
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
EOF
