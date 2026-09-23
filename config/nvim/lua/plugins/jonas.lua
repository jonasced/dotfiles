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

  -- Obsidian plugin
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "hjarnan",
          path = "~/Dropbox/Apps/Obsidian/Dharma",
        },
      --   {
      --     name = "work",
      --     path = "~/vaults/work",
      --   },
      },
      -- Remove standard name/ID on creation that adds zettlekasten format
      note_id_func = function(title)
        return title
      end,
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({"xdg-open", url})  -- linux
      end,
      -- see below for full list of options 👇
    },
  },
}
