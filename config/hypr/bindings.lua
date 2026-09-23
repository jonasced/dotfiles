-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
--
-- jmj: This is a display setting that I can go without using for now
hl.unbind("SUPER + SLASH")
-- Keybindings help (same command Omarchy binds to SUPER + K by default).
o.bind("SUPER + SLASH", "Keybindings", "omarchy-menu-keybindings")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Vim-style navigation. Displaced defaults are noted so they can be found again.
-- (SUPER + H/K/L are already unbound above.)
hl.unbind("SUPER + H")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + J")        -- was: Toggle window split

-- Focus between windows
o.bind("SUPER + H", "Focus on left window",  hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Move the current window in that direction (crosses to the next monitor at the edge)
o.bind("SUPER + SHIFT + H", "Move window left",  hl.dsp.window.move({ direction = "left" }))
o.bind("SUPER + SHIFT + J", "Move window down",  hl.dsp.window.move({ direction = "down" }))
o.bind("SUPER + SHIFT + K", "Move window up",    hl.dsp.window.move({ direction = "up" }))
o.bind("SUPER + SHIFT + L", "Move window right", hl.dsp.window.move({ direction = "right" }))

-- Move the whole workspace to the monitor in that direction
o.bind("SUPER + SHIFT + CTRL + H", "Move workspace to left monitor",  hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + SHIFT + CTRL + J", "Move workspace to down monitor",  hl.dsp.workspace.move({ monitor = "d" }))
o.bind("SUPER + SHIFT + CTRL + K", "Move workspace to up monitor",    hl.dsp.workspace.move({ monitor = "u" }))
o.bind("SUPER + SHIFT + CTRL + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))

-- Old workspace move on SUPER + CTRL. It collided with these defaults, so they were
-- unbound and rehomed on SUPER + ALT. Uncomment all of it to switch back.
-- hl.unbind("SUPER + CTRL + H") -- was: Hardware menu
-- hl.unbind("SUPER + CTRL + K") -- was: Herdr keybindings (SUPER + ALT + K is Tmux keybindings)
-- hl.unbind("SUPER + CTRL + L") -- was: Lock system
-- o.bind("SUPER + CTRL + H", "Move workspace to left monitor",  hl.dsp.workspace.move({ monitor = "l" }))
-- o.bind("SUPER + CTRL + J", "Move workspace to down monitor",  hl.dsp.workspace.move({ monitor = "d" }))
-- o.bind("SUPER + CTRL + K", "Move workspace to up monitor",    hl.dsp.workspace.move({ monitor = "u" }))
-- o.bind("SUPER + CTRL + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
-- o.bind("SUPER + ALT + H", "Hardware menu", "omarchy-menu toggle hardware")
-- o.bind("SUPER + ALT + L", "Lock system",   "omarchy-system-lock")

-- Rehome the plain-SUPER defaults displaced by the focus keys
o.bind("SUPER + ALT + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + ALT + SHIFT + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")
