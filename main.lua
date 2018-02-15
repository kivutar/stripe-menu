tween = require "tween"
require "hsl"
require "global"
require "transitions"

math.randomseed(os.time())

settings = {
  {
    title = "Video Settings",
    children = {
      { title = "Display Framerate", type = "bool" },
      { title = "Fullscreen", type = "bool" },
      { title = "Threaded Video", type = "bool" },
      { title = "Aspect Ratio", type = "list" }
    }
  },
  {
    title = "Audio Settings",
    children = {
      { title = "Mute", type = "bool" },
      { title = "Audio Volume", type = "int", min=0, max=100, step=10 },
      { title = "Audio Device", type = "list" }
    }
  },
  {title = "Input Settings"},
  {title = "Menu Settings"},
  {title = "Retro Achievements"},
  {title = "Network Connection"}
}

THEME = "monochrome"

tabs = {
  {
    fullname = "Settings",
    title = "Settings",
    subtitle = "Configure Lakka",
    title_alpha = 255,
    width = ACTIVE_TAB_WIDTH,
    x = ACTIVE_X,
    y = ACTIVE_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/setting.png"),
    zoom = ACTIVE_TAB_ZOOM,
    children = settings
  },
  {
    fullname = "Nintendo - Game Boy",
    bg = love.graphics.newImage("bg/Nintendo - Game Boy.png"),
    title = "Game Boy",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Nintendo - Game Boy.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title = "Aa Harimanada (Japan)"},
      {title = "Addams Family, The - Pugsley's Scavenger Hunt (USA, Europe)"},
      {title = "Addams Family, The (Europe) (En,Fr,De)"},
      {title = "Addams Family, The (Japan)"},
      {title = "Addams Family, The (USA)"},
      {title = "Adventure Island (USA, Europe)"},
      {title = "Adventure Island II - Aliens in Paradise (USA, Europe)"},
      {title = "Adventures of Pinocchio, The (Unknown) (Proto)"},
      {title = "Adventures of Rocky and Bullwinkle and Friends, The (USA)"},
      {title = "Adventures of Star Saver, The (USA, Europe)"},
      {title = "Aero Star (Japan)"},
      {title = "Aerostar (USA, Europe)"},
      {title = "After Burst (Japan)"},
      {title = "Agro Soar (Australia)"},
      {title = "Akumajou Special - Boku Dracula-kun (Japan)"},
      {title = "Alfred Chicken (Europe)"},
      {title = "Alfred Chicken (USA)"},
      {title = "Alien 3 (Japan)"},
      {title = "Alien 3 (USA, Europe)"},
      {title = "Alien Olympics (Europe)"},
      {title = "Alien vs Predator - The Last of His Clan (USA)"}
    }
  },
  {
    fullname = "Nintendo - Game Boy Advance",
    bg = love.graphics.newImage("bg/Nintendo - Game Boy Advance.png"),
    title = "Game Boy Advance",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Nintendo - Game Boy Advance.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title = "After Burner Complete (Europe)"},
      {title = "After Burner Complete ~ After Burner (Japan, USA)"},
      {title = "Amazing Spider-Man, The - Web of Fire (USA)"},
      {title = "BC Racers (USA)"},
      {title = "Blackthorne (USA)"},
      {title = "Brutal Unleashed - Above the Claw (USA)"},
      {title = "Chaotix ~ Knuckles' Chaotix (Japan, USA)"},
      {title = "Cosmic Carnage (Europe)"},
      {title = "Cyber Brawl ~ Cosmic Carnage (Japan, USA)"},
      {title = "Darxide (Europe) (En,Fr,De,Es)"},
      {title = "Doom (Europe)"},
      {title = "Doom (Japan, USA)"}
    }
  },
  {
    fullname = "Nintendo - Super Nintendo Entertainment System",
    bg = love.graphics.newImage("bg/Nintendo - Super Nintendo Entertainment System.png"),
    title = "Super Nintendo",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Nintendo - Super Nintendo Entertainment System.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title = "Breath of Fire - Ryuu no Senshi (Japan)"},
      {title = "Dragon Ball Z - Hyper Dimension (Japan)"},
      {title = "Legend of Zelda, The - A Link to the Past (Europe)"},
      {title = "Lethal Weapon (Europe)"},
      {title = "Secret of Mana (France)"},
      {title = "Shin Megami Tensei II (Japan)"}
    }
  },
  {
    fullname = "Nintendo - Nintendo 64",
    bg = love.graphics.newImage("bg/Nintendo - Nintendo 64.png"),
    title = "Nintendo 64",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Nintendo - Nintendo 64.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title="No game"}
    }
  },
  {
    fullname = "Sega - 32X",
    bg = love.graphics.newImage("bg/Sega - 32X.png"),
    title = "32X",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Sega - 32X.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title = "After Burner Complete (Europe)"},
      {title = "After Burner Complete ~ After Burner (Japan, USA)"},
      {title = "Amazing Spider-Man, The - Web of Fire (USA)"},
      {title = "BC Racers (USA)"},
      {title = "Blackthorne (USA)"},
      {title = "Brutal Unleashed - Above the Claw (USA)"},
      {title = "Chaotix ~ Knuckles' Chaotix (Japan, USA)"},
      {title = "Cosmic Carnage (Europe)"},
      {title = "Cyber Brawl ~ Cosmic Carnage (Japan, USA)"},
      {title = "Darxide (Europe) (En,Fr,De,Es)"},
      {title = "Doom (Europe)"},
      {title = "Doom (Japan, USA)"}
    }
  },
  {
    fullname = "Sony - PlayStation",
    bg = love.graphics.newImage("bg/Sony - PlayStation.png"),
    title = "PlayStation",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Sony - PlayStation.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title="No game"}
    }
  },
  {
    fullname = "Sony - PlayStation 2",
    bg = love.graphics.newImage("bg/Sony - PlayStation 2.png"),
    title = "PlayStation 2",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Sony - PlayStation 2.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title="No game"}
    }
  },
  {
    fullname = "The 3DO Company - 3DO",
    bg = love.graphics.newImage("bg/The 3DO Company - 3DO.png"),
    title = "3DO",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/The 3DO Company - 3DO.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title="No game"}
    }
  },
  {
    fullname = "Sega - Saturn",
    bg = love.graphics.newImage("bg/Sega - Saturn.png"),
    title = "Saturn",
    subtitle = "13 Games - 3 Favorites",
    title_alpha = 0,
    width = PASSIVE_TAB_WIDTH,
    x = AFTER_X,
    y = AFTER_Y,
    icon = love.graphics.newImage("icons/"..THEME.."/Sega - Saturn.png"),
    zoom = PASSIVE_TAB_ZOOM,
    children = {
      {title="No game"}
    }
  }
}

for i = 1, #tabs do
  tabs[i].color = {HSL((i - 1) * 20 % 256, 128, 128, 140)}
  --tabs[i].color = {HSL(160, 30, ((i - 1) % 2) * 15 + 30, 140)}
end

-- init games y
function init_gamelist()
  for h = 1, #tabs do
    local list = tabs[h].children
    for i = 1, #list do
      if i == ACTIVE_GAME then
        next_y = ACTIVE_GAME_Y
      elseif i < ACTIVE_GAME then
        next_y = BEFORE_GAME_Y
      else
        next_y = AFTER_GAME_Y
      end
      list[i].y = -ACTIVE_GAME * 80 + next_y + (i - 1) * 80
      list[i].alpha = 0
      if love.filesystem.exists("thumbnails/"..tabs[h].fullname.."/Named_Boxarts/"..list[i].title..".png") then
        list[i].thumbnail = love.graphics.newImage("thumbnails/"..tabs[h].fullname.."/Named_Boxarts/"..list[i].title..".png")
      end
    end
  end
end

function mark_games()
  for h = 1, #tabs do
    local list = tabs[h].children
    mark = ""
    for i = 1, #list do
      list[i].mark_alpha = 128
      first = string.sub(list[i].title, 1, 1)
      if first ~= mark then
        mark = first
        list[i].mark = mark
      end
    end
  end
end

function flag_games()
  for h = 1, #tabs do
    local list = tabs[h].children
    for i = 1, #list do
      list[i].flags = {}
      for capture in list[i].title:gmatch("%s%((.-)%)") do
        for word in capture:gmatch("([^, ]+)") do
          table.insert(list[i].flags, word)
        end
      end
      list[i].title = list[i].title:gsub("%s%((.-)%)", "")
      list[i].flag_alpha = 0
    end
  end
end

function love.load()
  love.graphics.setBackgroundColor(tabs[1].color)
  font = love.graphics.newFont("font.ttf", 40)
  smallfont = love.graphics.newFont("font.ttf", 25)
  flags = {}
  flags["Japan"] = love.graphics.newImage("flags/Japan.png")
  flags["Europe"] = love.graphics.newImage("flags/Europe.png")
  flags["USA"] = love.graphics.newImage("flags/USA.png")
  flags["Fr"] = love.graphics.newImage("flags/Fr.png")
  flags["Es"] = love.graphics.newImage("flags/Es.png")
  flags["En"] = love.graphics.newImage("flags/En.png")
  flags["De"] = love.graphics.newImage("flags/De.png")
  flags["France"] = love.graphics.newImage("flags/France.png")
  init_gamelist()
  mark_games()
  flag_games()

  greyscale =
    love.graphics.newShader [[
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      number average = (pixel.r+pixel.b+pixel.g)/3.0;
      pixel.r = average;
      pixel.g = average;
      pixel.b = average;
      return pixel;
    }
  ]]
end

function love.update(dt)
  t = t + dt

  tween.update(dt)

  if SCREEN == SCREEN_TABS and love.keyboard.isDown("right") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB + 1
    if ACTIVE_TAB > #tabs then
      ACTIVE_TAB = 1
    end

    animateTabs()
  end

  if SCREEN == SCREEN_TABS and love.keyboard.isDown("left") and love.timer.getTime() > t1 + 0.25 then
    t1 = love.timer.getTime()
    ACTIVE_TAB = ACTIVE_TAB - 1
    if ACTIVE_TAB < 1 then
      ACTIVE_TAB = #tabs
    end

    animateTabs()
  end

  if SCREEN == SCREEN_GAMELIST and love.keyboard.isDown("down") and love.timer.getTime() > t1 + 0.15 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME + 1
    if ACTIVE_GAME > #tabs[ACTIVE_TAB].children then
      ACTIVE_GAME = 1
    end

    animateGameList()
  end

  if SCREEN == SCREEN_GAMELIST and love.keyboard.isDown("up") and love.timer.getTime() > t1 + 0.15 then
    t1 = love.timer.getTime()
    ACTIVE_GAME = ACTIVE_GAME - 1
    if ACTIVE_GAME < 1 then
      ACTIVE_GAME = #tabs[ACTIVE_TAB].children
    end

    animateGameList()
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "return" and SCREEN == SCREEN_TABS then
    tabsToGameList()
    SCREEN = SCREEN_GAMELIST
  elseif key == "return" and SCREEN == SCREEN_GAMELIST then
    if tabs[ACTIVE_TAB].title == "Settings" then
      gamelistToSettings()
      SCREEN = SCREEN_SETTINGS
    else
      gamelistToGame()
      SCREEN = SCREEN_GAMEDETAILS
    end
  elseif key == "backspace" and SCREEN == SCREEN_GAMELIST then
    animateTabs()
    SCREEN = SCREEN_TABS
  elseif key == "backspace" and SCREEN == SCREEN_GAMEDETAILS then
    gamedetailsToGamelist()
    SCREEN = SCREEN_GAMELIST
  elseif key == "backspace" and SCREEN == SCREEN_SETTINGS then
    settingsToGamelist()
    SCREEN = SCREEN_GAMELIST
  end
end

function draw_tabs()
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

function love.draw()
  draw_tabs()
  draw_gamelist()
  draw_gamedetails()
  draw_settings()
end
