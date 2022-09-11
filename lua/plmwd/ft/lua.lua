local utils = require 'plmwd.utils'
local wk_present, wk = pcall(require, 'which-key')
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup('plmwd_lua_ft', {})
autocmd('BufEnter', {
  group = group,
  pattern = string.format('%s/*/plugins.lua', utils.config_dir),
  callback = function(opts)
    utils.nmap('<localleader>g', function()

    end)
  end
})
