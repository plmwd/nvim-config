local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    winblend = 8,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {'png', 'jpg', 'mp4', 'webm', 'pdf'}
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg' -- find command (defaults to `fd`)
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      mappings = {
        i = {
          ['<c-u>'] = require('plmwd.ui.actions').goto_parent_dir,
        },
      },
    },
    lsp_references = { theme = 'dropdown' },
    lsp_code_actions = { theme = 'dropdown' },
    lsp_definitions = { theme = 'dropdown' },
    lsp_implementations = { theme = 'dropdown' },
    buffers = {
      sort_lastused = true,
      previewer = false,
    },
  },
}

-- Extensions
telescope.load_extension 'fzf'
telescope.load_extension 'projects'
telescope.load_extension 'media_files'
telescope.load_extension 'file_browser'
