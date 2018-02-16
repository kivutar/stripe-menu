settings = {
  {
    title = "Video Settings",
    children = {
      { title = "Display Framerate", type = "bool", value = false },
      { title = "Fullscreen", type = "bool", value = false },
      { title = "Threaded Video", type = "bool", value = true },
      { title = "Aspect Ratio", type = "list", value = 1, options = { "4:3", "16:9", "Core provided" } }
    }
  },
  {
    title = "Audio Settings",
    children = {
      { title = "Mute", type = "bool", value = false },
      { title = "Audio Volume", type = "int", min=0, max=100, step=10, value = 50 },
      { title = "Audio Device", type = "list", value = 1, options = { "HDMI", "Jack" } }
    }
  },
  {title = "Input Settings"},
  {title = "Menu Settings"},
  {title = "Retro Achievements"},
  {title = "Network Connection"}
}