local utils = require 'plmwd.utils'
local nmap = utils.nmap

local M = {}

local server_mappings = {
  rust_analyzer = {
    a = { '<cmd>RustEmitAsm<cr>', 'Emit ASM' },
    i = { '<cmd>RustToggleInlayHints<cr>', 'Toggle Inlay Hints' },
    r = { '<cmd>RustRunnables<cr>', 'Runnables' },
    R = { '<cmd>RustReloadWorkspace<cr>', 'Reload Workspace' },
    e = { '<cmd>RustExpandMacro<cr>', 'Expand Macro' },
    E = { '<cmd>RustExpand<cr>', 'Expand' },
    c = { '<cmd>RustOpenCargo<cr>', 'Open Cargo' },
    p = { '<cmd>RustParentModule<cr>', 'Parent Module' },
    P = { '<cmd>RustPlay<cr>', 'Play' },
    j = { '<cmd>RustMoveItemDown<cr>', 'Move Down' },
    k = { '<cmd>RustMoveItemUp<cr>', 'Move Up' },
    l = { '<cmd>RustJoinLines<cr>', 'Join Lines' },
    s = { '<cmd>RustSSR<cr>', 'SSR' },
    d = { '<cmd>RustOpenExternalDocs<cr>', 'Open Docs' },
  },
  clangd = {
    s = { '<cmd>ClangdSwitchSourceHeader<cr>', 'Switch Source/Header' },
  },
}

function M.setup(bufnr, server)
  local opts = { buffer = bufnr }
  local wk_present, wk = pcall(require, 'which-key')

  if server_mappings[server] then
    if wk_present then
      wk.register(server_mappings[server], { prefix = '<localleader>' })
    else
      for lhs, rhs in pairs(server_mappings[server]) do
        nmap('<localleader>' .. lhs, rhs[0])
      end
    end
  end

  nmap('gD', vim.lsp.buf.declaration, opts)
  nmap('gd', vim.lsp.buf.definition, opts)
  nmap('gi', vim.lsp.buf.implementation, opts)
  nmap('gu', vim.lsp.buf.incoming_calls, opts)
  nmap('K', vim.lsp.buf.hover, opts)
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
