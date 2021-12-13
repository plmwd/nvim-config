local plugins = require('plugins')

local M = {}

local default_installed_servers = {
	'rust_analyzer',
	'sumneko_lua',
	'bashls',
	'clangd',
	'cmake',
	'cssls',
	-- 'denols',
	-- 'texlab',
	'pyright',
	'vimls',
  'ltex',
}

M.install_default_ls = function()
  local lsp_installer_servers = require'nvim-lsp-installer.servers'

  for _, server_name in pairs(default_installed_servers) do
    local ok, requested_server = lsp_installer_servers.get_server(server_name)
    if ok and requested_server and not requested_server:is_installed() then
      requested_server:install()
    end
  end
end

M.post_sync_bootstrap = function()
  M.install_default_ls()
end

M.bootstrap = function()
  plugins.sync()
  vim.cmd[[ autocmd User PackerComplete lua require('bootstrap').post_sync_bootstrap() ]]
end

return M
