-- bestiary indexes
-- 1: player
-- 2: slime

bestiary = {
  anim = { 240, 192 },
  atk = { 1, 1 },
  hp = { 5, 2 }
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
  add_mob(2, 1, 10)
  add_mob(2, 3, 11)
  add_mob(2, 7, 12)

  p_t = 0

  windows = {}
  float = {}
  dialog_box = nil
end

function _update60()
  t += 1
  _upd()
  do_floats()
end

function _draw()
  _drw()
  draw_windows()
end