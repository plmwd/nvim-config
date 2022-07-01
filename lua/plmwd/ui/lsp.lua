local lsp_config = require('plmwd.config').lsp
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

M.setup = function()
  for type, icon in pairs(lsp_config.signs) do
    local hl = 'DiagnosticSign' .. type
    vim.cmd('sign define ' .. hl .. ' text=' .. icon .. ' texthl=' .. hl .. ' linehl= numhl=')
  end
  vim.diagnostic.config(lsp_config.diagnostic)

  local present, trouble = pcall(require, 'trouble')
  if present then
    trouble.setup {}
  end
end

M.setup_buffer = function(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    local lsp_hl_group = augroup('lsp_document_highlight', {})
    autocmd('CursorHold', {
      group = lsp_hl_group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight
    })
    autocmd('CursorMoved', {
      group = lsp_hl_group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references
    })
  end
end

return M
