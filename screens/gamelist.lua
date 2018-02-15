function draw_cursor()
  love.graphics.setColor(255, 255, 255, cursor.alpha)

  love.graphics.push()
  love.graphics.translate(208, SCREEN_HEIGHT / 2)
  love.graphics.rotate(t)
  love.graphics.rectangle("fill", -15, -15, 30, 30)
  love.graphics.pop()

  love.graphics.push()
  love.graphics.translate(208, SCREEN_HEIGHT / 2)
  love.graphics.rotate(t + math.pi / 4)
  love.graphics.rectangle("fill", -15, -15, 30, 30)
  love.graphics.pop()

  love.graphics.setBlendMode("add")

  local a = (math.cos(t * 5) + 1) * 128 + 128
  love.graphics.setColor(255, 255, 255, math.min(a, cursor.alpha))
  love.graphics.rectangle("line", 160, SCREEN_HEIGHT / 2 - 50, cursor.width, 100)
  love.graphics.setColor(255, 255, 255, math.min(16, cursor.alpha))
  love.graphics.rectangle("fill", 160, SCREEN_HEIGHT / 2 - 50, cursor.width, 100)

  love.graphics.setBlendMode("alpha")
end

function draw_gamelist()
  love.graphics.push()
  love.graphics.translate(0, gamelist_container.y)

  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    love.graphics.setFont(font)
    love.graphics.setColor(255, 255, 255, list[i].alpha)
    love.graphics.print(list[i].title, 300, list[i].y + 45)

    love.graphics.setColor(255, 255, 255, list[i].flag_alpha)
    local stack_width = 20
    local title_width = font:getWidth(list[i].title)
    for f = 1, #list[i].flags do
      if flags[list[i].flags[f]] then
        love.graphics.draw(flags[list[i].flags[f]], 300 + title_width + stack_width, list[i].y + 58)
        stack_width = stack_width + 71
      end
    end

    if list[i].mark then
      love.graphics.setFont(smallfont)
      love.graphics.setColor(255, 255, 255, list[i].mark_alpha)
      love.graphics.print(list[i].mark, 200, list[i].y + 56)
    end
  end

  draw_cursor()

  love.graphics.pop()
end