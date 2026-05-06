return {
  -- Color scheme
  {
    require("core.colorscheme").repo,
    config = function()
      require("core.colorscheme"):config()
    end,
  },

  -- Smart indentation
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
    config = function()
      require("configs.neo-tree").config()
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs.nvim-web-devicons").config()
    end,
  },

  -- Surround selections
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    config = function()
      require("configs.comment").config()
    end,
  },

  -- Better buffer closing
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.lualine").config()
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.bufferline").config()
    end,
  },

  -- Handy mappings
  {
    "tpope/vim-unimpaired",
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
  },

  -- Git diff view
  {
    "sindrets/diffview.nvim",
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.gitsigns").config()
    end,
    on_attach = function(bufnr)
      if vim.api.nvim_buf_get_name(bufnr):match('%.ipynb$') then
        return false
      end
    end,
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("configs.toggleterm").config()
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("configs.telescope").config()
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("configs.treesitter").config()
    end,
  },

  -- JSON schemas
  {
    "b0o/SchemaStore.nvim",
  },

  -- Kubernetes Helm templates support
  {
    "towolf/vim-helm",
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("configs.luasnip").config()
        end,
      },
    },
    event = "InsertEnter",
    config = function()
      require("configs.nvim-cmp").config()
    end,
  },

  -- Built-in LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP.
      -- This is the progress messages located at the bottom right
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim",       opts = {} },
      -- Allows extra capabilities provided by nvim-cmp
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("configs.lsp").setup()
    end,
  },

  -- Package manager for LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          {
            "rcarriga/nvim-dap-ui",
            dependencies = { "mfussenegger/nvim-dap" },
            config = function()
              require("configs.nvim-dap-ui").config()
            end,
          },
        },
      },
    },
    config = function()
      require("configs.mason").config()
    end,
  },

  -- Autoformat
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      log_level = vim.log.levels.WARN,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        rust = { "rustfmt" },
        c = { "clang_format" },
        yaml = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        ["*"] = { "trim_whitespace" },
      },
    },
  },

  -- Cargo.toml crate info
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require("crates")
      crates.setup({
        completion = {
          crates = { enabled = true },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },

  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --     lazygit = { enabled = true },
  --     notifier = { enabled = true },
  --   },
  --   keys = {
  --     {
  --       "<leader>n",
  --       function()
  --         Snacks.notifier.show_history()
  --       end,
  --       desc = "Notification History",
  --     },
  --     {
  --       "<leader>bd",
  --       function()
  --         Snacks.bufdelete()
  --       end,
  --       desc = "Delete Buffer",
  --     },
  --     {
  --       "<leader>gB",
  --       function()
  --         Snacks.gitbrowse()
  --       end,
  --       desc = "Git Browse",
  --     },
  --     {
  --       "<leader>gb",
  --       function()
  --         Snacks.git.blame_line()
  --       end,
  --       desc = "Git Blame Line",
  --     },
  --     {
  --       "<leader>gf",
  --       function()
  --         Snacks.lazygit.log_file()
  --       end,
  --       desc = "Lazygit Current File History",
  --     },
  --     {
  --       "<leader>gg",
  --       function()
  --         Snacks.lazygit()
  --       end,
  --       desc = "Lazygit",
  --     },
  --     {
  --       "<leader>gl",
  --       function()
  --         Snacks.lazygit.log()
  --       end,
  --       desc = "Lazygit Log (cwd)",
  --     },
  --     {
  --       "<leader>un",
  --       function()
  --         Snacks.notifier.hide()
  --       end,
  --       desc = "Dismiss All Notifications",
  --     },
  --     {
  --       "]]",
  --       function()
  --         Snacks.words.jump(vim.v.count1)
  --       end,
  --       desc = "Next Reference",
  --       mode = { "n", "t" },
  --     },
  --     {
  --       "[[",
  --       function()
  --         Snacks.words.jump(-vim.v.count1)
  --       end,
  --       desc = "Prev Reference",
  --       mode = { "n", "t" },
  --     },
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "VeryLazy",
  --       callback = function()
  --         -- Setup some globals for debugging (lazy-loaded)
  --         _G.dd = function(...)
  --           Snacks.debug.inspect(...)
  --         end
  --         _G.bt = function()
  --           Snacks.debug.backtrace()
  --         end
  --         vim.print = _G.dd -- Override print to use snacks for `:=` command
  --
  --         -- Create some toggle mappings
  --         Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
  --         Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
  --         Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
  --         Snacks.toggle.diagnostics():map("<leader>ud")
  --         Snacks.toggle.line_number():map("<leader>ul")
  --         Snacks.toggle
  --             .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  --             :map("<leader>uc")
  --         Snacks.toggle.treesitter():map("<leader>uT")
  --         Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
  --         Snacks.toggle.inlay_hints():map("<leader>uh")
  --       end,
  --     })
  --   end,
  -- },


  -- Code outline
  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
