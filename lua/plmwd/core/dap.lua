return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                config = function(_, opts)
                    require('dapui').setup(opts)
                    vim.api.nvim_create_user_command('DapUi', require('dapui').toggle, { desc = 'Toggle DAP UI' })
                end
            },
        },
        opts = {},
        config = function(_, opts)
        end
    },
}
