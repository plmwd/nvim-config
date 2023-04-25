require 'plmwd.globals'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
math.randomseed(vim.fn.localtime())

vim.loader.enable()

require 'plmwd.options'
require 'plmwd.keymaps'
require 'plmwd.autocmds'

-- colorscheme in plmwd.core.colorscheme
require('lazy').setup('plmwd.core')

vim.cmd.colo('nightfly')
