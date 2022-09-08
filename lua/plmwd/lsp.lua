local lspconfig_present, lspconfig = pcall(require, 'lspconfig')

if not lspconfig_present then
  return
end

local keymaps = require 'plmwd.keymaps.lsp'
local lsp_ui = require 'plmwd.ui.lsp'
local config = require 'plmwd.config'
local utils = require 'plmwd.utils'

utils.safe_setup('nvim-lsp-installer', {
  automatic_installation = true,
})

lsp_ui.setup()

utils.safe_setup('lsp-format', {})
utils.safe_setup('lua-dev', {})

local function make_on_attach(server)
  return function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    keymaps.setup(bufnr, server)
    lsp_ui.setup_buffer(client, bufnr)

    utils.safe_setup('nvim-navic', function(navic)
      navic.attach(client, bufnr)
    end)

    utils.safe_setup('lsp-format', function(lsp_format)
      lsp_format.on_attach(client)
    end)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for server, spec in pairs(config.lsp.servers) do
  local on_attach = make_on_attach(server)
  if vim.is_callable(spec) then
    spec(on_attach, capabilities)
  else
    if spec.on_attach then
      local spec_on_attach = spec.on_attach
      spec.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        spec_on_attach(client, bufnr)
      end
    else
      spec.on_attach = on_attach
    end
    spec.capabilities = vim.tbl_deep_extend('force', capabilities, spec.capabilities or {})
    lspconfig[server].setup(spec)
  end
end
