return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = {
          name = "flm",
          end_point = "http://localhost:52625/v1/chat/completions",
          api_key = "TERM", -- any env var that exists; flm needs no key
          model = "qwen3.5:4b",
          optional = { max_tokens = 32, top_p = 0.9 },
        },
      },
      n_completions = 1,
      context_window = 2048, -- keep small: NPU prefill is the bottleneck
      request_timeout = 15,
      blink = { enable_auto_complete = false }, -- trigger manually
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            timeout_ms = 15000,
            score_offset = 50,
          },
        },
      },
      keymap = {
        ["<A-y>"] = {
          function(cmp)
            cmp.show({ providers = { "minuet" } })
          end,
        },
      },
    },
  },
}
