local opt = vim.opt

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = true

-- One global status line
opt.laststatus = 3

opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.breakindent = false
opt.smartindent = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"

opt.clipboard = "unnamedplus"

-- ignored when expanding wildcards
opt.wildignore = {
  "__pycache__",
  "*.o",
  "*~",
  "*.pyc",
  "*pycache*",
  "**/node_modules/*",
}
opt.wildignorecase = true

-- auto read file if changed
opt.autoread = true

opt.cursorline = true
opt.undofile = true
opt.scrolloff = 3
opt.smoothscroll = true
opt.pumblend = 10
opt.mouse = "ar"
opt.showmode = false
opt.confirm = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
