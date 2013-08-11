-- Create a textclock widget
mytextclock = awful.widget.textclock("%a %b %d, %I:%M %p")

-- Create Battery Widget
batterywidget = wibox.widget.textbox()

function batteryInfo()
  local battery_output = {}
  local battery_command = io.popen("acpitool -b", "r")
  local battery_line = battery_command:read()

  while battery_line do
    --local battery_num = string.match(battery_line, "Battery \#(%d+)")
    local battery_load = string.match(battery_line, " (%d*).%d+%%")
    local time_remaining = string.match(battery_line, "(%d+:%d+):%d+")
    local color
    local direction

    if battery_load and tonumber(battery_load) < 10 then
      naughty.notify({ title      = "Battery Warning"
                     , text       = "Battery low! "..battery_load..'% left!'
                     , timeout    = 5
                     , position   = "top_right"
                     , fg         = beautiful.fg_focus
                     , bg         = beautiful.bg_focus
                     })
    end

    if tonumber(battery_load) < 25 then -- almost out
      color = '#dc322f' -- red
    elseif tonumber(battery_load) < 75 then -- middle charged
      color = '#af8700' -- yellow
    else --charging
      color = '#00cc00' -- green
    end

    if  string.match(battery_line, "Discharging") == "Discharging" then
      direction = "⊝"
    else
      direction = "⚡"
    end

    if battery_load and time_remaining then
      table.insert(battery_output, '<span color="'..color..'">'..direction..battery_load..'% ('..time_remaining..")</span>")
    elseif battery_load then
      table.insert(battery_output, '<span color="'..color..'">'..direction..battery_load..'%</span>')
    else
      table.insert(battery_output, '<span color="#dc322f">?!</span>')
    end

    battery_line = battery_command:read() -- read the next line
  end

  local battery = table.concat(battery_output, ' ')

  batterywidget:set_markup(' '..battery..' ')
end

batteryInfo()
battimer = timer({ timeout = 0.1 })
battimer:connect_signal("timeout", function()
  batteryInfo()
end)
battimer:start()
