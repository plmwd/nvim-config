local cmd = vim.cmd
local g = vim.g

-- Map leader
g.mapleader = ' '

-- Plugin globals
g.tokyonight_style = 'night'
g.tokyonight_italic_comments = true
g.tokyonight_sidebars = { 'terminal' }
g.tokyonight_dark_float = true

require 'options'
require 'keymaps'
require 'plugins'
require 'ui'

cmd 'silent! colo tokyonight'
