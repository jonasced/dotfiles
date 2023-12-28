local M = {}

function M.config()
  local lint_ok, lint = pcall(require, "lint")
  if lint_ok then
    -- Linting is performed accordingly when mason-lspconfig is not overriding it.
    -- Setting arguments can be done here - observe that you overwrite the original args. Check in nvim-lint!
    -- Stored here:
    -- /home/jonas/.local/share/nvim/lazy/nvim-lint/lua/lint.lua
    local flake8 = require('lint').linters.flake8
    flake8.args = {
      -- Default args copied from flake8 args in nvim-lint folder
      '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
      '--no-show-source',
      -- Added args
      '--max-line-length=120',
      '-',
    }
    lint.linters_by_ft = {
      -- However the mason extension seems not needed to be installed (except for mypy, ruff)
      -- These are removed due to overlap with pyright from mason-lspconfig
      -- "flake8", "mypy", "pylint",
      -- Ruff is customized in the ruff config folder
      python = { "ruff" },
      terraform = { "tflint" },
      sh = { "shellcheck" },
    }
  end
end

return M
