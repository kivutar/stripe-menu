tween = require 'tween'

math.randomseed( os.time() )

SCREEN_HEIGHT = 1080
ANGLE = 400
ACTIVE_TAB = 1
ACTIVE_GAME = 1
t1 = 0
OPEN=false

PASSIVE_TAB_WIDTH = 128
ACTIVE_TAB_WIDTH = 1200

PASSIVE_TAB_ZOOM = 0.25
ACTIVE_TAB_ZOOM = 1

ACTIVE_Y = SCREEN_HEIGHT/2
BEFORE_Y = 64
AFTER_Y = SCREEN_HEIGHT - 64

ACTIVE_X = ANGLE/2
BEFORE_X = ANGLE-22
AFTER_X = 22

HIDDEN_GAME_Y = SCREEN_HEIGHT + 100
ACTIVE_GAME_Y = SCREEN_HEIGHT / 2
BEFORE_GAME_Y = SCREEN_HEIGHT / 2 - 130
AFTER_GAME_Y = SCREEN_HEIGHT / 2 + 130

global = {
  x = -ACTIVE_TAB*PASSIVE_TAB_WIDTH
}

tabs = {
  { title="Settings", subtitle="Configure Lakka", width=ACTIVE_TAB_WIDTH,  x=ACTIVE_X, y=ACTIVE_Y, color={0 ,0 ,0, 0}, icon=love.graphics.newImage('png/setting.png'), zoom=ACTIVE_TAB_ZOOM},
  { title="Super Nintendo", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-00,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Nintendo - Super Nintendo Entertainment System.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="Nintendo 64", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-20,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Nintendo - Nintendo 64.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="Genesis", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-40,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Sega - Mega Drive - Genesis.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="PlayStation 2", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-60,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Sony - PlayStation 2.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="3DO", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-80,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/The 3DO Company - 3DO.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="Saturn", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-80,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Sega - Saturn.png'), zoom=PASSIVE_TAB_ZOOM},
  { title="Game Boy Advance", subtitle="13 Games - 3 Favorites", width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, color={255-80,math.random(155),math.random(100)}, icon=love.graphics.newImage('png/Nintendo - Game Boy Advance.png'), zoom=PASSIVE_TAB_ZOOM},
}

games = {
  { y=HIDDEN_GAME_Y, title='Game 1 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 2 - With another title' },
  { y=HIDDEN_GAME_Y, title='Game 3 - With a medium title' },
  { y=HIDDEN_GAME_Y, title='Game 4 - Quite short' },
  { y=HIDDEN_GAME_Y, title='Game 5 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 6 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 7 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 8 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 9 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 11 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 12 - With a pretty long title' },
  { y=HIDDEN_GAME_Y, title='Game 13 - With a pretty long title' },
}

function love.load()
  love.window.setMode(1920/2, SCREEN_HEIGHT/2, {highdpi = true, msaa = 2})
  love.graphics.setBackgroundColor(0, 0, 50)
  font = love.graphics.newFont('font.ttf', 40)
  smallfont = love.graphics.newFont('font.ttf', 25)
end

function updateTabs()
  for i=1,#tabs do
    if i == ACTIVE_TAB then
      tab_width = ACTIVE_TAB_WIDTH
      tab_zoom = ACTIVE_TAB_ZOOM
      tab_y = ACTIVE_Y
      tab_x = ACTIVE_X
    else
      tab_width = PASSIVE_TAB_WIDTH
      tab_zoom = PASSIVE_TAB_ZOOM
      if i < ACTIVE_TAB then
        tab_y = BEFORE_Y
        tab_x = BEFORE_X
      else
        tab_y = AFTER_Y
        tab_x = AFTER_X
      end
    end
    tween(0.2, tabs[i],  { width = tab_width }, 'outSine')
    tween(0.2, tabs[i],  { zoom = tab_zoom }, 'outSine')
    tween(0.2, tabs[i],  { y = tab_y }, 'outSine')
    tween(0.2, tabs[i],  { x = tab_x }, 'outSine')
    tween(0.2, global,  { x = -ACTIVE_TAB*PASSIVE_TAB_WIDTH }, 'outSine')
  end

  for i=1,#games do
    tween(0.2, games[i],  { y = HIDDEN_GAME_Y }, 'outSine')
  end
end

function updateGames()
  for i=1,#games do
    if i == ACTIVE_GAME then
      game_y = ACTIVE_GAME_Y
    elseif i < ACTIVE_GAME then
      game_y = BEFORE_GAME_Y
    else
      game_y = AFTER_GAME_Y
    end
    tween(0.2, games[i],  { y = -ACTIVE_GAME * 80 + game_y + (i - 1) * 80 }, 'outSine')
  end
end

function openTab()
  for i=1,#tabs do
    if i == ACTIVE_TAB then
      tab_width = ACTIVE_TAB_WIDTH*4
      tab_zoom = ACTIVE_TAB_ZOOM
      tab_y = ACTIVE_Y
      tab_x = ACTIVE_X
    else
      tab_width = 0
      tab_zoom = 0
      if i < ACTIVE_TAB then
        tab_y = BEFORE_Y
        tab_x = BEFORE_X
      else
        tab_y = AFTER_Y
        tab_x = AFTER_X
      end
    end
    tween(0.2, tabs[i],  { width = tab_width }, 'outSine')
    tween(0.2, tabs[i],  { zoom = tab_zoom }, 'outSine')
    tween(0.2, tabs[i],  { y = tab_y }, 'outSine')
    tween(0.2, tabs[i],  { x = tab_x }, 'outSine')
    tween(0.2, global,  { x = -1300 }, 'outSine')
  end

  updateGames()
end

function love.update(dt)
  tween.update(dt)

  if not OPEN and love.keyboard.isDown("right") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB + 1
    if ACTIVE_TAB > #tabs then
      ACTIVE_TAB = 1
    end

    updateTabs()
  end

  if not OPEN and love.keyboard.isDown("left") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB - 1
    if ACTIVE_TAB < 1 then
      ACTIVE_TAB = #tabs
    end

    updateTabs()
  end

  if love.keyboard.isDown("return") and not OPEN then
    t1 = love.timer.getTime()
    openTab()
    OPEN = true
  end

  if love.keyboard.isDown("backspace") and OPEN then
    t1 = love.timer.getTime()
    updateTabs()
    OPEN = false
  end

  if OPEN and love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME + 1
    if ACTIVE_GAME > #games then
      ACTIVE_GAME = 1
    end

    updateGames()
  end

  if OPEN and love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME - 1
    if ACTIVE_GAME < 1 then
      ACTIVE_GAME = #games
    end

    updateGames()
  end

end

function love.draw()
  stack_height = 285

  for i=1,#tabs do
    love.graphics.setColor(tabs[i].color)

    love.graphics.polygon("fill",
      global.x + stack_height+ANGLE, 0,
      global.x + stack_height+tabs[i].width+ANGLE, 0,
      global.x + stack_height+tabs[i].width, SCREEN_HEIGHT,
      global.x + stack_height, SCREEN_HEIGHT)

    love.graphics.setColor(255, 255, 255)

    love.graphics.draw(tabs[i].icon,
      global.x + stack_height + tabs[i].width/2 + tabs[i].x, tabs[i].y,
      0, tabs[i].zoom, tabs[i].zoom,
      128, 128
    )

    love.graphics.setFont(font)
    love.graphics.printf(tabs[i].title,
      global.x + stack_height + tabs[i].x, tabs[i].y + 120,
      tabs[i].width, 'center'
    )

    love.graphics.setFont(smallfont)
    love.graphics.printf(tabs[i].subtitle,
      global.x + stack_height + tabs[i].x, tabs[i].y + 200,
      tabs[i].width, 'center'
    )

    stack_height = stack_height + tabs[i].width
  end

  love.graphics.setFont(font)
  for i=1,#games do
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(games[i].title, 300, games[i].y + 20)
  end
end
