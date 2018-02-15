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