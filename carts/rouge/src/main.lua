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
  d_pal = { 0, 1, 1, 2, 1, 13, 6, 4, 4, 9, 3, 13, 1, 13, 14 }
  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  debug = {}

  start_game()
end

function start_game()
  fade_perc = 1
  -- buffer for inputs
  butt_buff = -1
  -- array for living mobs
  -- this includes player
  mobs = {}
  -- array for dead mobs
  d_mobs = {}
  -- reference for the player mob
  player = add_mob(1, 1, 1)

  for y = 0, 15 do
    for x = 0, 15 do
      if mget(x, y) == 3 then
        add_mob(2, x, y)
      end
    end
  end

  p_t = 0

  windows = {}
  float = {}
  dialog_box = nil

  hp_box = add_window(5, 5, 28, 13, {})

  _upd = update_game
  _drw = draw_game
end

function _update60()
  t += 1
  _upd()
  do_floats()
end

function _draw()
  _drw()
  draw_windows()
  handle_hp_box()
  check_fade()
  cursor(4, 4)
  color(8)
  for d in all(debug) do
    print(d)
  end
end