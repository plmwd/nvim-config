return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/playground',
            'RRethy/nvim-treesitter-textsubjects',
            'nvim-treesitter/nvim-treesitter-textobjects'
        },
        build = ':TSUpdate',
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "help",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['as'] = '@structure.outer',
                        ['is'] = '@structure.inner',
                    }
                },
                textsubjects = {
                    enable = true,
                    prev_selection = ',',
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        [';'] = 'textsubjects-container-outer',
                        ['i;'] = 'textsubjects-container-inner',
                    }
                },
                lsp_interop = {
                    enable = true,
                    -- TODO: config this
                }
            }
        },
        config = function(plugin, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    }
}
