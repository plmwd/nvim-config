vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.dashboard_default_executive = "telescope"
vim.g.material_style = "darker"
vim.g.rose_pine_variant = "moon"
vim.g.rose_pine_disable_italics = false

return {
    'yashguptaz/calvera-dark.nvim',
    'shaunsingh/moonlight.nvim',
    'folke/tokyonight.nvim',
    'EdenEast/nightfox.nvim',
    'marko-cerovac/material.nvim',
    'bluz71/vim-nightfly-guicolors',
    'shaunsingh/nord.nvim',
    'mangeshrex/uwu.vim',
    'rebelot/kanagawa.nvim',
    'projekt0n/github-nvim-theme',
    {
        'catppuccin/nvim', name = 'catppuccin',
        lazy = false,
        priority = 1000,
        opts = {
            dark_variant = 'moon'
        },
        config = function()
            vim.cmd.colorscheme('catppuccin-frappe')
        end
    },
    { 'rose-pine/neovim', name = 'rose-pine' },
    'AlexvZyl/nordic.nvim'
}
