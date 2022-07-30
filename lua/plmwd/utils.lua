local autocmd = vim.api.nvim_create_autocmd

local M = {}

local function map(modes, lhs, rhs, opts)
  local opts = vim.tbl_extend('force', { silent = true }, opts or {})
  vim.keymap.set(modes, lhs, rhs, opts)
end

function M.nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

function M.imap(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end

function M.tmap(lhs, rhs, opts)
  map('t', lhs, rhs, opts)
end

M.os_name = vim.loop.os_uname().sysname

function M.project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require 'telescope.builtin'.git_files, opts)
  if not ok then require 'telescope.builtin'.find_files(opts) end
end

function M.packer_lazy_load(plugin)
  vim.defer_fn(function()
    require('packer').loader(plugin)
  end, 0)
end

-- Taken from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
function M.lazy_load(tb)
  autocmd(tb.events, {
    pattern = '*',
    group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do 'nvim filename'
        if tb.plugins ~= 'nvim-treesitter' then
          vim.defer_fn(function()
            vim.cmd('PackerLoad ' .. tb.plugins)
          end, 0)
        else
          vim.cmd('PackerLoad ' .. tb.plugins)
        end
      end
    end,
  })
end

-- Taken from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
-- load certain plugins only when there's a file opened in the buffer
-- if 'nvim filename' is executed -> load the plugin after nvim gui loads
-- This gives an instant preview of nvim with the file opened
function M.on_file_open(plugin_name)
  M.lazy_load {
    events = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
    augroup_name = 'BeLazyOnFileOpen' .. plugin_name,
    plugins = plugin_name,
    condition = function()
      local file = vim.fn.expand '%'
      return file ~= 'NvimTree_1' and file ~= '[packer]' and file ~= ''
    end,
  }
end

function M.safe_setup(plugin_name, opts_or_fun)
  local plugin_present, plugin = pcall(require, plugin_name)
  if plugin_present then
    if vim.is_callable(opts_or_fun) then
      opts_or_fun(plugin)
    elseif opts_or_fun then
      plugin.setup(opts_or_fun)
    else
      plugin.setup()
    end
  end
end

function M.get_nearest_codelens(bufnr, win)
  local line, _ = unpack(vim.api.nvim_win_get_cursor(win))
  local codelenses = vim.lsp.codelens.get(bufnr)
  if #codelenses == 0 then
    return nil
  end

  local closest = codelenses[1]
  for _, lens in pairs(codelenses) do
    if vim.fn.abs(closest.range.start.line > line - lens.range.start.line) then
      closest = lens
    end
  end

  return closest
end

function M.reload()
  local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(dir, "./lua/", "")
    require("plenary.reload").reload_module(dir)
  end
  print('Reloaded config!')
end

return M
