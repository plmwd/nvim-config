---@diagnostic disable-next-line
local heavy_breathing = vim.split([[


    ▄▀▀▄                ▄▀▀▄
     ▐▒▒▒▒▌              ▌▒▒▒▒▌
     ▌▒▒▒▒▐▄▄▄▄▄▀▀▀▀▄▄▄▄▐▒▒▒▒▒▐
    ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
   ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
   ▐▒▒▒▒▒▒▒▄▀▀▀▀▄▒▒▒▒▒▄▀▀▀▀▄▒▒▒▐
  ▐▒▒▒▒▒▒▒▐▌▐█▄▌▐▌▒▒▒▐▌▐█▄▌▐▌▒▒▒▐
  ▌▒▒▒▒▒▒▒▒▀▄▄▄▄▀▒▒▒▒▒▀▄▄▄▄▀▒▒▒▒▐
  ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▄▄▒▒▒▒▒▒▒▒▒▒▒▐
  ▌▒▒▒▒▒▒▒▒▒▒▀▒▀▒▒▒▀▒▒▒▀▒▀▒▒▒▒▒▒▐
  ▌▒▒▒▒▒▒▒▒▒▒▒▀▒▒▒▄▀▄▒▒▒▀▒▒▒▒▒▒▒▐
  ▒▐▒▒▒▒▒▒▒▀▄▒▒▒▄▀▒▒▒▀▄▒▒▒▄▀▒▒▒▒▐
  ▒▓▌▒▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▐
  ▒▒▓▀▀▄▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
 ▒▒▒▒▓▓▓▓▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▄▀▀▒▌
 ▒▒▒▒▒▒▓▓▓▓▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▒▒▒▒▒▐
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌
▒▒▒▒▒▒▒█▒█▒█▀▒█▀█▒█▒▒▒█▒█▒█▒▒▒▒▒▒▐
▒▒▒▒▒▒▒█▀█▒█▀▒█▄█▒▀█▒█▀▒▀▀█▒▒▒▒▒▒▐
▒▒▒▒▒▒▒▀▒▀▒▀▀▒▀▒▀▒▒▒▀▒▒▒▀▀▀▒▒▒▒▒▒▐
█▀▄▒█▀▄▒█▀▒█▀█▒▀█▀▒█▒█▒█▒█▄▒█▒▄▀▀▐
█▀▄▒█▀▄▒█▀▒█▄█▒▒█▒▒█▀█▒█▒█▀██▒█▒█▐
▀▀▒▒▀▒▀▒▀▀▒▀▒▀▒▒▀▒▒▀▒▀▒▀▒▀▒▒▀▒▒▀▀▐
]], '\n')

-- Chose dashboard header hear and add some other stuff to it
local dash_header = heavy_breathing

-- Return plugin UI
return {
    { 'nvim-lualine/lualine.nvim', name = 'lualine', lazy = false, config = function() require('lualine').setup() end },
    'Pocco81/true-zen.nvim',
    'rcarriga/nvim-notify',
    'j-hui/fidget.nvim',
    'kyazdani42/nvim-web-devicons',
    {
        'folke/noice.nvim',
        enabled = true,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            cmdline = {
                enabled = false,
            },
            popupmenu = {
                enabled = false,
            },
            messages = {
                enabled = false,
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        }
    },
    'https://gitlab.com/yorickpeterse/nvim-window',
    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
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
    },
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-web-devicons' },
        opts = {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = false,
                    concat = true,
                },
                shortcut = {
                    { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        desc = ' Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' Projects',
                        group = 'Keyword',
                        action = 'Telescope projects',
                        key = 'a',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'Telescope find_files cwd=~/.config',
                        key = 'd',
                    },
                    {
                        desc = ' git branches',
                        group = 'Character',
                        action = 'Telescope git_branches',
                        key = 'g',
                    },
                    {
                        desc = '󰗼 exit',
                        group = 'Error',
                        action = 'q!',
                        key = 'q',
                    },
                },
                header = dash_header,
                -- Inspirational quote
                footer = { '', require('plmwd.quotes').random() }
            }
        },
    },
}
