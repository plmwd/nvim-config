-- au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local ui_group = augroup('user_ui', {})

autocmd('TextYankPost', {
  group = ui_group,
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end
})

local todo_present, todo_comments = pcall(require, 'todo-comments')
if todo_present then
  todo_comments.setup {}
end

local notify_present, notify = pcall(require, 'notify')
if notify_present then
  vim.notify = notify
end

local incline_present, incline = pcall(require, 'incline')
if incline_present then
  incline.setup {}
end

require 'plmwd.ui.statusline'
