THEME = "monochrome"

ANGLE = 400
ACTIVE_TAB = 1
ACTIVE_GAME = 1
t = 0
t1 = 0

PASSIVE_TAB_WIDTH = 128
ACTIVE_TAB_WIDTH = 1200

PASSIVE_TAB_ZOOM = 0.25
ACTIVE_TAB_ZOOM = 1

ACTIVE_Y = SCREEN_HEIGHT / 2
BEFORE_Y = 64
AFTER_Y = SCREEN_HEIGHT - 64

ACTIVE_X = ANGLE / 2
BEFORE_X = ANGLE - 22
AFTER_X = 22

ACTIVE_GAME_Y = SCREEN_HEIGHT / 2
BEFORE_GAME_Y = SCREEN_HEIGHT / 2 - 140
AFTER_GAME_Y = SCREEN_HEIGHT / 2 + 140

tabs_container = {
  x = -ACTIVE_TAB * PASSIVE_TAB_WIDTH
}

gamelist_container = {
  y = SCREEN_HEIGHT / 2 + 100
}

gamedetails_container = {
  y = SCREEN_HEIGHT
}

settings_container = {
  y = SCREEN_HEIGHT
}

cursor = {
  width = 0,
  alpha = 255
}
