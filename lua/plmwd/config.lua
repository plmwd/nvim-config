local M = {}

local present, lua_dev = pcall(require, 'lua-dev')
local lua_conf = {}
if present then
  lua_conf = lua_dev.setup()
else
  lua_conf = {}
end

local home = vim.loop.os_homedir()

M.minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
M.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

M.lsp = {
  signs = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = ''
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
      on_attach = function(client, _)
        require('nvim-lsp-ts-utils').setup_client(client)
      end
    },
    clangd = function(on_attach, capabilities)
      require('clangd_extensions').setup {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      }
    end
    ,
    rust_analyzer = function(on_attach, capabilities)
      require('rust-tools').setup {
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
          standalone = false,
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = 'clippy',
              },
              files = {
                excludeDirs = {
                  home .. '/.rustup'
                },
              },
            },
          },
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
  display = {
    open_fn = require('packer.util').float,
  },
}

M.minimal_plugins = {}

return M
