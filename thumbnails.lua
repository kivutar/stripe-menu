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
function download_thumb()
  local thumbdir = "thumbnails/" .. tabs[ACTIVE_TAB].fullname .. "/Named_Boxarts"
  local thumbpath = thumbdir .. "/" .. tabs[ACTIVE_TAB].children[ACTIVE_GAME].fullname .. ".png"
  local thumburl =
    "http://thumbnails.libretro.com/" ..
    tabs[ACTIVE_TAB].fullname .. "/Named_Boxarts/" .. tabs[ACTIVE_TAB].children[ACTIVE_GAME].fullname .. ".png"
  if not love.filesystem.exists(thumbpath) then
    print("new")
    local thread = {
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
          tabs[ACTIVE_TAB].children[ACTIVE_GAME].thumbnail = love.graphics.newImage(thread.path)
        else
          tabs[ACTIVE_TAB].children[ACTIVE_GAME].thumbnail = image_error
        end
        table.remove(threads, i)
      end
    end
  end
end
