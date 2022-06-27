local autocmd = vim.api.nvim_create_autocmd

local M = {}

local function map(modes, lhs, rhs, opts)
  local opts = vim.tbl_extend('force', { silent = true }, opts or {})
  vim.keymap.set(modes, lhs, rhs, opts)
end

M.nmap = function(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

M.imap = function(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end

M.tmap = function(lhs, rhs, opts)
  map('t', lhs, rhs, opts)
end

M.os_name = vim.loop.os_uname().sysname

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

M.packer_lazy_load = function(plugin)
  vim.defer_fn(function()
    require('packer').loader(plugin)
  end, 0)
end

-- Taken from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
M.lazy_load = function(tb)
   autocmd(tb.events, {
      pattern = "*",
      group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
      callback = function()
         if tb.condition() then
            vim.api.nvim_del_augroup_by_name(tb.augroup_name)

            -- dont defer for treesitter as it will show slow highlighting
            -- This deferring only happens only when we do "nvim filename"
            if tb.plugins ~= "nvim-treesitter" then
               vim.defer_fn(function()
                vim.cmd("PackerLoad " .. tb.plugins)
               end, 0)
            else
               vim.cmd("PackerLoad " .. tb.plugins)
            end
         end
      end,
   })
end

-- Taken from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
-- load certain plugins only when there's a file opened in the buffer
-- if "nvim filename" is executed -> load the plugin after nvim gui loads
-- This gives an instant preview of nvim with the file opened
M.on_file_open = function(plugin_name)
   M.lazy_load {
      events = { "BufRead", "BufWinEnter", "BufNewFile" },
      augroup_name = "BeLazyOnFileOpen" .. plugin_name,
      plugins = plugin_name,
      condition = function()
         local file = vim.fn.expand "%"
         return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
      end,
   }
end

return M
