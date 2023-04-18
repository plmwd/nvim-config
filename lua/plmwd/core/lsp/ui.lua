local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name) vim.api.nvim_create_augroup(name, { clear = true }) end

local M = {}

function M.on_attach(client, bufnr)
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
    end
    if client.server_capabilities.documentHighlightProvider then
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

    if client.server_capabilities.codeLensProvider then
        local codelens_group = augroup('lsp_codelens')
        autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            group = codelens_group,
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
    end
end

return M
