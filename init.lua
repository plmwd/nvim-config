local cmd = vim.cmd
local g = vim.g

-- Map leader
g.mapleader = ' '
g.maplocalleader = ','

-- Plugin globals
g.tokyonight_style = 'night'
g.tokyonight_italic_comments = true
g.tokyonight_sidebars = { 'terminal' }
g.tokyonight_dark_float = true

require 'plmwd.globals'
require 'plmwd.options'
require 'plmwd.keymaps'
require 'plmwd.plugins'
require 'plmwd.ui'

cmd 'silent! colo tokyonight'
