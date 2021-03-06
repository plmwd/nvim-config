local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup {
  sources = {
    formatting.autopep8,
  },
}
