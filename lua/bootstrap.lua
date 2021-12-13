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
}

M.install_default_ls = function()
  for _, server_name in pairs(default_installed_servers) do
    local server_available, requested_server = lsp_installer_servers.get_server(server_name)
    if requested_server and not requested_server:is_installed() then
      requested_server:install()
    end
  end
end

M.bootstrap = function()
  plugins.install()
  -- vim.cmd[[ autocmd User PackerComplete <cmd>lua require('bootstrap').install_default_ls() ]]
end

return M
