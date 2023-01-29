local config = {}

config.minimal_install = not (vim.fn.getenv('NVIM_MINIMAL_INSTALL') == '0')
config.do_profile = not (vim.fn.getenv('NVIM_PROFILE') == '0')

config.diagnostics = {
    signs = {
        Error = '',
        Warn = '',
        Hint = '',
        Info = ''
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

config.minimal_plugins = {}

return config
