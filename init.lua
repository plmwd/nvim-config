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

g.catppuccin_flavour = 'mocha'

require 'plmwd.globals'
require 'plmwd.options'
require 'plmwd.keymaps'
require 'plmwd.plugins'
require 'plmwd.ui'
require 'plmwd.ft'

cmd 'silent! colo catppuccin'
