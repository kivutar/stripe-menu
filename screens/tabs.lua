Tabs = {}

function Tabs:update(dt)
  if love.keyboard.isDown("right") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB + 1
    if ACTIVE_TAB > #tabs then
      ACTIVE_TAB = 1
    end

    animateTabs()
  end

  if love.keyboard.isDown("left") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB - 1
    if ACTIVE_TAB < 1 then
      ACTIVE_TAB = #tabs
    end

    animateTabs()
  end
end

function Tabs:keypressed(key)
  if key == "return" then
    tabsToGameList()
    SCREEN = SCREEN_GAMELIST
  end
end

function Tabs:draw()
  love.graphics.push()
  love.graphics.translate(tabs_container.x, 0)

  local stack_width = 285

  for i = 1, #tabs do
    -- if i > 1 then
    --   --love.graphics.setBlendMode('add')
    --   love.graphics.setShader(greyscale)
    --   love.graphics.setColor(40, 40, 40, 255)
    --   local function myStencilFunction()
    --     love.graphics.polygon("fill",
    --       stack_width+ANGLE, 0,
    --       stack_width+tabs[i].width+ANGLE, 0,
    --       stack_width+tabs[i].width, SCREEN_HEIGHT,
    --       stack_width, SCREEN_HEIGHT
    --     )
    --   end

    --   love.graphics.stencil(myStencilFunction, "replace", 1)
    --   love.graphics.setStencilTest("greater", 0)
    --   love.graphics.draw(tabs[i].bg, -tabs_container.x, 0, 0, 1920/1280, 1080/720)
    --   love.graphics.setStencilTest()
    --   love.graphics.setShader()
    --   --love.graphics.setBlendMode('alpha')
    -- end

    love.graphics.setColor(tabs[i].color)
    love.graphics.polygon(
      "fill",
      stack_width + ANGLE,
      0,
      stack_width + tabs[i].width + ANGLE,
      0,
      stack_width + tabs[i].width,
      SCREEN_HEIGHT,
      stack_width,
      SCREEN_HEIGHT
    )

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.draw(
      tabs[i].icon,
      stack_width + tabs[i].width / 2 + tabs[i].x,
      tabs[i].y,
      0,
      tabs[i].zoom*256.0/tabs[i].icon:getWidth(),
      tabs[i].zoom*256.0/tabs[i].icon:getHeight(),
      tabs[i].icon:getWidth()/2,
      tabs[i].icon:getHeight()/2
    )

    love.graphics.setColor(255, 255, 255, tabs[i].title_alpha)

    love.graphics.setFont(font)
    love.graphics.printf(tabs[i].title, stack_width + tabs[i].x, tabs[i].y + 120, tabs[i].width, "center")

    love.graphics.setFont(smallfont)
    love.graphics.printf(tabs[i].subtitle, stack_width + tabs[i].x, tabs[i].y + 200, tabs[i].width, "center")

    stack_width = stack_width + tabs[i].width
  end

  love.graphics.pop()
end