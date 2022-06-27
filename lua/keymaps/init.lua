local map = vim.keymap.set
local utils = require 'utils'
local nmap, tmap = utils.nmap, utils.tmap

nmap(':', ';', { silent = false })
nmap(';', ':', { silent = false })
map({'n', 'v'}, 'H', '^')
map({'n', 'v'}, 'L', '$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('/', 'ms/', { silent = false})
nmap('?', 'ms?', { silent = false})
nmap('*', 'ms*')
nmap('<bs>', '<c-^>')
nmap('<esc>', '<cmd>noh<cr>')
nmap('<c-n>', '<cmd>cnext<cr>')
nmap('<c-p>', '<cmd>cprev<cr>')

nmap('<leader>g', '<cmd>Neogit<cr>')
nmap('<leader>ps', '<cmd>PackerSync<cr>')
nmap('<leader>pc', '<cmd>PackerCompile<cr>')

nmap('<leader>,', '<cmd>NvimTreeFindFile<cr>')

nmap('<leader>f', '<cmd>Telescope find_files<cr>')
nmap('<leader>/', '<cmd>Telescope live_grep<cr>')

tmap('<c-j><c-k>', '<c-\\><c-n>')
tmap('<c-j>', '<c-\\><c-n><c-W>j')
tmap('<c-k>', '<c-\\><c-n><c-W>k')
tmap('<c-h>', '<c-\\><c-n><c-W>h')
tmap('<c-l>', '<c-\\><c-n><c-W>l')
