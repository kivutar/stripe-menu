tween = require 'tween'
require 'hsl'

math.randomseed( os.time() )

SCREEN_HEIGHT = 1080
ANGLE = 400
ACTIVE_TAB = 1
ACTIVE_GAME = 1
t = 0
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
BEFORE_GAME_Y = SCREEN_HEIGHT / 2 - 140
AFTER_GAME_Y = SCREEN_HEIGHT / 2 + 140

global = {
  x = -ACTIVE_TAB*PASSIVE_TAB_WIDTH
}

cursor = {
  y = HIDDEN_GAME_Y
}

tabs = {
  { title="Settings", subtitle="Configure Lakka", title_alpha=255, width=ACTIVE_TAB_WIDTH,  x=ACTIVE_X, y=ACTIVE_Y, icon=love.graphics.newImage('png/setting.png'), zoom=ACTIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Nintendo - Game Boy.png'), title="Game Boy", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Nintendo - Game Boy.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Nintendo - Game Boy Advance.png'), title="Game Boy Advance", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Nintendo - Game Boy Advance.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Nintendo - Super Nintendo Entertainment System.png'), title="Super Nintendo", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Nintendo - Super Nintendo Entertainment System.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Nintendo - Nintendo 64.png'), title="Nintendo 64", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Nintendo - Nintendo 64.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Sega - Mega Drive - Genesis.png'), title="Genesis", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Sega - Mega Drive - Genesis.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Sony - PlayStation.png'), title="PlayStation", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Sony - PlayStation.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Sony - PlayStation 2.png'), title="PlayStation 2", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Sony - PlayStation 2.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/The 3DO Company - 3DO.png'), title="3DO", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/The 3DO Company - 3DO.png'), zoom=PASSIVE_TAB_ZOOM},
  { bg = love.graphics.newImage('bg/Sega - Saturn.png'), title="Saturn", subtitle="13 Games - 3 Favorites", title_alpha=0, width=PASSIVE_TAB_WIDTH, x=AFTER_X, y=AFTER_Y, icon=love.graphics.newImage('png/Sega - Saturn.png'), zoom=PASSIVE_TAB_ZOOM},
}

for i=1,#tabs do
  tabs[i].color = {HSL((i-1)*30,128,128,140)}
end

games = {
  { flags={}, y=HIDDEN_GAME_Y, title='After Burner Complete (Europe)' },
  { flags={}, y=HIDDEN_GAME_Y, title='After Burner Complete ~ After Burner (Japan, USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Amazing Spider-Man, The - Web of Fire (USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='BC Racers (USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Blackthorne (USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Brutal Unleashed - Above the Claw (USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Chaotix ~ Knuckles\' Chaotix (Japan, USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Cosmic Carnage (Europe)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Cyber Brawl ~ Cosmic Carnage (Japan, USA)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Darxide (Europe) (En,Fr,De,Es)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Doom (Europe)' },
  { flags={}, y=HIDDEN_GAME_Y, title='Doom (Japan, USA)' },
}

function mark_games()
  mark = ''
  for i=1,#games do
    first = string.sub(games[i].title, 1, 1)
    if first ~= mark then
      mark = first
      games[i].mark = mark
    end
  end
end

function flag_games()
  for i=1,#games do
    for capture in games[i].title:gmatch("%s%((.-)%)") do
      for word in capture:gmatch('([^, ]+)') do
        table.insert(games[i].flags, word)
      end
    end
    games[i].title = games[i].title:gsub("%s%((.-)%)", '')
    games[i].flag_alpha = 0
  end
end

function love.load()
  love.window.setMode(1920/2, SCREEN_HEIGHT/2, {highdpi = true, msaa = 2})
  love.graphics.setBackgroundColor(tabs[1].color)
  font = love.graphics.newFont('font.ttf', 40)
  smallfont = love.graphics.newFont('font.ttf', 25)
  flags = {}
  flags['Japan'] = love.graphics.newImage('flags/Japan.png')
  flags['Europe'] = love.graphics.newImage('flags/Europe.png')
  flags['USA'] = love.graphics.newImage('flags/USA.png')
  flags['Fr'] = love.graphics.newImage('flags/Fr.png')
  flags['Es'] = love.graphics.newImage('flags/Es.png')
  mark_games()
  flag_games()
end

function updateTabs()
  for i=1,#tabs do
    if i == ACTIVE_TAB then
      tab_width = ACTIVE_TAB_WIDTH
      tab_zoom = ACTIVE_TAB_ZOOM
      tab_y = ACTIVE_Y
      tab_x = ACTIVE_X
      tab_title_alpha = 255
    else
      tab_width = PASSIVE_TAB_WIDTH
      tab_zoom = PASSIVE_TAB_ZOOM
      tab_title_alpha = 0
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
    tween(0.2, tabs[i],  { title_alpha = tab_title_alpha }, 'outSine')
    tween(0.2, global,  { x = -ACTIVE_TAB*PASSIVE_TAB_WIDTH }, 'outSine')
  end

  for i=1,#games do
    tween(0.2, games[i],  { y = HIDDEN_GAME_Y }, 'outSine')
  end
  tween(0.2, cursor,  { y = HIDDEN_GAME_Y }, 'outSine')
end

function updateGames()
  for i=1,#games do
    if i == ACTIVE_GAME then
      next_y = ACTIVE_GAME_Y
      next_flag_alpha = 255
    elseif i < ACTIVE_GAME then
      next_y = BEFORE_GAME_Y
      next_flag_alpha = 0
    else
      next_y = AFTER_GAME_Y
      next_flag_alpha = 0
    end
    tween(0.15, games[i],  { y = -ACTIVE_GAME * 80 + next_y + (i - 1) * 80 }, 'outSine')
    tween(0.15, games[i],  { flag_alpha = next_flag_alpha }, 'outSine')
  end
  tween(0.15, cursor,  { y = ACTIVE_GAME_Y }, 'outSine')
end

function openTab()
  ACTIVE_GAME = 1
  for i=1,#tabs do
    if i == ACTIVE_TAB then
      next_width = ACTIVE_TAB_WIDTH*4
      next_zoom = ACTIVE_TAB_ZOOM
      next_y = ACTIVE_Y
      next_x = ACTIVE_X
    else
      next_width = 0
      next_zoom = 0
      if i < ACTIVE_TAB then
        next_y = BEFORE_Y
        next_x = BEFORE_X
      else
        next_y = AFTER_Y
        next_x = AFTER_X
      end
    end
    tween(0.2, tabs[i],  { width = next_width }, 'outSine')
    tween(0.2, tabs[i],  { zoom = next_zoom }, 'outSine')
    tween(0.2, tabs[i],  { y = next_y }, 'outSine')
    tween(0.2, tabs[i],  { x = next_x }, 'outSine')
    tween(0.2, global,  { x = -1300 }, 'outSine')
  end

  updateGames()
end

function love.update(dt)
  t = t + dt

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

  if OPEN and love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.15 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME + 1
    if ACTIVE_GAME > #games then
      ACTIVE_GAME = 1
    end

    updateGames()
  end

  if OPEN and love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.15 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME - 1
    if ACTIVE_GAME < 1 then
      ACTIVE_GAME = #games
    end

    updateGames()
  end

end

function draw_tabs()
  local stack_width = 285

  for i=1,#tabs do
    love.graphics.setColor(128, 128, 128, 255)

    if i > 1 then
      local function myStencilFunction()
        love.graphics.polygon("fill",
          global.x + stack_width+ANGLE, 0,
          global.x + stack_width+tabs[i].width+ANGLE, 0,
          global.x + stack_width+tabs[i].width, SCREEN_HEIGHT,
          global.x + stack_width, SCREEN_HEIGHT
        )
      end

      love.graphics.stencil(myStencilFunction, "replace", 1)
      love.graphics.setStencilTest("greater", 0)
      love.graphics.draw(tabs[i].bg, 0, 0, 0, 1920/1280, 1080/720)
      love.graphics.setStencilTest()
    end

    love.graphics.setColor(tabs[i].color)
    love.graphics.polygon("fill",
      global.x + stack_width+ANGLE, 0,
      global.x + stack_width+tabs[i].width+ANGLE, 0,
      global.x + stack_width+tabs[i].width, SCREEN_HEIGHT,
      global.x + stack_width, SCREEN_HEIGHT
    )

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.draw(tabs[i].icon,
      global.x + stack_width + tabs[i].width/2 + tabs[i].x, tabs[i].y,
      0, tabs[i].zoom, tabs[i].zoom,
      128, 128
    )

    love.graphics.setColor(255, 255, 255, tabs[i].title_alpha)

    love.graphics.setFont(font)
    love.graphics.printf(tabs[i].title,
      global.x + stack_width + tabs[i].x, tabs[i].y + 120,
      tabs[i].width, 'center'
    )

    love.graphics.setFont(smallfont)
    love.graphics.printf(tabs[i].subtitle,
      global.x + stack_width + tabs[i].x, tabs[i].y + 200,
      tabs[i].width, 'center'
    )

    stack_width = stack_width + tabs[i].width
  end
end

function draw_cursor()
  love.graphics.setColor(255, 255, 255)

  love.graphics.push()
  love.graphics.translate(208, cursor.y)
  love.graphics.rotate(t)
  love.graphics.rectangle('fill', -15, -15, 30, 30)
  love.graphics.pop()

  love.graphics.push()
  love.graphics.translate(208, cursor.y)
  love.graphics.rotate(t + math.pi/4)
  love.graphics.rectangle('fill', -15, -15, 30, 30)
  love.graphics.pop()
end

function draw_games()
  for i=1,#games do
    love.graphics.setFont(font)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(games[i].title, 300, games[i].y + 45)

    love.graphics.setColor(255, 255, 255, games[i].flag_alpha)
    local stack_width = 20
    local title_width = font:getWidth(games[i].title)
    for f=1,#games[i].flags do
      if flags[games[i].flags[f]] then
        love.graphics.draw(flags[games[i].flags[f]], 300 + title_width + stack_width, games[i].y + 58)
        stack_width = stack_width + 71
      end
    end

    if games[i].mark then
      love.graphics.setFont(smallfont)
      love.graphics.setColor(255, 255, 255, 128)
      love.graphics.print(games[i].mark, 200, games[i].y + 56)
    end
  end
end

function love.draw()
  draw_tabs()

  draw_cursor()

  draw_games()
end
