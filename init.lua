-- Parts shamelessly borrowed from https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/init.lua
local cmd = vim.cmd
local g, b, w, t = vim.g, vim.b, vim.w, vim.t
local o, go, bo = vim.o, vim.go, vim.bo

g.mapleader = ' '
g.maplocalleader = ','

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'gzip',
  'man',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
  'netrwPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  g['loaded_' .. plugin] = 1
end

cmd [[command! PackerInstall packadd packer.nvim  | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim   | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim     | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim    | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim  | lua require('plugins').compile()]]
cmd [[command! PackerStatus packadd packer.nvim   | lua require('plugins').status()]]
cmd [[command! Bootstrap packadd packer.nvim      | lua require('bootstrap').bootstrap()]]
