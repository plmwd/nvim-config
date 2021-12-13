local lsp_installer = require("nvim-lsp-installer")
local trouble = require 'trouble'
local lspkind = require 'lspkind'

local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap
local cmd = vim.cmd
local sign_define = vim.fn.sign_define

local kind_symbols = {
  Text = '',
  Method = 'Ƒ',
  Function = 'ƒ',
  Constructor = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '了',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
}


local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
lspkind.init { symbol_map = kind_symbols }
trouble.setup()
require('lsp_signature').setup { bind = true, handler_opts = { border = 'single' } }
require("grammar-guard").init()

-- TODO: only do this with Bootstrap command
-- Automatically install default servers
-- vim.defer_fn(function()
--   local lsp_installer_servers = require'nvim-lsp-installer.servers'
--   local lsp_installer_win_open = false
--
--   for _, server_name in pairs(default_installed_servers) do
--     local ok, server = lsp_installer_servers.get_server(server_name)
--     if ok then
--         if not server:is_installed() then
--             server:install()
--             if not lsp_installer_win_open then
--               vim.cmd('LspInstallInfo')
--               lsp_installer_win_open = true
--             end
--         end
--     end
--   end
-- end, 1000)

local function on_attach(client, bufnr)
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
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
end
end

local servers = {
  texlab = {
    root_dir = require'lspconfig/util'.root_pattern({'.git', 'main.tex'}),
  },
  tsserver = {
    extra_on_attach = function(client, bufnr)
      vim.cmd[[ au BufWritePost <buffer> lua require('lint').try_lint() ]]
    end,
  },
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          },
        },
      },
    },
  },
  grammar_guard = {
    settings = {
      ltex = {
        enabled = { "latex", "tex", "bib", "markdown" },
        language = "en",
        diagnosticSeverity = "information",
        setenceCacheSize = 2000,
        additionalRules = {
          enablePickyRules = true,
          motherTongue = "en",
        },
        trace = { server = "verbose" },
        dictionary = {},
        disabledRules = {},
        hiddenFalsePositives = {},
      },
    }
	},
}

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name] or {}

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  if config.extra_on_attach then
    config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      config.extra_on_attach(client, bufnr)
    end
  end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(config)
  vim.cmd [[ do User LspAttachBuffers ]]
end)
