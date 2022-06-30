local installer_present, lsp_installer = pcall(require, 'nvim-lsp-installer')
local lspconfig_present, lspconfig = pcall(require, 'lspconfig')
local navic_present, navic = pcall(require, 'nvim-navic')
local lsp_format_present, lsp_format = pcall(require, 'lsp-format')

if not installer_present or not lspconfig_present then
  return
end

local keymaps = require 'keymaps.lsp'
local lsp_ui = require 'ui.lsp'
local config = require 'config'

lsp_installer.setup {
  automatic_installation = true,
}
lsp_ui.setup()

if lsp_format_present then
  lsp_format.setup()
end

local function make_on_attach(server)
  return function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    keymaps.setup(bufnr, server)
    lsp_ui.setup_buffer(client, bufnr)

    if navic_present then
      navic.attach(client, bufnr)
    end

    if lsp_format_present then
      lsp_format.on_attach(client)
    end
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
