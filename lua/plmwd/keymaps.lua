local utils = require('plmwd.utils')
-- local git = require('plmwd.git')

vim.keymap.set('n', ':', ';', { silent = false })
vim.keymap.set('n', ';', ':', { silent = false })
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set({ 'n', 'v' }, 'L', '$')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '/', 'ms/', { silent = false })
vim.keymap.set('n', '<c-/>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { silent = false })
vim.keymap.set('n', '?', 'ms?', { silent = false })
vim.keymap.set('n', '*', 'ms*N')
vim.keymap.set('n', '<bs>', '<c-^>')
vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')
vim.keymap.set('n', '<c-n>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<c-p>', '<cmd>cprev<cr>zz')
-- vim.keymap.set('n', '[[', '[[zt')
-- vim.keymap.set('n', ']]', ']]zt')

vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>')
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>gD', function()
    vim.ui.input({ prompt = 'git path: ' }, function(input)
        vim.cmd('DiffviewOpen ' .. input)
    end)
end)

-- vim.keymap.set('n', '<leader>ps', '<cmd>PackerSync<cr>')
-- vim.keymap.set('n', '<leader>pc', '<cmd>PackerCompile<cr>')
-- vim.keymap.set('n', '<leader>pp', function()
--     local packer = require 'packer'
--     git.pull({ rebase = true, cwd = utils.config_dir })
--     vim.notify('pulled neovim config')
--     packer.sync()
-- end)
--
-- vim.keymap.set('n', '<leader>pP', function()
--     git.context({ cwd = utils.config_dir }, function()
--         if not git.pull({ rebase = true }) then return end
--         if not git.commit({ all = true, mes = 'A very creative message' }) then return end
--         if not git.push() then return end
--         vim.notify('Updated Neovim config')
--     end)
-- end)

vim.keymap.set('n', '<leader>cn', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
vim.keymap.set('n', '<leader>ck', '<cmd>Telescope find_files cwd=~/.config/kitty<cr>')

vim.keymap.set('n', '<leader>[', '<cmd>NvimTreeFindFile<cr>')
-- vim.keymap.set('n', '<leader>{', function()
--     require('nvim-tree.api').tree.toggle(true, true, vim.fn.getcwd())
-- end)

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope grep_string<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')
-- vim.keymap.set('n', '<leader>fcn', string.format('<cmd>Telescope find_files cwd=%s<cr>', ))

vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>')
-- vim.keymap.set('n', '<leader>bp',)

vim.keymap.set('n', '<leader>=', '<cmd>Telescope projects<cr>')
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>')

vim.keymap.set('n', '<leader>]', '<cmd>SymbolsOutline<cr>')

vim.keymap.set('n', '<leader>ww', function() require('nvim-window').pick() end)
vim.keymap.set('n', '<leader>wp', '<c-w>p')
vim.keymap.set('n', '<leader>wm', '<c-w>|<c-w>_')
vim.keymap.set('n', '<leader>w=', '<c-w>=')
vim.keymap.set('n', '<leader>wh', '<c-w>h')
vim.keymap.set('n', '<leader>wj', '<c-w>j')
vim.keymap.set('n', '<leader>wk', '<c-w>k')
vim.keymap.set('n', '<leader>wl', '<c-w>l')
vim.keymap.set('n', '<leader>wH', '<c-w>H')
vim.keymap.set('n', '<leader>wJ', '<c-w>J')
vim.keymap.set('n', '<leader>wK', '<c-w>K')
vim.keymap.set('n', '<leader>wL', '<c-w>L')
vim.keymap.set('n', '<leader>wf', '<c-w>gf')
vim.keymap.set('n', '<leader>wF', '<c-w>gF')

-- Let <leader>tnn toggle the line column and remember if rnu was set
vim.keymap.set('n', '<leader>tnn', function()
    if vim.opt.nu:get() or vim.opt.rnu:get() then
        vim.g.was_rnu = vim.opt.rnu:get()
        vim.opt.rnu = false
        vim.opt.nu = false
    else
        vim.opt.rnu = vim.g.was_rnu
        vim.opt.nu = true
    end
end)

-- Toggle rnu if nu is set, else enable rnu and nu since I like seeing the current line number
vim.keymap.set('n', '<leader>tnr', function()
    if vim.opt.nu:get() then
        vim.opt.rnu = not vim.opt.rnu:get()
        vim.g.was_rnu = not vim.g.was_rnu
    else
        vim.opt.rnu = true
        vim.opt.nu = true
        vim.g.was_rnu = true
    end
end)

vim.keymap.set('n', '<leader>tdv', function()
    local lines_present, lsp_lines = pcall(require, 'lsp_lines')
    if lines_present then
        lsp_lines.toggle()
    else
        vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
    end
end)

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble document_diagnostics<cr>')
vim.keymap.set('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')

vim.keymap.set('n', '<leader>tds', vim.diagnostic.show)
vim.keymap.set('n', '<leader>tdh', vim.diagnostic.hide)

vim.keymap.set('n', '<leader>e', function()
    local file_dir = vim.fn.expand('%:p:h')
    vim.cmd('Telescope file_browser path=' .. file_dir)
end)

vim.keymap.set('t', '<c-j><c-k>', '<c-\\><c-n>')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><c-W>j')
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><c-W>k')
vim.keymap.set('t', '<c-h>', '<c-\\><c-n><c-W>h')
-- tmap('<c-l>', '<c-\\><c-n><c-W>l')

-- vmap('s', '"zy:Telescope live_grep default_text=<C-r>z<cr>')


vim.keymap.set('n', '<leader>zz', '<cmd>TZAtaraxis<cr>')
vim.keymap.set('n', '<leader>zm', '<cmd>TZMinimalist<cr>')
