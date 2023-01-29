local M = {}

-- TODO: use desc opt for vim.keymap.set
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

function M.on_attach(client, bufnr)
    local opts = { buffer = bufnr }
    local wk_present, wk = pcall(require, 'which-key')
    local server = client.name

    if server_mappings[server] then
        if wk_present then
            wk.register(server_mappings[server], { prefix = '<localleader>' })
        else
            for lhs, rhs in pairs(server_mappings[server]) do
                vim.keymap.set('n', '<localleader>' .. lhs, rhs[0])
            end
        end
    end

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gu', vim.lsp.buf.incoming_calls, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'J', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>bf', '<cmd>Format<cr>', opts)
end

return M
