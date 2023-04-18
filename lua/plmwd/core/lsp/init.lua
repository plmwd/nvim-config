-- local function on_attach(client, bufnr)
--     require('plmwd.lsp.keymaps').on_attach(client, bufnr)
--     lsp_ui.setup_buffer(client, bufnr)
--
--     safe_setup('nvim-navic', function(navic)
--         navic.attach(client, bufnr)
--     end)
--
--     safe_setup('lsp-format', function(lsp_format)
--         lsp_format.on_attach(client)
--     end)
-- end

return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf",                                config = true },
            { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
            "mason.nvim",
            'lukas-reineke/lsp-format.nvim',
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            'simrat39/rust-tools.nvim',
            'p00f/clangd_extensions.nvim',
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            -- Automatically format on save
            autoformat = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overriden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            servers = {
                cmake = {},
                cssls = {},
                dockerls = {},
                eslint = {},
                gopls = {},
                html = {},
                pyright = {},
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = {
                                    maxLineLength = 99,
                                },
                            },
                        },
                    },
                },
                terraformls = {},
                texlab = {},
                vimls = {},
                yamlls = {},
                jsonls = {},
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                command = 'clippy',
                            },
                            files = {
                                -- TODO: get home
                                -- excludeDirs = {
                                --     home .. '/.rustup'
                                -- },
                            },
                        },
                    },
                },
                sumneko_lua = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
                clangd = function(_, opts)
                    require('clangd_extensions').setup {
                        server = {
                            capabilities = opts.capabilities,
                        },
                    }
                    return true
                end
                ,
                rust_analyzer = function(_, opts)
                    require('rust-tools').setup {
                        server = {
                            capabilities = opts.capabilities,
                            standalone = false,
                            settings = opts.settings,
                        },
                    }
                    return true
                end
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            -- setup autoformat
            -- setup formatting and keymaps
            require('plmwd.utils').on_attach(function(client, bufnr)
                require('plmwd.core.lsp.keymaps').on_attach(client, bufnr)
                require('plmwd.core.lsp.ui').on_attach(client, bufnr)
                require('plmwd.core.lsp.format').on_attach(client, bufnr)
                -- client.server_capabilities.semanticTokensProvider = nil
            end)

            -- diagnostics
            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- servers configured in opts to allow config to be overriden
            local function setup(server)
                local server_opts = servers[server] or {}
                server_opts.capabilities = capabilities
                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({ setup })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        opts = {},
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(plugin, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}
