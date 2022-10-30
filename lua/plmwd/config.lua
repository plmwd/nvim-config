local config = {}

local home = vim.loop.os_homedir()

config.minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
config.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

config.lsp = {
  signs = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = ''
  },
  diagnostic = {
    virtual_text = true,
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
    sumneko_lua = {},
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

config.treesitter = {
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

config.project_roots = {
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

config.packer = {
  ensure_dependences = true,
  max_jobs = 64,
  profile = {
    enable = config.do_profile,
    threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = require('packer.util').float,
  },
}

config.minimal_plugins = {}

return config
