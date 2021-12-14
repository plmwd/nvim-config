-- Shamelessly _borrowed_ from https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/config/utils.lua
local M = {}

local cmd = vim.cmd
local map_key = vim.api.nvim_set_keymap

M.do_minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
M.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

M.autocmd = function(group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == 'string' then cmds = {cmds} end
  cmd('augroup ' .. group)
  if clear then cmd [[au!]] end
  for _, c in ipairs(cmds) do cmd('autocmd ' .. c) end
  cmd [[augroup END]]
end

M.map = function(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
