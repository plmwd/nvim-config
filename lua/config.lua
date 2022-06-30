local M = {}

local present, lua_dev = pcall(require, 'lua-dev')
local lua_conf = {}
if present then
  lua_conf = lua_dev.setup()
else
  lua_conf = {}
end

M.minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
M.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

M.lsp = {
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
  signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = ""
  },
  diagnostic = {
    virtual_text = false,
  },
  servers = {
    cmake = {},
    cssls = {},
    dockerls = {},
    eslint = {},
    gopls = {},
    html = {},
    pyright = {},
    terraformls = {},
    texlab = {},
    vimls = {},
    yamlls = {},
    sumneko_lua = lua_conf,
    tsserver = {
      on_attach = function (client, _)
        require('nvim-lsp-ts-utils').setup_client(client)
      end
    },
    clangd = function (on_attach, capabilities)
      require('clangd_extensions').setup {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    end
    ,
    rust_analyzer = function (on_attach, capabilities)
      require('rust-tools').setup {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    end
  },
  null_ls = {
    formatters = {},
    diagnostics = {},
    actions = {},
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
    'markdown',
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

M.project_nvim = {
  patterns = {
    '.git',
    '_darcs',
    '.hg',
    '.bzr',
    '.svn',
    'Makefile',
    'package.json',
    'CMakeLists.txt',
    'Cargo.toml',
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

return M
