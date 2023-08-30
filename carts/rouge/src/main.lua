-- bestiary indexes
-- 1: player
-- 2: slime

bestiary = {
  anim = { 240, 192 }, -- first frame of animation
  atk = { 1, 1 }, -- attack power
  hp = { 5, 2 }, -- health
  los = { 4, 4 } -- line of sight
}

function _init()
  t = 0
  d_pal = { 0, 1, 1, 2, 1, 13, 6, 4, 4, 9, 3, 13, 1, 13, 14 }
  -- fade palette
  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  debug = {}

  start_game()
end

function start_game()
  -- fade percentage (1 ==  fully opaque)
  fade_perc = 1
  -- buffer for inputs
  butt_buff = -1
  -- array for living mobs
  -- this includes player
  mobs = {}
  -- array for dead mobs
  d_mobs = {}
  d_map = {}
  -- reference for the player mob
  player = add_mob(1, 1, 1)

  for y = 0, 15 do
    for x = 0, 15 do
      if mget(x, y) == 192 then
        add_mob(2, x, y)
        mset(x, y, 1)
      end
    end
  end

  a_t = 0

  -- map opacity grid
  fog = blank_map(0)

  windows = {}
  float = {}
  dialog_box = nil

  hp_box = add_window(5, 5, 28, 13, {})

  _upd = update_game
  _drw = draw_game

  unfog()
  -- calc_dist(player.x, player.y)
end

function _update60()
  t += 1
  _upd()
  do_floats()
  handle_hp_box()
end

function _draw()
  _drw()
  draw_windows()
  check_fade()

  cursor(4, 4)
  color(8)
  for d in all(debug) do
    print(d)
  end
end