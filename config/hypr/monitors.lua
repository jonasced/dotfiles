-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

---------------------------------------------------------------------------
-- Geometry helpers (all positions are in LOGICAL pixels)
--   logical size = physical size / scale   (w/h swapped if rotated 90/270)
---------------------------------------------------------------------------

-- "2560x1440@59.95" -> 2560, 1440
local function parse_mode(mode)
  local w, h = mode:match("^(%d+)x(%d+)")
  assert(w, "mode must look like WIDTHxHEIGHT[@RATE], got: " .. tostring(mode))
  return tonumber(w), tonumber(h)
end

-- Logical size of a monitor
local function logical_size(mode, scale, transform)
  local w, h = parse_mode(mode)
  local lw, lh = math.floor(w / scale), math.floor(h / scale)
  -- transforms 1, 3, 5, 7 rotate by 90/270 degrees -> swap width/height
  if transform and transform % 2 == 1 then
    lw, lh = lh, lw
  end
  return lw, lh
end

-- Offset along an edge.
-- align: "start" (left/top edges flush), "center", "end" (right/bottom edges flush)
local function align_offset(anchor_len, len, align)
  if align == "start" then return 0 end
  if align == "end" then return anchor_len - len end
  return math.floor((anchor_len - len) / 2) -- default: center
end

-- Position a monitor of size (w, h) next to an anchor geometry.
-- side: "above" | "below" | "left" | "right"
local function position_next_to(anchor, w, h, side, align)
  local x, y
  if side == "above" then
    x = anchor.x + align_offset(anchor.w, w, align)
    y = anchor.y - h
  elseif side == "below" then
    x = anchor.x + align_offset(anchor.w, w, align)
    y = anchor.y + anchor.h
  elseif side == "left" then
    x = anchor.x - w
    y = anchor.y + align_offset(anchor.h, h, align)
  elseif side == "right" then
    x = anchor.x + anchor.w
    y = anchor.y + align_offset(anchor.h, h, align)
  else
    error("side must be above/below/left/right, got: " .. tostring(side))
  end
  return x, y
end

-- Declare a monitor and return its geometry so others can be placed relative to it.
--   spec.output, spec.mode, spec.scale, spec.transform (optional)
--   spec.position = { x, y }                               -- absolute, or
--   spec.next_to = geom, spec.side = "...", spec.align = "..."  -- relative
local function monitor(spec)
  local scale = spec.scale or 1
  local w, h = logical_size(spec.mode, scale, spec.transform)

  local x, y
  if spec.next_to then
    x, y = position_next_to(spec.next_to, w, h, spec.side, spec.align)
  else
    x, y = spec.position[1], spec.position[2]
  end

  hl.monitor({
    output = spec.output,
    mode = spec.mode,
    position = string.format("%dx%d", x, y),
    scale = scale,
    transform = spec.transform,
  })

  return { output = spec.output, x = x, y = y, w = w, h = h }
end

---------------------------------------------------------------------------
-- Monitors
---------------------------------------------------------------------------

-- Laptop panel anchored at the origin.
local laptop = monitor({
  output = "eDP-1", mode = "2560x1600@165", scale = omarchy_monitor_scale,
  position = { 0, 0 },
})

-- -- standup-display: above the laptop, centered
monitor({
  output = "DP-9", mode = "3840x2160@30.00", scale = 1.25,
  next_to = laptop, side = "above", align = "center",
})

-- bright future: above the laptop, centered
-- monitor({
--   output = "DP-8", mode = "1920x1080@60.00Hz", scale = 1.25,
--   next_to = laptop, side = "above", align = "center",
-- })

-- home display: above the laptop, centered
-- monitor({
--   output = "DP-9", mode = "2560x1440@59.95", scale = 1.25,
--   next_to = laptop, side = "above", align = "center",
-- })
-- home display phantom monitor
-- hl.monitor({ output = "HDMI-A-1", disabled = true})

-- hl.monitor({ output = "HDMI-A-1", mode = "3440x1440@59.97", position = "-920x1440", scale = 1 })

-- -- work display
monitor({
  output = "HDMI-A-1", mode = "3440x1440@59.97", scale = 1.25,
  next_to = laptop, side = "above", align = "center",
})

-- home tv
-- monitor({
--   output = "HDMI-A-1", mode = "2560x1440@59.95", scale = 1,
--   next_to = laptop, side = "above", align = "center",
-- })
--
-- EXAMPLES:
-- Chain monitors: a portrait screen to the right of the home display, top edges flush
-- local home = monitor({ output = "DP-8", ..., next_to = laptop, side = "above" })
-- monitor({ output = "DP-9", mode = "2560x1440@60", scale = 1, transform = 1,
--           next_to = home, side = "right", align = "start" })

-- HOW TO ADD A NEW DISPLAY
-- hyprctl monitors all      -> find output name and mode
-- add a monitor({...}) call relative to an existing one
-- restart wayland if it doesn't register at all
