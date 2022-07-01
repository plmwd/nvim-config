local map = vim.keymap.set
local utils = require 'plmwd.utils'
local nmap, tmap = utils.nmap, utils.tmap

local M = {}

function M.setup(bufnr, server)
  local opts = { buffer = bufnr }

  nmap('gD', vim.lsp.buf.declaration, opts)
  nmap('gd', vim.lsp.buf.definition, opts)
  nmap('K', vim.lsp.buf.hover, opts)
  nmap('gi', vim.lsp.buf.implementation, opts)
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
