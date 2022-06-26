 -- au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local ui_group = augroup('user_ui', {})

autocmd('TextYankPost', {
  group = ui_group,
  callback = function ()
    vim.highlight.on_yank { on_visual = false }
  end
})


