local map = vim.keymap.set
local nmap = require('utils').nmap

local M = {}

M.setup = function()
  nmap(':', ';')
  nmap(';', ':')
  map({'n', 'v'}, 'H', '^')
  map({'n', 'v'}, 'L', '$')
  nmap('n', 'nzzzv')
  nmap('N', 'Nzzzv')
  nmap('/', 'ms/')
  nmap('?', 'ms?')
  nmap('*', 'ms*')
  nmap('<bs>', '<c-^>')
  nmap('<esc>', '<cmd>noh<cr>')
  nmap('<c-n>', '<cmd>cnext<cr>')
  nmap('<c-p>', '<cmd>cprev<cr>')
  nmap('<c-[>', '<cmd>bprev<cr>')
  nmap('<c-]>', '<cmd>bnext<cr>')

  nmap('<leader>gg', '<cmd>Neogit<cr>')
  nmap('<leader>gc', '<cmd>Neogit commit<cr>')
  nmap('<leader>ps', '<cmd>PackerSync<cr>')
end

M.lsp = {
  setup = function(bufnr)
    local opts = { buffer = bufnr, silent = true, }

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
    nmap('<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
    nmap('[d', vim.diagnostic.goto_prev, opts)
    nmap(']d', vim.diagnostic.goto_next, opts)
    nmap('<leader>ll', vim.lsp.diagnostic.set_loclist, opts)
    nmap('<leader>bf', vim.lsp.buf.formatting, opts)
  end,
  servers = {},
}

return M
