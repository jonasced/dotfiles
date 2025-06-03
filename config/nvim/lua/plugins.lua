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

  -- Smooth escaping
  -- Removed due to capslock -> escape changes. This used to do escape on jk or kj
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertCharPre",
  --   config = function()
  --     require("configs.better-escape").config()
  --   end,
  -- },

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
      "simrat39/rust-tools.nvim",
"Hoffs/omnisharp-extended-lsp.nvim",
      "Issafalcon/lsp-overloads.nvim",
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
  -- {
  --     "Exafunction/windsurf.nvim",
  --     dependencies = {
  --         "nvim-lua/plenary.nvim",
  --         "hrsh7th/nvim-cmp",
  --     },
  --     config = function()
  --         require("codeium").setup({
  --         })
  --     end
  -- },
  -- Replaced by windsurf!
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter'
  -- },
  -- jupyter integration
  {
    "SUSTech-data/neopyter",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter', -- neopyter don't depend on `nvim-treesitter`, but does depend on treesitter parser of python
      'AbaoFromCUG/websocket.nvim',  -- for mode='direct'
    },

    ---@type neopyter.Option
    opts = {
        mode="direct",
        remote_address = "127.0.0.1:9001",
        file_pattern = { "*.ju.*" },
        on_attach = function(bufnr)
            -- do some buffer keymap
        end,
    },
  },
  -- { -- Turns jupyter notebooks into md files! Super neat, but no lsp
  --     'goerz/jupytext.nvim',
  --     version = '0.2.0',
  --     opts = {
  --       -- default settings
  --       jupytext = '/home/jonas/dev/envs/neovim/bin/jupytext',
  --   },  -- see Options

  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    'GCBallesteros/jupytext.nvim',
    config = true,
    -- opts = {
    --   custom_language_formatting = {
    --     python = {
    --       extension = 'qmd',
    --       style = 'quarto',
    --       force_ft = 'quarto',
    --     },
    --     r = {
    --       extension = 'qmd',
    --       style = 'quarto',
    --       force_ft = 'quarto',
    --     },
    --   },
    -- },
  },
  { -- Quarto is supposed to help with LSP in jupyter notebooks converted to MD by jupytext
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",

  },
    config = function()
      require("quarto").setup{
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime", -- "molten", "slime", "iron" or <function>
          ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
          -- Takes precedence over `default_method`
          never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
        },
      }
    end
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
