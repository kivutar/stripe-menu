flags = {}

function load_flags()
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