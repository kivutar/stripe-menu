-- Thumbnail thread code. Downloads an image with Lua Socket
-- and write it to the filesystem
thumbThread =
  [[
  local thumbdir, thumbpath, thumburl = ...
  local http = require("socket.http")
  local b, c, h = http.request(thumburl)
  if c == 200 then
    love.filesystem.createDirectory(thumbdir)
    love.filesystem.write(thumbpath, b)
    love.thread.getChannel('thumb'):push(thumbpath)
  end
]]

-- If the thumbnail doesn't exist in the filesystem, spawn a thread to download it
function download_thumb()
  local thumbdir = "thumbnails/" .. tabs[ACTIVE_TAB].fullname .. "/Named_Boxarts"
  local thumbpath = thumbdir .. "/" .. tabs[ACTIVE_TAB].children[ACTIVE_GAME].fullname .. ".png"
  local thumburl =
    "http://thumbnails.libretro.com/" ..
    tabs[ACTIVE_TAB].fullname .. "/Named_Boxarts/" .. tabs[ACTIVE_TAB].children[ACTIVE_GAME].fullname .. ".png"
  if not love.filesystem.exists(thumbpath) then
    thread = love.thread.newThread(thumbThread)
    thread:start(thumbdir, thumbpath, thumburl)
  end
end

-- Called one time per frame. Pops the channel to check when a thread is done
-- and loads to image in our state
function update_thumb()
  if thread then
    local error = thread:getError()
    assert(not error, error)
    local thumbpath = love.thread.getChannel("thumb"):pop()
    if thumbpath then
      tabs[ACTIVE_TAB].children[ACTIVE_GAME].thumbnail = love.graphics.newImage(thumbpath)
    end
  end
end
