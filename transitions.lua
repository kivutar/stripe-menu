function animateTabs()
  for i = 1, #tabs do
    if i == ACTIVE_TAB then
      next_width = ACTIVE_TAB_WIDTH
      next_zoom = ACTIVE_TAB_ZOOM
      next_y = ACTIVE_Y
      next_x = ACTIVE_X
      next_title_alpha = 255
    else
      next_width = PASSIVE_TAB_WIDTH
      next_zoom = PASSIVE_TAB_ZOOM
      next_title_alpha = 0
      if i < ACTIVE_TAB then
        next_y = BEFORE_Y
        next_x = BEFORE_X
      else
        next_y = AFTER_Y
        next_x = AFTER_X
      end
    end
    tween(0.2, tabs[i], {width = next_width}, "outSine")
    tween(0.2, tabs[i], {zoom = next_zoom}, "outSine")
    tween(0.2, tabs[i], {y = next_y}, "outSine")
    tween(0.2, tabs[i], {x = next_x}, "outSine")
    tween(0.2, tabs[i], {title_alpha = next_title_alpha}, "outSine")
  end

  tween(0.2, tabs_container, {x = -ACTIVE_TAB * PASSIVE_TAB_WIDTH}, "outSine")
  tween(0.2, gamelist_container, {y = SCREEN_HEIGHT / 2 + 100}, "outSine")
  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    tween(0.2, list[i], {alpha = 0, mark_alpha = 0, flag_alpha = 0}, "outSine")
  end
  ACTIVE_GAME = 1
end

function animateGameList()
  local list = tabs[ACTIVE_TAB].children
  local first = math.max(1, ACTIVE_GAME - 5)
  local last = math.min(#list, ACTIVE_GAME + 5) 
  for i = first, last do
    if i == ACTIVE_GAME then
      next_y = ACTIVE_GAME_Y
      next_flag_alpha = 255
    elseif i < ACTIVE_GAME then
      next_y = BEFORE_GAME_Y
      next_flag_alpha = 0
    else
      next_y = AFTER_GAME_Y
      next_flag_alpha = 0
    end
    tween(0.15, list[i], {y = -ACTIVE_GAME * 80 + next_y + (i - 1) * 80}, "outSine")
    tween(0.15, list[i], {alpha = 255}, "outSine")
    tween(0.15, list[i], {flag_alpha = next_flag_alpha}, "outSine")
    tween(0.15, list[i], {mark_alpha = 128}, "outSine")
  end

  local new_width = font:getWidth(list[ACTIVE_GAME].title) + 170
  new_width = new_width + 71 * #list[ACTIVE_GAME].flags
  tween(0.15, cursor, {width = new_width}, "outSine")
  tween(0.15, gamelist_container, {y = 0}, "outSine")
end

function tabsToGameList()
  ACTIVE_GAME = 1
  for i = 1, #tabs do
    if i == ACTIVE_TAB then
      next_width = ACTIVE_TAB_WIDTH * 4
      next_zoom = ACTIVE_TAB_ZOOM
      next_y = ACTIVE_Y
      next_x = ACTIVE_X
    else
      next_width = 0
      next_zoom = 0
      if i < ACTIVE_TAB then
        next_y = BEFORE_Y
        next_x = BEFORE_X
      else
        next_y = AFTER_Y
        next_x = AFTER_X
      end
    end
    tween(0.2, tabs[i], {width = next_width}, "outSine")
    tween(0.2, tabs[i], {zoom = next_zoom}, "outSine")
    tween(0.2, tabs[i], {y = next_y}, "outSine")
    tween(0.2, tabs[i], {x = next_x}, "outSine")
    tween(0.2, tabs_container, {x = -1300}, "outSine")
  end
  init_gamelist()
  animateGameList()
end

function gamelistToGamedetails()
  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    if i ~= ACTIVE_GAME then
      tween(0.2, list[i], {alpha = 0}, "outSine")
    end
    tween(0.2, list[i], {mark_alpha = 0}, "outSine")
  end

  tween(0.2, tabs[ACTIVE_TAB], {y = 80, zoom = 0.25, title_alpha = 0}, "outSine")
  tween(0.2, cursor, {alpha = 0}, "outSine")
  tween(0.2, gamelist_container, {y = -SCREEN_HEIGHT / 2 + 75}, "outSine")
  tween(0.2, gamedetails_container, {y = 150}, "outSine", download_thumb)
end

function gamelistToSettings()
  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    if i ~= ACTIVE_GAME then
      tween(0.2, list[i], {alpha = 0}, "outSine")
    end
    tween(0.2, list[i], {mark_alpha = 0}, "outSine")
  end

  tween(0.2, tabs[ACTIVE_TAB], {y = 80, zoom = 0.25, title_alpha = 0}, "outSine")
  tween(0.2, cursor, {alpha = 0}, "outSine")
  tween(0.2, gamelist_container, {y = -SCREEN_HEIGHT / 2 + 75}, "outSine")
  tween(0.2, settings_container, {y = 150}, "outSine")
end

function gamedetailsToGamelist()
  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    tween(0.2, list[i], {alpha = 255}, "outSine")
    tween(0.2, list[i], {mark_alpha = 128}, "outSine")
  end

  tween(0.2, tabs[ACTIVE_TAB], {y = ACTIVE_Y, zoom = ACTIVE_TAB_ZOOM}, "outSine")
  tween(0.2, tabs[ACTIVE_TAB], {title_alpha = 255}, "outSine")
  tween(0.2, cursor, {alpha = 255}, "outSine")
  tween(0.2, gamedetails_container, {y = SCREEN_HEIGHT}, "outSine")

  animateGameList()
end

function settingsToGamelist()
  local list = tabs[ACTIVE_TAB].children
  for i = 1, #list do
    tween(0.2, list[i], {alpha = 255}, "outSine")
    tween(0.2, list[i], {mark_alpha = 128}, "outSine")
  end

  tween(0.2, tabs[ACTIVE_TAB], {y = ACTIVE_Y, zoom = ACTIVE_TAB_ZOOM}, "outSine")
  tween(0.2, tabs[ACTIVE_TAB], {title_alpha = 255}, "outSine")
  tween(0.2, cursor, {alpha = 255}, "outSine")
  tween(0.2, settings_container, {y = SCREEN_HEIGHT}, "outSine")

  animateGameList()
end