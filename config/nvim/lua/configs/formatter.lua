local M = {}

function M.config()
  local formatter_ok, formatter = pcall(require, "formatter")
  if formatter_ok then
    local prettier = require("formatter.defaults.prettier")
    -- local python_formatters = require("configs.python")
    formatter.setup({
      logging = false,
      log_level = vim.log.levels.OFF,
      filetype = {
        lua = {
          require("formatter.filetypes.lua").stylua,
        },
        -- Offload formatting to lsp! Use these settings if you want to revert:
        -- python = {
        --   -- function()
        --   --   return {
        --   --     exe = "ruff",
        --   --     args = { "check", "--select", "I", "--fix", "-" },
        --   --     stdin = true,
        --   --   }
        --   -- end,
        --   -- function()
        --   --   return {
        --   --     exe = "ruff",
        --   --     args = { "format", "-q", "-" },
        --   --     stdin = true,
        --   --   }
        --   -- end,
        --   -- Dependencies on Mason installation does not pop up.
        --   -- Can be configured in the configs.python.lua file!
        --   python_formatters.isort,
        --   python_formatters.black,
        --   python_formatters.autopep8,
        --   python_formatters.autoflake,
        -- },
        elixir = {
          require("formatter.filetypes.elixir").mixformat,
        },
        javascript = {
          prettier,
        },
        javascriptreact = {
          prettier,
        },
        typescript = {
          prettier,
        },
        typescriptreact = {
          prettier,
        },
        yaml = {
          prettier,
        },
        -- Obsidian addon appears to interfere with fomratter...
        -- markdown = {
        --   prettier,
        -- },
        -- Use the special "*" filetype for defining formatter configurations on any filetype
        ["*"] = {
          -- "formatter.filetypes.any" defines default configurations for any filetype
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })
  end
end

return M
