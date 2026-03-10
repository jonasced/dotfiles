local M = {}

function M.config()
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if luasnip_ok then
    -- Keep memory of the snippet to be able to cycle placeholders at any time
    luasnip.setup({
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    })
    -- Setup for snippets
    local s = luasnip.snippet
    local i = luasnip.insert_node
    local f = luasnip.function_node

    -- Add div snippet
    luasnip.add_snippets("all", {
      s("div", {
        f(function()
          -- Extract the comment prefix from commentstring (e.g. "// %s" -> "//")
          local cs = vim.bo.commentstring
          local prefix = cs:match("^(.-)%s*%%s") or "//"
          local line = prefix .. " " .. string.rep("=", 96 - #prefix - 1)
          return { line, prefix .. " " }
        end),
        i(1, "Replace me"),
        f(function()
          local cs = vim.bo.commentstring
          local prefix = cs:match("^(.-)%s*%%s") or "//"
          local line = prefix .. " " .. string.rep("=", 96 - #prefix - 1)
          return { "", line }
        end),
      }),
    })
  end

  local loader_ok, loader = pcall(require, "luasnip.loaders.from_vscode")
  if loader_ok then
    -- This function can also take paths to custom snippets, see luasnip docs
    loader.lazy_load()
  end
end

return M
