local map = vim.keymap.set
local utils = require 'plmwd.utils'
local nmap, tmap, vmap = utils.nmap, utils.tmap, utils.vmap
local git = require 'plmwd.git'
local packer = require 'packer'

nmap(':', ';', { silent = false })
nmap(';', ':', { silent = false })
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('/', 'ms/', { silent = false })
nmap('<c-/>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { silent = false })
nmap('?', 'ms?', { silent = false })
nmap('*', 'ms*N')
nmap('<bs>', '<c-^>')
nmap('<esc>', '<cmd>noh<cr>')
nmap('<c-n>', '<cmd>cnext<cr>zz')
nmap('<c-p>', '<cmd>cprev<cr>zz')
nmap('[[', '[[zt')
nmap(']]', ']]zt')

nmap('<leader>1', '1gt')
nmap('<leader>2', '2gt')
nmap('<leader>3', '3gt')
nmap('<leader>4', '4gt')
nmap('<leader>5', '5gt')
nmap('<leader>6', '6gt')
nmap('<leader>7', '7gt')
nmap('<leader>8', '8gt')
nmap('<leader>9', '9gt')

nmap('<leader>gg', '<cmd>Neogit<cr>')
nmap('<leader>gd', '<cmd>DiffviewOpen<cr>')
nmap('<leader>gD', function()
  vim.ui.input({ prompt = 'git path: ' }, function(input)
    vim.cmd('DiffviewOpen ' .. input)
  end)
end)

nmap('<leader>ps', '<cmd>PackerSync<cr>')
nmap('<leader>pc', '<cmd>PackerCompile<cr>')
nmap('<leader>pp', function()
  git.pull({ rebase = true, cwd = utils.config_dir })
  vim.notify('pulled neovim config')
  packer.sync()
end)

nmap('<leader>pP', function()
  git.context({ cwd = utils.config_dir }, function()
    if not git.pull({ rebase = true }) then return end
    if not git.commit({ all = true, mes = 'A very creative message' }) then return end
    if not git.push() then return end
    vim.notify('Updated Neovim config')
  end)
end)

nmap('<leader>cn', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
nmap('<leader>ck', '<cmd>Telescope find_files cwd=~/.config/kitty<cr>')

nmap('<leader>[', '<cmd>NvimTreeFindFile<cr>')
nmap('<leader>{', function()
  require('nvim-tree.api').tree.toggle(true, true, vim.fn.getcwd())
end)

nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fs', '<cmd>Telescope grep_string<cr>')
nmap('<leader>fcn', string.format('<cmd>Telescope find_files cwd=%s<cr>', utils.config_dir))

nmap('<leader>bb', '<cmd>Telescope buffers<cr>')
-- nmap('<leader>bp',)

nmap('<leader>=', '<cmd>Telescope projects<cr>')
nmap('<leader>/', '<cmd>Telescope live_grep<cr>')

nmap('<leader>]', '<cmd>SymbolsOutline<cr>')

nmap('<leader>wp', '<c-w>p')
nmap('<leader>wm', '<c-w>|<c-w>_')
nmap('<leader>w=', '<c-w>=')
nmap('<leader>wh', '<c-w>h')
nmap('<leader>wj', '<c-w>j')
nmap('<leader>wk', '<c-w>k')
nmap('<leader>wl', '<c-w>l')
nmap('<leader>wH', '<c-w>H')
nmap('<leader>wJ', '<c-w>J')
nmap('<leader>wK', '<c-w>K')
nmap('<leader>wL', '<c-w>L')
nmap('<leader>wf', '<c-w>gf')
nmap('<leader>wF', '<c-w>gF')

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
  local lines_present, lsp_lines = pcall(require, 'lsp_lines')
  if lines_present then
    lsp_lines.toggle()
  else
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  end
end)

nmap('<leader>xx', '<cmd>Trouble document_diagnostics<cr>')
nmap('<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')

nmap('<leader>tds', vim.diagnostic.show)
nmap('<leader>tdh', vim.diagnostic.hide)

nmap('<leader>R', utils.reload)

nmap('<leader>e', function()
  local file_dir = vim.fn.expand('%:p:h')
  vim.cmd('Telescope file_browser path=' .. file_dir)
end)

tmap('<c-j><c-k>', '<c-\\><c-n>')
tmap('<c-j>', '<c-\\><c-n><c-W>j')
tmap('<c-k>', '<c-\\><c-n><c-W>k')
tmap('<c-h>', '<c-\\><c-n><c-W>h')
-- tmap('<c-l>', '<c-\\><c-n><c-W>l')

-- vmap('s', '"zy:Telescope live_grep default_text=<C-r>z<cr>')


nmap('<leader>zz', '<cmd>TZAtaraxis<cr>')
nmap('<leader>zm', '<cmd>TZMinimalist<cr>')
