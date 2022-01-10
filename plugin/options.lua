-- Thanks teej https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/options.lua
local opt = vim.opt
local g, b, w, t = vim.g, vim.b, vim.w, vim.t
local o, go, bo = vim.o, vim.go, vim.bo

-- Ignore compiled files
opt.wildignore = '__pycache__'
opt.wildignore = opt.wildignore + { '*.o', '*~', '*.pyc', '*pycache*' }

opt.pumblend = 17
opt.wildmode = 'longest:full'
opt.wildoptions = 'pum'

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.completeopt = 'menu,menuone,noselect'
opt.cursorline = true
opt.mouse = 'a'
opt.termguicolors = true
opt.scrolloff = 10
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
opt.signcolumn = 'yes:1'
opt.autoread = true

opt.formatoptions = opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore
