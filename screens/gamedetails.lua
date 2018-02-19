GameDetails = {}

function GameDetails:keypressed(key)
  if key == "backspace" then
    gamedetailsToGamelist()
    screen = GameList
  end
end

function GameDetails:draw_spinner(x, y, w, h)
  love.graphics.push()
  love.graphics.translate(x, y)

  local b = (math.cos(t * 5) + 1) * 32 + 32
  love.graphics.setColor(0, 0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, w, h)
  love.graphics.setColor(255, 255, 255, 128)
  love.graphics.circle("fill", w / 2 + math.cos(t * 5) * 40, h / 2 + math.sin(t * 5) * 40, 10)
  love.graphics.circle(
    "fill",
    w / 2 + math.cos(t * 5 + math.pi * 0.5) * 40,
    h / 2 + math.sin(t * 5 + math.pi * 0.5) * 40,
    10
  )
  love.graphics.circle(
    "fill",
    w / 2 + math.cos(t * 5 + math.pi * 1.0) * 40,
    h / 2 + math.sin(t * 5 + math.pi * 1.0) * 40,
    10
  )
  love.graphics.circle(
    "fill",
    w / 2 + math.cos(t * 5 + math.pi * 1.5) * 40,
    h / 2 + math.sin(t * 5 + math.pi * 1.5) * 40,
    10
  )

  love.graphics.pop()
end

function GameDetails:draw()
  local a = (math.cos(t * 5) + 1) * 128 + 128

  love.graphics.push()
  love.graphics.translate(0, gamedetails_container.y)

  love.graphics.setFont(font)
  love.graphics.setColor(0, 0, 0, 50)
  love.graphics.rectangle("fill", 0, 0, 1920, SCREEN_HEIGHT)
  love.graphics.setColor(255, 255, 255, 255)
  if tabs[ACTIVE_TAB].children[ACTIVE_GAME] then
    local thumb = tabs[ACTIVE_TAB].children[ACTIVE_GAME].thumbnail
    if thumb then
      love.graphics.draw(thumb, 300, 60, 0, 550 / thumb:getWidth())
    else
      GameDetails:draw_spinner(300, 60, 550, 550)
    end
  end

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("Developer:", 915, 60)
  love.graphics.printf("Square", 915, 60, 680, "right")
  love.graphics.print("Publisher:", 915, 60 + 75 * 1)
  love.graphics.printf("Sony", 915, 60 + 75 * 1, 680, "right")
  love.graphics.print("Release Date:", 915, 60 + 75 * 2)
  love.graphics.printf("June 1984", 915, 60 + 75 * 2, 680, "right")
  love.graphics.print("Rating:", 915, 60 + 75 * 3)
  love.graphics.printf("★★★☆☆", 915, 60 + 75 * 3, 680, "right")
  love.graphics.print("Players:", 915, 60 + 75 * 4)
  love.graphics.printf("2", 915, 60 + 75 * 4, 680, "right")
  love.graphics.print("Co-Op:", 915, 60 + 75 * 5)
  love.graphics.printf("Yes", 915, 60 + 75 * 5, 680, "right")
  love.graphics.print("Genre:", 915, 60 + 75 * 6)
  love.graphics.printf("Action RPG", 915, 60 + 75 * 6, 680, "right")

  love.graphics.setBlendMode("add")

  love.graphics.setColor(255, 255, 255, math.min(a, 255))
  love.graphics.rectangle("line", 915, 110 + 75 * 7, 680, 100)
  love.graphics.setColor(255, 255, 255, 16)
  love.graphics.rectangle("fill", 915, 110 + 75 * 7, 680, 100)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("▶ Run", 915 + 20, 125 + 75 * 7)

  love.graphics.setBlendMode("alpha")

  love.graphics.pop()
end
