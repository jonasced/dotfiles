local M = {}

function M.config()
  local status_ok, mason = pcall(require, "mason")
  if status_ok then
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    })

    require("configs.mason-tools-installer").config()
    -- mason-lspconfig contains pyright, which I've not figured out how to configure yet.
    -- Leave disabled for now. It is probably a better way of linting/formatting so TODO
    require("configs.mason-lspconfig").config()
    require("configs.nvim-lint").config()
    require("configs.formatter").config()
    require("configs.mason-nvim-dap").config()
  end
end

return M
