-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Laptop panel anchored at the origin.
hl.monitor({ output = "eDP-1", mode = "2560x1600@165", position = "0x0", scale = omarchy_monitor_scale })
-- External ultrawide above the laptop, horizontally centered.
-- Position is the top-left corner in logical pixels: y = -(logical height), x = (1600 - 3440) / 2.
-- hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@60", position = "-920x-1440", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@59.97", position = "-920x-1440", scale = 1 })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
