local nmap = require 'plmwd.utils'

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*.md',
  callback = function(opts)
    -- nmap('[[', '')
    -- nmap(']]', '')
  end
})
