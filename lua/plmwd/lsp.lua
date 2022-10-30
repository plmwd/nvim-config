local lspconfig_present, lspconfig = pcall(require, 'lspconfig')

if not lspconfig_present then
  vim.notify('error loading lsp config', vim.log.levels.ERROR)
  return
end

local keymaps = require 'plmwd.keymaps.lsp'
local lsp_ui = require 'plmwd.ui.lsp'
local config = require 'plmwd.config'

lsp_ui.setup()

safe_setup('lsp-format')
safe_setup('neodev')
safe_setup('mason').next('mason-lspconfig', { automatic_installation = true })

local function on_attach(client, bufnr)
  local server = client.name

  keymaps.setup(bufnr, server)
  lsp_ui.setup_buffer(client, bufnr)

  safe_setup('nvim-navic', function(navic)
    navic.attach(client, bufnr)
  end)

  safe_setup('lsp-format', function(lsp_format)
    lsp_format.on_attach(client)
  end)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- spec is a function(client, bufnr) to manually setup server
-- Or, it's a table to be passed to lspconfig[<server>].setup()
for server, spec in pairs(config.lsp.servers) do
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
