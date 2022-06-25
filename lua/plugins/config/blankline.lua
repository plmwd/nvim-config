local present, blankline = pcall(require, "indent_blankline")
 if not present then
    return
 end

 local options = {
  char = "▏",
  filetype_exclude = {
     "help",
     "terminal",
     "dashboard",
     "packer",
     "lspinfo",
     "TelescopePrompt",
     "TelescopeResults",
     "nvchad_cheatsheet",
     "lsp-installer",
     "",
  },
  buftype_exclude = { "terminal" },
  show_current_context = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
 }

 blankline.setup(options)
