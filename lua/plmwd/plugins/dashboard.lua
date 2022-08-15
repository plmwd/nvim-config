local db = require 'dashboard'
local home = os.getenv('HOME')

db.custom_center = {
  -- {
  --   icon = '  ',
  --   desc = 'Last Session             ',
  --   action = '',
  -- },
  {
    icon = '  ',
    desc = 'Recently Opened Files    ',
    action = 'Telescope oldfiles',
  },
  {
    icon = '  ',
    desc = 'Find Files               ',
    action = 'Telescope find_files',
  },
  {
    icon = '  ',
    desc = 'Recent Projects          ',
    action = 'Telescope projects',
  },
  {
    icon = '  ',
    desc = 'Neovim Config            ',
    action = 'Telescope find_files cwd=' .. home .. '/.config/nvim',
  },
}

db.default_banner = vim.split([[
      ▄▀▀▄                ▄▀▀▄    
     ▐▒▒▒▒▌              ▌▒▒▒▒▌   
     ▌▒▒▒▒▐▄▄▄▄▄▀▀▀▀▄▄▄▄▐▒▒▒▒▒▐   
    ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌  
   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌  
   ▐▒▒▒▒▒▒▒▄▀▀▀▀▄▒▒▒▒▒▄▀▀▀▀▄▒▒▒▐  
  ▐▒▒▒▒▒▒▒▐▌▐█▄▌▐▌▒▒▒▐▌▐█▄▌▐▌▒▒▒▐ 
  ▌▒▒▒▒▒▒▒▒▀▄▄▄▄▀▒▒▒▒▒▀▄▄▄▄▀▒▒▒▒▐ 
  ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▄▄▒▒▒▒▒▒▒▒▒▒▒▐ 
  ▌▒▒▒▒▒▒▒▒▒▒▀▒▀▒▒▒▀▒▒▒▀▒▀▒▒▒▒▒▒▐ 
  ▌▒▒▒▒▒▒▒▒▒▒▒▀▒▒▒▄▀▄▒▒▒▀▒▒▒▒▒▒▒▐ 
  ▒▐▒▒▒▒▒▒▒▀▄▒▒▒▄▀▒▒▒▀▄▒▒▒▄▀▒▒▒▒▐ 
  ▒▓▌▒▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▐  
  ▒▒▓▀▀▄▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   
 ▒▒▒▒▓▓▓▓▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▄▀▀▒▌  
 ▒▒▒▒▒▒▓▓▓▓▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▒▒▒▒▒▐  
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌ 
▒▒▒▒▒▒▒█▒█▒█▀▒█▀█▒█▒▒▒█▒█▒█▒▒▒▒▒▒▐
▒▒▒▒▒▒▒█▀█▒█▀▒█▄█▒▀█▒█▀▒▀▀█▒▒▒▒▒▒▐
▒▒▒▒▒▒▒▀▒▀▒▀▀▒▀▒▀▒▒▒▀▒▒▒▀▀▀▒▒▒▒▒▒▐
█▀▄▒█▀▄▒█▀▒█▀█▒▀█▀▒█▒█▒█▒█▄▒█▒▄▀▀▐
█▀▄▒█▀▄▒█▀▒█▄█▒▒█▒▒█▀█▒█▒█▀██▒█▒█▐
▀▀▒▒▀▒▀▒▀▀▒▀▒▀▒▒▀▒▒▀▒▀▒▀▒▀▒▒▀▒▒▀▀▐
]], '\n')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dashboard',
  callback = function(opts)
    local opts = { buffer = opts.buf, silent = true }
    vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)
    vim.keymap.set('n', '<leader>`', '<cmd>NvimTreeToggle<cr>', opts)
  end
})
