local M = {}

-- Removing context_commentstring since it appears to be deprecated. Using comment still. error message below:
-- context_commentstring nvim-treesitter module is deprecated, use require('ts_context_commentstring').setup {} and set vim.g.skip_ts_context_commentstring_module = true to speed up loading instead.
function M.config()
  local comment_ok, comment = pcall(require, "Comment")
  if comment_ok then
    comment.setup()
  vim.g.skip_ts_context_commentstring_module = true
  end
end

return M
