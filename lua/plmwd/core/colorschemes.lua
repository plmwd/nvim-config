vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.dashboard_default_executive = "telescope"
vim.g.material_style = "deep ocean"
vim.g.rose_pine_variant = "moon"
vim.g.rose_pine_disable_italics = false

return {
    'yashguptaz/calvera-dark.nvim',
    'shaunsingh/moonlight.nvim',
    { 'folke/tokyonight.nvim', priority = 1000 },
    'EdenEast/nightfox.nvim',
    'marko-cerovac/material.nvim',
    'bluz71/vim-nightfly-guicolors',
    'shaunsingh/nord.nvim',
    'mangeshrex/uwu.vim',
    'rebelot/kanagawa.nvim',
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        tag = 'v0.0.7',
        priority = 1000,
        main = 'github-theme',
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        main = 'catppuccin',
        lazy = false,
        priority = 1000,
        opts = {
            dark_variant = 'moon'
        },
    },
    { 'rose-pine/neovim',      name = 'rose-pine' },
    'AlexvZyl/nordic.nvim'
}
