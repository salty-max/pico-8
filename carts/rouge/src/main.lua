mobs_anim = {
  240,
  192
}

function _init()
  t = 0

  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  _upd = update_game
  _drw = draw_game

  start_game()
end

function start_game()
  butt_buff = -1
  mobs = {}

  -- player
  p = add_mob(1, 1, 1)

  add_mob(2, 2, 3)

  p_t = 0

  windows = {}
  dialog_box = nil
end

function _update60()
  t += 1
  _upd()
end

function _draw()
  _drw()
  draw_windows()
end