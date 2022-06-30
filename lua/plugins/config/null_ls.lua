local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local formatting = null_ls.builtin.formatting
local diagnostics = null_ls.builtin.diagnostics
local completion = null_ls.builtin.completion

null_ls.setup {
  sources = {
    formatting.autopep8,
  },
}
