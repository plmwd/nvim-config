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

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)

        -- delete trailing whitespace
        if vim.g.trim_trailing_whitespace then
            vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])
        end

        -- delete lines @ eof
        if vim.g.trim_empty_eof_lines then
            vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])
        end

        local num_rows = vim.api.nvim_buf_line_count(0)

        if cursor_pos[1] > num_rows then
            cursor_pos[1] = num_rows
        end

        vim.api.nvim_win_set_cursor(0, cursor_pos)
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '.nvim.lua' },
    callback = function(event)
        vim.bo[event.buf].bufhidden = 'hide'
    end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    callback = function()
        if vim.wo.number and vim.fn.mode() ~= 'i' then
            vim.wo.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = false
        end
    end,
})
