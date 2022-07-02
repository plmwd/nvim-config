local lsp_config = require('plmwd.config').lsp
local augroup = function(name) vim.api.nvim_create_augroup(name, {}) end
local autocmd = vim.api.nvim_create_autocmd

local M = {}

function M.setup()
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

function M.setup_buffer(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    local lsp_hl_group = augroup('lsp_document_highlight')
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

  if client.resolved_capabilities.code_lens then
    local codelens_group = augroup('lsp_codelens')
    autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      group = codelens_group,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end
end

return M
