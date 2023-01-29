local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end

local M = {}

function M.on_attach(client, bufnr)
    if client.server_capabilities.document_highlight then
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

    if client.server_capabilities.code_lens then
        local codelens_group = augroup('lsp_codelens')
        autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            group = codelens_group,
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end
end

return M
