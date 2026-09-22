return {
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.toggleterm").config()
    end,
  },
  -- Git diff view
  {
    "sindrets/diffview.nvim",        -- optional - Diff integration
  },
}
