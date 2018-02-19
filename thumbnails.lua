threads = {}

-- Thumbnail thread code. Downloads an image with Lua Socket
-- and write it to the filesystem
thumbThread =
  [[
    local thumbdir, thumbpath, thumburl = ...
    local http = require("socket.http")
    local body, code, header = http.request(thumburl)
    if code == 200 then
      love.filesystem.createDirectory(thumbdir)
      love.filesystem.write(thumbpath, body)
    end
    love.thread.getChannel(thumbpath):push(code)
  ]]

-- If the thumbnail doesn't exist in the filesystem, spawn a thread to download it
function download_thumb(tabid, gameid)
  local thumbdir = "thumbnails/" .. tabs[tabid].fullname .. "/Named_Boxarts"
  local thumbpath = thumbdir .. "/" .. tabs[tabid].children[gameid].fullname .. ".png"
  local thumburl =
    "http://thumbnails.libretro.com/" ..
    tabs[tabid].fullname .. "/Named_Boxarts/" .. tabs[tabid].children[gameid].fullname .. ".png"
  if not love.filesystem.exists(thumbpath) then
    local thread = {
      tabid = tabid,
      gameid = gameid,
      thread = love.thread.newThread(thumbThread),
      path = thumbpath
    }
    table.insert(threads, thread)
    thread.thread:start(thumbdir, thumbpath, thumburl)
  end
end

-- Called one time per frame. Pops the channel to check when a thread is done
-- and loads to image in our state
function update_thumb()
  if #threads then
    for i = 1, #threads do
      local thread = threads[i]
      local error = thread.thread:getError()
      if error then print(error) end
      local code = love.thread.getChannel(thread.path):pop()

      if code then
        if code == 200 then
          tabs[thread.tabid].children[thread.gameid].thumbnail = love.graphics.newImage(thread.path)
        else
          tabs[thread.tabid].children[thread.gameid].thumbnail = image_error
        end
        table.remove(threads, i)
      end
    end
  end
end
