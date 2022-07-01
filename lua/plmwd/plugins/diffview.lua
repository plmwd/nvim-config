local present, diffview = pcall(require, 'diffview')
if not present then
  return
end

diffview.setup {
  enhanced_diff_hl = true,
  keymaps = {
    view = {
      ['q'] = '<cmd>tabclose<cr>',
    },
    file_panel = {
      ['q'] = '<cmd>tabclose<cr>',
    },
  },
}
