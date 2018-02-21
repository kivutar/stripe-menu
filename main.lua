tween = require "tween"
require "hsl"
require "global"
require "transitions"
require "flags"
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
    icon_alpha = 255,
    width = ACTIVE_TAB_WIDTH,
    x = ACTIVE_X,
    y = ACTIVE_Y,
    icon = love.graphics.newImage("icons/" .. THEME .. "/setting.png"),
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
        title = playlist:gsub("(.-) %- ", "", 1):gsub("Nintendo Entertainment System", "NES"),
        subtitle = "13 Games - 3 Favorites",
        title_alpha = 0,
        icon_alpha = 255,
        width = PASSIVE_TAB_WIDTH,
        x = AFTER_X,
        y = AFTER_Y,
        icon = love.graphics.newImage("icons/" .. THEME .. "/" .. playlist .. ".png"),
        bg = love.graphics.newImage("bg/" .. playlist .. ".png"),
        zoom = PASSIVE_TAB_ZOOM,
        children = {}
      }
      for line in lines:gmatch("[^\r\n]+") do
        table.insert(
          tab.children,
          {
            title = line,
            fullname = line
          }
        )
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
      if love.filesystem.exists("thumbnails/" .. tabs[h].fullname .. "/Named_Boxarts/" .. list[i].title .. ".png") then
        list[i].thumbnail =
          love.graphics.newImage("thumbnails/" .. tabs[h].fullname .. "/Named_Boxarts/" .. list[i].title .. ".png")
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

function love.load()
  font = love.graphics.newFont("font.ttf", 40)
  smallfont = love.graphics.newFont("font.ttf", 25)
  bool_on = love.graphics.newImage("icons/" .. THEME .. "/on.png")
  bool_off = love.graphics.newImage("icons/" .. THEME .. "/off.png")
  image_error = love.graphics.newImage("icons/" .. THEME .. "/image.png")
  load_playlists()
  color_tabs()
  init_gamelist()
  mark_games()
  load_flags()
  flag_games()
  love.graphics.setBackgroundColor(tabs[1].color)

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

  screen = Tabs
end

function love.update(dt)
  t = t + dt

  tween.update(dt)

  update_thumb()

  if screen.update then
    screen:update(dt)
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  if screen.keypressed then
    screen:keypressed(key)
  end
end

function love.draw()
  Tabs:draw()
  GameList:draw()
  GameDetails:draw()
  Settings:draw()
end
