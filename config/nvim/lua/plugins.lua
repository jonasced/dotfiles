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
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
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
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
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
    "sindrets/diffview.nvim",        -- optional - Diff integration
  },
--   -- More git! New commands etc, might be nice. Checkout at home.
-- https://www.reddit.com/r/neovim/comments/14yjftv/massive_update_to_neogit_and_new_home/ <- for thoughts
-- {
--   "NeogitOrg/neogit",
--   dependencies = {
--     "nvim-lua/plenary.nvim",         -- required
--     "sindrets/diffview.nvim",        -- optional - Diff integration
--
--     -- Only one of these is needed, not both.
--     "nvim-telescope/telescope.nvim", -- optional
--   },
--   config = true
-- },

  -- Tmux integration (navigation + resize)
  {
    "aserowy/tmux.nvim",
    config = function()
      require("configs.tmux").config()
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.gitsigns").config()
    end,
    on_attach = function(bufnr)
    if vim.api.nvim_buf_get_name(bufnr):match('%.ipynb$') then
      -- Do not attach for .ipynb file, since these are converted
      -- with jupytext.nvim
      return false
    end
  end,
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
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("configs.telescope").config()
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("configs.treesitter").config()
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.alpha").config()
    end,
  },

  -- JSON schemas
  {
    "b0o/SchemaStore.nvim",
  },

  -- YAML companion
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
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
      "rcarriga/cmp-dap",
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
      "simrat39/rust-tools.nvim",
      "Hoffs/omnisharp-extended-lsp.nvim",
      "Issafalcon/lsp-overloads.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

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
      -- Mason tools management
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- LSP servers
      "nvim-lua/plenary.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Formatting and linting
      "mfussenegger/nvim-lint",
      "mhartington/formatter.nvim",
      -- Debugger
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
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
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
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },
  {
      "benlubas/molten-nvim",
      version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
      build = ":UpdateRemotePlugins",
      init = function()
          -- this is an example, not a default. Please see the readme for more configuration options
          vim.g.molten_output_win_max_height = 12
      end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
        },
      })
      end
    },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show({ global = false })
  --       end,
  --       desc = "Buffer Local Keymaps (which-key)",
  --     },
  --   },
  -- },
  {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
          require'window-picker'.setup()
      end,
  },
  -- {
  --   'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
  --   -- Activate when a file is created/opened
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   -- Activate when a supported filetype is open
  --   ft = { 'go', 'javascript', 'python', 'ruby' },
  --   cond = function()
  --     -- Only activate if token is present in environment variable.
  --     -- Remove this line to use the interactive workflow.
  --     return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
  --   end,
  --   opts = {
  --     statusline = {
  --       -- Hook into the built-in statusline to indicate the status
  --       -- of the GitLab Duo Code Suggestions integration
  --       enabled = true,
  --     },
  --   },
  -- }
  -- Didn't get to work, perhaps look at another time
  -- {
  -- "harrisoncramer/gitlab.nvim",
  -- dependencies = {
  --   "MunifTanjim/nui.nvim",
  --   "nvim-lua/plenary.nvim",
  --   "sindrets/diffview.nvim",
  --   "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
  --   "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  -- },
  -- build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
  -- config = function()
  --   require("gitlab").setup()
  -- end,
  -- }
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require("crates")
      crates.setup({
        completion = {
          crates = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
      -- TODO: move into keymaps
      -- vim.keymap.set("n", "<leader>Ct", crates.toggle, { silent = true, desc = "Crates toggle" })
      -- vim.keymap.set("n", "<leader>Cr", crates.reload, { silent = true, desc = "Crates reload" })
      --
      -- vim.keymap.set("n", "<leader>Cv", crates.show_versions_popup, { silent = true, desc = "Versions" })
      -- vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, { silent = true, desc = "Features" })
      -- vim.keymap.set("n", "<leader>Cd", crates.show_dependencies_popup, { silent = true, desc = "Dependencies" })
      --
      -- vim.keymap.set("n", "<leader>Cu", crates.update_crate, { silent = true, desc = "Update crate" })
      -- vim.keymap.set("n", "<leader>CU", crates.upgrade_crate, { silent = true, desc = "Upgrade crate" })
      --
      -- vim.keymap.set(
      --   "n",
      --   "<leader>Cx",
      --   crates.expand_plain_crate_to_inline_table,
      --   { silent = true, desc = "Expande plain crate to inline table" }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>CX",
      --   crates.extract_crate_into_table,
      --   { silent = true, desc = "Extract crate into table" }
      -- )
      --
      -- vim.keymap.set("n", "<leader>CH", crates.open_homepage, { silent = true, desc = "Open homepage" })
      -- vim.keymap.set("n", "<leader>CR", crates.open_repository, { silent = true, desc = "Open repository" })
      -- vim.keymap.set("n", "<leader>CD", crates.open_documentation, { silent = true, desc = "Open documentation" })
      -- vim.keymap.set("n", "<leader>CC", crates.open_crates_io, { silent = true, desc = "Open crates.io" })
      -- vim.keymap.set("n", "<leader>CL", crates.open_lib_rs, { silent = true, desc = "Open lib.rs" })
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
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = { "ruff" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
      },
    },
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




}
