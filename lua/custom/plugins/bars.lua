return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "custom.incline"
    end,
  },

  -- === Winbar ===
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "custom.winbar"
    end,
  },

  -- === Status Line ===
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "custom.statusline"
    end,
  },
}
