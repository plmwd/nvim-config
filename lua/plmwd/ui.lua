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

-- utils.safe_setup('todo-comments')
-- -- utils.safe_setup('notify', function(notify)
-- --   vim.notify = notify
-- -- end)
-- safe_setup('incline')
-- safe_setup('fidget')
-- safe_setup('nvim-autopairs')
-- safe_setup('nvim-surround')
-- safe_setup('rose-pine', {
--   dark_variant = 'moon',
-- })
-- -- utils.safe_setup('catppuccin')
-- safe_setup('true-zen', {
--   integrations = {
--     lualine = true,
--   }
-- })
--
-- require 'plmwd.ui.statusline'
