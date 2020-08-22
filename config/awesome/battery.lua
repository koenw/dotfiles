-- This function returns a formatted string with the current battery status. It
-- can be used to populate a text widget in the awesome window manager. Based
-- on the "Gigamo Battery Widget" found in the wiki at awesome.naquadah.org

local naughty = require("naughty")
local beautiful = require("beautiful")

function readFile(path)
  file = io.open(path, "r")
  if file then
    local str = file:read()
    file:close()
    return str
  end
end

-- Given the name of a power device (e.g. BAT0) and a list of metrics
-- corresponding to files in `/sys/class/power_supply/*/`, return the value of
-- the given metric.
function getBatteryMetric(adapter, ...)
  local basepath = "/sys/class/power_supply/"..adapter.."/"
  for i, name in pairs({...}) do
    result = readFile(basepath .. name)
    if result then
      return result
    end
  end
end

function getPowerUsage(adapter)
  local uwatts = readFile("/sys/class/power_supply/" .. adapter .. "/power_now")
  if uwatts then
    return uwatts
  end
end

function batteryInfo(adapter)
  local fh = io.open("/sys/class/power_supply/"..adapter.."/present", "r")
  if fh == nil then
    battery = "A/C"
    icon = ""
    percent = ""
  else
    local energy_now = getBatteryMetric(adapter, "charge_now", "energy_now")
    local energy_full = getBatteryMetric(adapter, "charge_full", "energy_full")
    local status = getBatteryMetric(adapter, "status")
    uwatts = getPowerUsage(adapter)
    power_usage = ""
    if uwatts then
      power_usage = uwatts * 10^-6
    else
      power_usage = "?"
    end

    battery_percent = math.floor(energy_now / energy_full * 100)

    if status:match("Charging") then
      icon = "🔌"
      percent = "%"

      if tonumber(battery_percent) == 80 then
        naughty.notify({ title    = "Battery charged to 80%, unplug charger?"
               , text     = ""
               , timeout  = 5
               , position = "top_right"
               , fg       = beautiful.fg_focus
               , bg       = beautiful.bg_focus
        })
      end
    elseif status:match("Discharging") then
      icon = "🔋"
      percent = "%"
      if tonumber(battery_percent) < 15 then
        naughty.notify({ title    = "Battery Warning"
               , text     = "Battery low!".."  "..battery_percent..percent.."  ".."left!"
               , timeout  = 5
               , position = "top_right"
               , fg       = beautiful.fg_focus
               , bg       = beautiful.bg_focus
        })
      end

      if tonumber(battery_percent) == 40 then
        naughty.notify({ title    = "Battery down to 40%, plug charger?"
               , text     = ""
               , timeout  = 5
               , position = "top_right"
               , fg       = beautiful.fg_focus
               , bg       = beautiful.bg_focus
        })
      end
    else
      -- If we are neither charging nor discharging, assume that we are on A/C
      battery = "A/C"
      icon = ""
      percent = ""
    end

    -- fix 'too many open files' bug on awesome 4.0
    fh:close()
  end
  return " " .. icon .. battery_percent .. percent .. " " .. power_usage .. " W⚡"
end
