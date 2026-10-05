-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6
-- above the laptop, horizontally centered: position is the top-left corner in logical pixels: y = -(logical height), x = (1600 - 3440) / 2.
local above_laptop_position = "-920x-1440"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Laptop panel anchored at the origin.
hl.monitor({ output = "eDP-1", mode = "2560x1600@165", position = "0x0", scale = omarchy_monitor_scale })

--  work display
-- hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@59.97", position = above_laptop_position, scale = 1 })

-- home tv
-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@59.95", position = above_laptop_position, scale = 1 })

-- home display
hl.monitor({ output = "DP-8", mode = "2560x1440@74.97", position = above_laptop_position, scale = omarchy_monitor_scale })

-- HOW TO ADD A NEW DISPLAY
-- hyprctl monitors
-- add output, mode and position
-- restartwayland if it doesn't register at all

-- EXAMPLES:
-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
