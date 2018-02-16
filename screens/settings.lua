function draw_settings_cursor()
  love.graphics.setBlendMode("add")

  local a = (math.cos(t * 5) + 1) * 128 + 128
  love.graphics.setColor(255, 255, 255, math.min(a, 255))
  love.graphics.rectangle("line", 300-20, 42, 1350, 100)
  love.graphics.setColor(255, 255, 255, math.min(16, 255))
  love.graphics.rectangle("fill", 300-20, 42, 1350, 100)

  love.graphics.setBlendMode("alpha")
end

function draw_settings_string(setting, i)
  love.graphics.printf(setting.value, 300, 60 + (i - 1) * 100, 800, "right")
end

function draw_settings_bool(setting, i)
  if setting.value then
    love.graphics.draw(bool_on, 1460, 92 + (i - 1) * 100, 0, 0.7, 0.7, 0, bool_on:getHeight()/2)
  else
    love.graphics.draw(bool_off, 1460, 92 + (i - 1) * 100, 0, 0.7, 0.7, 0, bool_on:getHeight()/2)
  end
end

function draw_settings_list(setting, i)
  love.graphics.printf("◀ " .. setting.options[setting.value] .. " ▶", 300, 60 + (i - 1) * 100, 1310, "right")
end

function draw_settings()
  love.graphics.push()
  love.graphics.translate(0, settings_container.y)

  love.graphics.setFont(font)
  love.graphics.setColor(0, 0, 0, 50)
  love.graphics.rectangle("fill", 0, 0, 1920, SCREEN_HEIGHT)

  love.graphics.setColor(255, 255, 255, 255)
  local list = tabs[ACTIVE_TAB].children[ACTIVE_GAME].children
  if list then
    for i = 1, #list do
      love.graphics.print(list[i].title, 300, 60 + (i - 1) * 100)
      if list[i].type == "string" then
        draw_settings_string(list[i], i)
      elseif list[i].type == "bool" then
        draw_settings_bool(list[i], i)
      elseif list[i].type == "list" then
        draw_settings_list(list[i], i)
      end
    end
  else
    love.graphics.print("Empty", 300, 60)
  end

  draw_settings_cursor()

  love.graphics.pop()
end