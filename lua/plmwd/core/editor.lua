local config = require('plmwd.config')

-- TODO:
--
-- use {
--     'saecki/crates.nvim',
--     event = { "BufRead Cargo.toml" },
--     requires = { { 'nvim-lua/plenary.nvim' } },
--     config = function()
--         require 'plmwd.plugins.crates'
--     end,
-- }
--
-- use {
--     'numToStr/Comment.nvim',
--     module = 'Comment',
--     keys = { 'gc', 'gb ' },
--     config = function()
--         require('Comment').setup()
--     end,
-- }

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)

        -- delete trailing whitespace
        vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])

        -- delete lines @ eof
        vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])

        local num_rows = vim.api.nvim_buf_line_count(0)

        if cursor_pos[1] > num_rows then
            cursor_pos[1] = num_rows
        end

        vim.api.nvim_win_set_cursor(0, cursor_pos)
    end,
})

return {
    'norcalli/nvim-colorizer.lua',
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    'rest-nvim/rest.nvim',
    'numToStr/Comment.nvim',
    {
        'lukas-reineke/lsp-format.nvim',
        opts = {},
        config = function(_, opts)
            require('lsp-format').setup(opts)
            require('plmwd.utils').on_attach(function(client, _)
                require('lsp-format').on_attach(client)
            end)
        end
    },
    'ThePrimeagen/harpoon',
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter',
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter-context' }
    },
    {
        'ahmedkhalf/project.nvim',
        name = 'project_nvim',
        opts = {
            patterns = config.project_roots,
        }
    },
    {
        'nvim-neorg/neorg',
        dependencies = {
            'nvim-treesitter',
        },
        opts = {
            load = { ['core.defaults'] = {} }
        }
    },
    {
        'TimUntersberger/neogit',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'sindrets/diffview.nvim',
                opts = {
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
            },
        },
        opts = {}
    },
    {
        'folke/todo-comments.nvim',
        event = 'UIEnter',
        config = function(_, opts) require('todo-comments').setup(opts) end,
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    'folke/which-key.nvim',
    {
        'akinsho/toggleterm.nvim',
        opts = {
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-\>]],
            on_create = function(term)
                if vim.o.lines * 2 > vim.o.columns then
                    term.direction = "horizontal"
                end
            end,
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = 'curved',
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                }
            }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = {
            'nvim-telescope/telescope-media-files.nvim',
            'nvim-telescope/telescope-symbols.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = {
                    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
                }
            },
        },
        opts = {
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
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            telescope.load_extension 'fzf'
            telescope.load_extension 'projects'
            telescope.load_extension 'media_files'
            telescope.load_extension 'file_browser'
        end
    }
}
