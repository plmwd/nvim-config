 -- au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

M.setup = function ()
  local ui_group = augroup('user_ui', {})

  autocmd('TextYankPost', {
    group = ui_group,
    callback = function ()
      vim.highlight.on_yank { on_visual = false }
    end
  })

  local _, todo_comments = pcall(require, 'todo-comments')
  if todo_comments then
    todo_comments.setup {}
  end

  local _, notify = pcall(require, 'notify')
  if notify then
    vim.notify = notify
  end

  local _, incline = pcall(require, 'incline')
  if incline then
    incline.setup {}
  end

  require 'ui.statusline'
end

return M
