local g = vim.g

g.tokyonight_style = "night"
g.tokyonight_italic_functions = true
g.dashboard_default_executive = "telescope"

g.material_style = "darker"
g.rose_pine_variant = "moon"
g.rose_pine_disable_italics = false
g.vimtex_view_method = "zathura"

-- require'nightfox'.setup{
--   fox = 'nightfox',
--   alt_nc = true,
--   styles = {
--     comments = 'italic',
--     keywords = 'italic',
--   },
--   inverse = {
--     match_paren = true,
--   }
-- }

vim.cmd[[ colorscheme tokyonight ]]
