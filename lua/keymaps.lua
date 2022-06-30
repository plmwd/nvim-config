local map = vim.keymap.set
local utils = require 'utils'
local nmap, tmap = utils.nmap, utils.tmap

nmap(':', ';', { silent = false })
nmap(';', ':', { silent = false })
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('/', 'ms/', { silent = false })
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

nmap('<leader>f', '<cmd>Telescope find_files<cr>')
nmap('<leader>bb', '<cmd>Telescope buffers<cr>')
nmap('<leader>=', '<cmd>Telescope projects<cr>')
nmap('<leader>/', '<cmd>Telescope live_grep<cr>')

tmap('<c-j><c-k>', '<c-\\><c-n>')
tmap('<c-j>', '<c-\\><c-n><c-W>j')
tmap('<c-k>', '<c-\\><c-n><c-W>k')
tmap('<c-h>', '<c-\\><c-n><c-W>h')
tmap('<c-l>', '<c-\\><c-n><c-W>l')
