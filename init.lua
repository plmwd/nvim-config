local cmd = vim.cmd
local g = vim.g

-- Map leader
g.mapleader = ' '

-- Plugin globals
g.tokyonight_style = 'storm'
g.tokyonight_italic_comments = true
g.tokyonight_sidebars = { 'terminal' }
g.tokyonight_dark_float = true

require 'options'
require 'keymaps'
require 'plugins'
cmd 'silent! colo tokyonight'
