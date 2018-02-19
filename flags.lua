flags = {}

function load_flags()
  local images = love.filesystem.getDirectoryItems("flags")
  for k, image in ipairs(images) do
    name = image:match("^(.+).png$")
    if name then
      flags[name] = love.graphics.newImage("flags/"..image)
    end
  end
end

-- Loop over all the games, and build an array of country flags for each game
function flag_games()
  for h = 1, #tabs do
    local list = tabs[h].children
    for i = 1, #list do
      list[i].flags = {}
      -- capture content of parenthesis
      for capture in list[i].title:gmatch("%s%((.-)%)") do
        -- split on comma
        for word in capture:gmatch("([^, ]+)") do
          table.insert(list[i].flags, word)
        end
      end
      -- remove the parenthesis from the game title
      list[i].title = list[i].title:gsub("%s%((.-)%)", "")
      list[i].flag_alpha = 0
    end
  end
end