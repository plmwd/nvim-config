local utils = require 'plmwd.utils'
local nmap = utils.nmap

local M = {}

local server_mappings = {
  rust_analyzer = {
    a = '<cmd>RustEmitAsm<cr>',
    i = '<cmd>RustToggleInlayHints<cr>',
    r = '<cmd>RustRunnables<cr>',
    R = '<cmd>RustReloadWorkspace<cr>',
    e = '<cmd>RustExpandMacro<cr>',
    E = '<cmd>RustExpand<cr>',
    c = '<cmd>RustOpenCargo<cr>',
    p = '<cmd>RustParentModule<cr>',
    P = '<cmd>RustPlay<cr>',
    j = '<cmd>RustMoveItemDown<cr>',
    k = '<cmd>RustMoveItemUp<cr>',
    l = '<cmd>RustJoinLines<cr>',
    s = '<cmd>RustSSR<cr>',
    d = '<cmd>RustOpenExternalDocs<cr>',
  }
}

function M.setup(bufnr, server)
  local opts = { buffer = bufnr }

  if server_mappings[server] then
    for lhs, rhs in pairs(server_mappings[server]) do
      nmap('<localleader>' .. lhs, rhs)
    end
  end

  nmap('gD', vim.lsp.buf.declaration, opts)
  nmap('gd', vim.lsp.buf.definition, opts)
  nmap('K', vim.lsp.buf.hover, opts)
  nmap('gi', vim.lsp.buf.implementation, opts)
  nmap('gl', function()
    local lens = utils.get_nearest_codelens(0, 0)
    iprint(lens)
    if not lens then
      return
    end

    local pos = lens.range.start
    -- WARN: rust_analyzer is 0-indexed, but others could not be. Don't have any other examples atm
    vim.api.nvim_win_set_cursor(0, { pos.line + 1, pos.character })
    vim.defer_fn(function()
      vim.lsp.codelens.run()
    end, 50)
  end)
  nmap('J', vim.lsp.buf.signature_help, opts)
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  nmap('<leader>D', vim.lsp.buf.type_definition, opts)
  nmap('<leader>rn', vim.lsp.buf.rename, opts)
  nmap('<leader>ca', vim.lsp.buf.code_action, opts)
  nmap('gr', vim.lsp.buf.references, opts)
  nmap('[d', vim.diagnostic.goto_prev, opts)
  nmap(']d', vim.diagnostic.goto_next, opts)
  nmap('<leader>bf', '<cmd>Format<cr>', opts)
end

return M
