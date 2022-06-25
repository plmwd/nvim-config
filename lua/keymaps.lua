local map = vim.keymap.set
local nmap = function(lhs, rhs, opts)
  vim.keymap.set('n', lhs, rhs, opts)
end
local imap = function(lhs, rhs, opts)
  vim.keymap.set('i', lhs, rhs, opts)
end
local tmap = function(lhs, rhs, opts)
  vim.keymap.set('t', lhs, rhs, opts)
end

nmap(':', ';')
nmap(';', ':')
map({'n', 'v'}, 'H', '^')
map({'n', 'v'}, 'L', '$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('/', 'ms/')
nmap('?', 'ms?')
nmap('*', 'ms*')
nmap('<bs>', '<c-^>')
nmap('<esc>', '<cmd>noh<cr>')
nmap('<c-n>', '<cmd>cnext<cr>')
nmap('<c-p>', '<cmd>cprev<cr>')
nmap('<c-[>', '<cmd>bprev<cr>')
nmap('<c-]>', '<cmd>bnext<cr>')

nmap('<leader>gg', '<cmd>Neogit<cr>')
nmap('<leader>gc', '<cmd>Neogit commit<cr>')
nmap('<leader>ps', '<cmd>PackerSync<cr>')
