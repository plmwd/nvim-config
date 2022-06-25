local M = {}

M.minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
M.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

M.lsp = {
  ensure_installed = {
    'rust_analyzer',
    'sumneko_lua',
    'bashls',
    'clangd',
    'cmake',
    'cssls',
    -- 'denols',
    -- 'texlab',
    'pyright',
    'vimls',
    'ltex',
  },

  cmds = {
   "LspInfo",
   "LspStart",
   "LspRestart",
   "LspStop",
   "LspInstall",
   "LspUnInstall",
   "LspUnInstallAll",
   "LspInstall",
   "LspInstallInfo",
   "LspInstallLog",
   "LspLog",
   "LspPrintInstalled",
  },
}

M.treesitter = {
  ensure_installed = {
    'tsx',
    'typescript',
    'javascript',
    'java',
    'http',
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'dockerfile',
    'fish',
    'go',
    'json',
    'lua',
    'python',
    'rust',
    'toml',
    'vim',
    'yaml',
  },
  cmds = {
   "TSInstall",
   "TSBufEnable",
   "TSBufDisable",
   "TSEnable",
   "TSDisable",
   "TSModuleInhfo",
  }
}

M.packer = {
  ensure_dependences = true,
  max_jobs = 64,
  profile = {
    enable = M.do_profile,
    threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

M.minimal_plugins = {}

-- Taken from https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
-- lspinstaller & lspconfig cmds for lazyloading


return M
