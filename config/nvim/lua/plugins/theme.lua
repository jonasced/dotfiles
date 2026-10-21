-- Omarchy writes its generated theme spec here when a theme is selected
-- (see all-themes.lua and omarchy-theme-hotreload.lua for the rest of the
-- integration). Fall back to a static default when Omarchy isn't installed
-- or hasn't picked a theme yet, so this file works on any machine.
local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

if vim.fn.filereadable(omarchy_theme) == 1 then
  return dofile(omarchy_theme)
end

return {
  {
    "OldJobobo/retro-82.nvim",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "retro-82",
    },
  },
}
