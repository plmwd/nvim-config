vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'qf',
        'help',
        'man',
        'notify',
        'lspinfo',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'PlenaryTestPopup',
        'dashboard',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { on_visual = false }
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.spell = false
    end
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { 'help', 'dashboard', 'man' },
    callback = function()
        vim.bo.spell = false
    end
})
