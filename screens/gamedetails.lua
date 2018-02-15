function draw_gamedetails()
  love.graphics.push()
  love.graphics.translate(0, gamedetails_container.y)

  love.graphics.setFont(font)
  love.graphics.setColor(0, 0, 0, 50)
  love.graphics.rectangle("fill", 0, 0, 1920, SCREEN_HEIGHT)
  love.graphics.setColor(255, 255, 255, 255)
  if tabs[ACTIVE_TAB].children[ACTIVE_GAME] then
    local th = tabs[ACTIVE_TAB].children[ACTIVE_GAME].thumbnail
    if th then
      love.graphics.draw(th, 300, 60, 0, 550 / th:getWidth())
    end
  end

  love.graphics.print("Developer: Square", 915, 60)
  love.graphics.print("Publisher: Sony", 915, 60 + 75 * 1)
  love.graphics.print("Release Date: June 1984", 915, 60 + 75 * 2)
  love.graphics.print("Rating: ★★★☆☆", 915, 60 + 75 * 3)
  love.graphics.print("Players: 2", 915, 60 + 75 * 4)
  love.graphics.print("Co-Op: Yes", 915, 60 + 75 * 5)
  love.graphics.print("Genre: Action RPG", 915, 60 + 75 * 6)

  love.graphics.setBlendMode("add")

  local a = (math.cos(t * 5) + 1) * 128 + 128
  love.graphics.setColor(255, 255, 255, math.min(a, 255))
  love.graphics.rectangle("line", 915, 90 + 75 * 7, 550, 100)
  love.graphics.setColor(255, 255, 255, 16)
  love.graphics.rectangle("fill", 915, 90 + 75 * 7, 550, 100)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("▶ Run", 915 + 20, 105 + 75 * 7)

  love.graphics.setBlendMode("alpha")

  love.graphics.pop()
end