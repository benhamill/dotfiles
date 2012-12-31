-- Create a textclock widget
mytextclock = awful.widget.textclock("%a %b %d, %I:%M %p")

-- Create Battery Widget
batterywidget = wibox.widget.textbox()

function batteryInfo(adapter)
  spacer = " "

  -- ZOMG FIXME
  local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")

  if not fcur then
    fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
  end

  local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")

  if not fcap then
    fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
  end

  local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")

  local cur = 0
  local cap = 1
  local sta = ''

  if fcur then
    cur = fcur:read()
  end

  if fcap then
    cap = fcap:read()
  end

  if fsta then
    sta = fsta:read()
  end

  local battery = math.floor(cur * 100 / cap)

  if sta:match("Charging") then
    dir = "▲"
    battery = "A/C ("..battery..'%'..")"

    battery = '<span color="#5f8700">'..battery..dir.."</span>"
  elseif sta:match("Discharging") then
    dir = "▼"

    if tonumber(battery) > 25 and tonumber(battery) < 75 then
      battery = '<span color="#af8700">'..battery..'%'..dir.."</span>"
    elseif tonumber(battery) < 25 then
      if tonumber(battery) < 10 then
        naughty.notify({ title      = "Battery Warning"
                       , text       = "Battery low!"..spacer..battery..'%'..spacer.."left!"
                       , timeout    = 5
                       , position   = "top_right"
                       , fg         = beautiful.fg_focus
                       , bg         = beautiful.bg_focus
                       })
      end
      battery = '<span color="#d70000">'..battery..'%'..dir.."</span>"
    else
      battery = '<span color="#5f8700">'..battery..'%'..dir.."</span>"
    end
  else
    dir = "⚡"
    battery = "A/C"

    battery = '<span color="#5f8700">'..battery..dir.."</span>"
  end

  batterywidget:set_markup(spacer.."Bat:"..spacer..battery..spacer)

  if fcur then
    fcur:close()
  end

  if fcap then
    fcap:close()
  end

  if fsta then
    fsta:close()
  end
end

batteryInfo("BAT0")
battimer = timer({ timeout = 5 })
battimer:connect_signal("timeout", function()
  batteryInfo("BAT0")
end)
battimer:start()
