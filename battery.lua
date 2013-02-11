-- Create a textclock widget
mytextclock = awful.widget.textclock("%a %b %d, %I:%M %p")

-- Create Battery Widget
batterywidget = wibox.widget.textbox()

function batteryInfo(adapter)
  spacer = " "

  local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")

  if not fcur then
    fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")
  end

  local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")

  if not fcap then
    fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
  end

  local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")

  if not fcur or not fcap or not fsta then
    batterywidget:set_markup(spacer.."Bat:"..spacer..'<span color="#dc322f">?!</span>'..spacer)

    return
  end

  local cur = fcur:read()
  local cap = fcap:read()
  local sta = fsta:read()

  fcur:close()
  fcap:close()
  fsta:close()

  if not cur or not cap or not sta then
    batterywidget:set_markup(spacer.."Bat:"..spacer..'<span color="#dc322f">?!</span>'..spacer)

    return
  end

  local battery = math.floor(cur * 100 / cap)

  if sta:match("Charging") then
    battery = "⚡"..battery..'%'

    battery = '<span color="#5f8700">'..battery.."</span>"
  elseif sta:match("Discharging") then
    dir = "▼"

    if tonumber(battery) > 25 and tonumber(battery) < 75 then
      battery = '<span color="#af8700">'..dir..battery..'%'.."</span>"
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
      battery = '<span color="#d70000">'..dir..battery..'%'.."</span>"
    else
      battery = '<span color="#5f8700">'..dir..battery..'%'.."</span>"
    end
  else
    battery = '<span color="#5f8700">⚡</span>'
  end

  batterywidget:set_markup(spacer.."Bat:"..spacer..battery..spacer)
end

batteryInfo("BAT0")
battimer = timer({ timeout = 5 })
battimer:connect_signal("timeout", function()
  batteryInfo("BAT0")
end)
battimer:start()
