tween = require "tween"
require "hsl"
require "global"
require "transitions"
require "settings"
require "thumbnails"
require "screens/tabs"
require "screens/settings"
require "screens/gamedetails"
require "screens/gamelist"

math.randomseed(os.time())

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
  }
}

function load_playlists()
  local playlists = love.filesystem.getDirectoryItems("playlists")
  for k, playlist in ipairs(playlists) do
    if not playlist:find(".", 1, true) then
      lines, size = love.filesystem.read("playlists/" .. playlist)
      local tab = {
        fullname = playlist,
        title = playlist,
        subtitle = "13 Games - 3 Favorites",
        title_alpha = 0,
        width = PASSIVE_TAB_WIDTH,
        x = AFTER_X,
        y = AFTER_Y,
        icon = love.graphics.newImage("icons/"..THEME.."/"..playlist..".png"),
        zoom = PASSIVE_TAB_ZOOM,
        children = {}
      }
      for line in lines:gmatch("[^\r\n]+") do
        table.insert(tab.children, {
          title = line,
          fullname = line
        })
      end
      table.insert(tabs, tab)
    end
  end
end

function color_tabs()
  for i = 1, #tabs do
    tabs[i].color = {HSL((i - 1) * 20 % 256, 128, 128, 140)}
    --tabs[i].color = {HSL(160, 30, ((i - 1) % 2) * 15 + 30, 140)}
  end
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
  flags["It"] = love.graphics.newImage("flags/It.png")
  flags["Pt"] = love.graphics.newImage("flags/Pt.png")
  flags["Nl"] = love.graphics.newImage("flags/Nl.png")
  flags["Ja"] = love.graphics.newImage("flags/Ja.png")
  flags["Sv"] = love.graphics.newImage("flags/Sv.png")
  flags["No"] = love.graphics.newImage("flags/No.png")
  flags["World"] = love.graphics.newImage("flags/World.png")
  flags["Brazil"] = love.graphics.newImage("flags/Brazil.png")
  flags["France"] = love.graphics.newImage("flags/France.png")
  flags["Korea"] = love.graphics.newImage("flags/Korea.png")
  flags["Taiwan"] = love.graphics.newImage("flags/Taiwan.png")
  bool_on = love.graphics.newImage("icons/"..THEME.."/on.png")
  bool_off = love.graphics.newImage("icons/"..THEME.."/off.png")
  load_playlists()
  color_tabs()
  love.graphics.setBackgroundColor(tabs[1].color)
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

local thread

function love.update(dt)
  t = t + dt

  tween.update(dt)

  update_thumb()

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
      gamelistToGamedetails()
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

function love.draw()
  draw_tabs()
  draw_gamelist()
  draw_gamedetails()
  draw_settings()
end
