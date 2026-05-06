-- nvim-treesitter (archived master) uses `all = false` in add_directive opts
-- to get a single TSNode per capture. Neovim 0.12 dropped support for that
-- option, so match[capture_id] now returns TSNode[] instead of TSNode. The
-- nil check passes (table is truthy) but node:range() then crashes on a table.
-- Re-register the three affected directives here with an unwrap shim.

local ok, query = pcall(require, "vim.treesitter.query")
if not ok then return end

local function unwrap(node)
  return type(node) == "table" and node[1] or node
end

local non_filetype_aliases = {
  ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript",
}

local html_script_types = {
  ["importmap"] = "json",
  ["module"] = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

local function lang_from_info_string(alias)
  local match = vim.filetype.match { filename = "a." .. alias }
  return match or non_filetype_aliases[alias] or alias
end

local opts = { force = true }

query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local node = unwrap(match[pred[2]])
  if not node then return end
  local alias = vim.treesitter.get_node_text(node, bufnr):lower()
  metadata["injection.language"] = lang_from_info_string(alias)
end, opts)

query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
  local node = unwrap(match[pred[2]])
  if not node then return end
  local val = vim.treesitter.get_node_text(node, bufnr)
  local configured = html_script_types[val]
  if configured then
    metadata["injection.language"] = configured
  else
    local parts = vim.split(val, "/", {})
    metadata["injection.language"] = parts[#parts]
  end
end, opts)

query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local node = unwrap(match[id])
  if not node then return end
  local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
  if not metadata[id] then metadata[id] = {} end
  metadata[id].text = string.lower(text)
end, opts)
