local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Ignore compiled files
opt.wildignore = {
    '__pycache__',
    '*.o',
    '*~',
    '*.pyc',
    '*pycache*',
    '**/node_modules/*',
}
opt.autoread = true
opt.autowrite = true
opt.conceallevel = 3
opt.wildmode = 'longest:full,full'
opt.wildoptions = 'pum'
opt.grepprg = 'rg --vimgrep'
opt.wildignorecase = true
opt.inccommand = 'split'
opt.splitbelow = true
opt.splitright = true
opt.path = { '.', ',', '**' }
opt.termguicolors = true
opt.showmode = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true
opt.showtabline = 2
opt.completeopt = 'menu,menuone,noselect'
opt.cursorline = true
opt.mouse = 'a'
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.tw = 100
opt.cc = '+1'
opt.ignorecase = true
opt.smartcase = true
opt.swapfile = false
opt.title = true
opt.updatetime = 500
opt.breakindent = true
opt.lbr = true
opt.wrap = false
opt.belloff = 'all' -- Just turn the dang bell off
opt.signcolumn = 'yes:2'
opt.autoread = true
opt.laststatus = 3
opt.nu = true
opt.rnu = true
opt.spelloptions = 'noplainbuffer'
opt.spell = false
opt.formatoptions = 'croqnj'
opt.pumblend = 20
opt.undofile = true
opt.undolevels = 10000
opt.winminwidth = 4
opt.listchars = {
    trail = '·',
    nbsp = '&',
    conceal = '$'
}
opt.sessionoptions = 'buffers,curdir,folds,globals,localoptions,options,tabpages,winpos,winsize'
opt.shortmess:append { W = true, m = true }
