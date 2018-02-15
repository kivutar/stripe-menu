function draw_settings()
  love.graphics.push()
  love.graphics.translate(0, settings_container.y)

  love.graphics.setFont(font)
  love.graphics.setColor(0, 0, 0, 50)
  love.graphics.rectangle("fill", 0, 0, 1920, SCREEN_HEIGHT)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("Option 1", 300, 60)

  love.graphics.pop()
end