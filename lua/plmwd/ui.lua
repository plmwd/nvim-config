-- au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local utils = require 'plmwd.utils'

local ui_group = augroup('user_ui', {})

autocmd('TextYankPost', {
  group = ui_group,
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end
})

utils.safe_setup('todo-comments')
-- utils.safe_setup('notify', function(notify)
--   vim.notify = notify
-- end)
utils.safe_setup('incline')
utils.safe_setup('fidget')
utils.safe_setup('nvim-autopairs')
utils.safe_setup('nvim-surround')
utils.safe_setup('rose-pine', {
  dark_variant = 'moon',
})
utils.safe_setup('catppuccin')
utils.safe_setup('true-zen', {
  integrations = {
    lualine = true,
  }
})

require 'plmwd.ui.statusline'
