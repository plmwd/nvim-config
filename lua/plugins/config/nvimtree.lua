local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

local function tree_width()
  return vim.fn.winwidth(0) / vim.fn.winheight(0) >= 3 and 40 or 30
end

nvimtree.setup {
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    width = tree_width(),
  },
}

local group = vim.api.nvim_create_augroup('nvim_tree_resize', {})
vim.api.nvim_create_autocmd('VimResized', {
  group = group,
  callback = function()
    vim.cmd ('NvimTreeResize ' .. tree_width())
  end,
})
