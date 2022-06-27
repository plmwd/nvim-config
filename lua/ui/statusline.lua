-- local present, feline = pcall(require, 'feline')
-- if not present then
--   return
-- end

-- feline.setup {
--
-- }

local present, lualine = pcall(require, 'lualine')
if not present then
  return
end

local navic = require 'nvim-navic'

lualine.setup {
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { { 'filename', path = 1}, 'branch' },
    lualine_c = { 'fileformat', { navic.get_location, cond = navic.is_available } },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'filetype', 'filesize', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
