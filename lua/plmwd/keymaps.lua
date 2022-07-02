local map = vim.keymap.set
local utils = require 'plmwd.utils'
local nmap, tmap = utils.nmap, utils.tmap

nmap(':', ';', { silent = false })
nmap(';', ':', { silent = false })
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('/', 'ms/', { silent = false })
nmap('<c-/>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { silent = false })
nmap('?', 'ms?', { silent = false })
nmap('*', 'ms*')
nmap('<bs>', '<c-^>')
nmap('<esc>', '<cmd>noh<cr>')
nmap('<c-n>', '<cmd>cnext<cr>')
nmap('<c-p>', '<cmd>cprev<cr>')

nmap('<leader>gg', '<cmd>Neogit<cr>')
nmap('<leader>gd', '<cmd>DiffviewOpen<cr>')
nmap('<leader>gD', function()
  vim.ui.input({ prompt = 'git path: ' }, function(input)
    vim.cmd('DiffviewOpen ' .. input)
  end)
end)

nmap('<leader>ps', '<cmd>PackerSync<cr>')
nmap('<leader>pc', '<cmd>PackerCompile<cr>')

nmap('<leader>cn', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
nmap('<leader>ck', '<cmd>Telescope find_files cwd=~/.config/kitty<cr>')

nmap('<leader>`', '<cmd>NvimTreeFindFile<cr>')
nmap('<leader>~', '<cmd>NvimTreeFocus<cr>')
nmap('<leader><tab>', '<cmd>NvimTreeToggle<cr>')

nmap('<leader>f', '<cmd>Telescope find_files<cr>')

nmap('<leader>bb', '<cmd>Telescope buffers<cr>')
-- nmap('<leader>bp',)

nmap('<leader>=', '<cmd>Telescope projects<cr>')
nmap('<leader>/', '<cmd>Telescope live_grep<cr>')

-- Let <leader>tnn toggle the line column and remember if rnu was set
nmap('<leader>tnn', function()
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
nmap('<leader>tnr', function()
  if vim.opt.nu:get() then
    vim.opt.rnu = not vim.opt.rnu:get()
    vim.g.was_rnu = not vim.g.was_rnu
  else
    vim.opt.rnu = true
    vim.opt.nu = true
    vim.g.was_rnu = true
  end
end)

nmap('<leader>tdv', function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end)

nmap('<leader>xx', '<cmd>Trouble document_diagnostics<cr>')
nmap('<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')

nmap('<leader>tds', vim.diagnostic.show)
nmap('<leader>tdh', vim.diagnostic.hide)

tmap('<c-j><c-k>', '<c-\\><c-n>')
tmap('<c-j>', '<c-\\><c-n><c-W>j')
tmap('<c-k>', '<c-\\><c-n><c-W>k')
tmap('<c-h>', '<c-\\><c-n><c-W>h')
tmap('<c-l>', '<c-\\><c-n><c-W>l')
