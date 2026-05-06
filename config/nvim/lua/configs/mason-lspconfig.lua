local M = {}

function M.config()
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if status_ok then
    local handlers = {
      function(server_name)
        local lsp = require("configs.lsp")
        lsp.setup_server(server_name)
      end,
    }

    mason_lspconfig.setup({ handlers = handlers })
  end
end

return M
