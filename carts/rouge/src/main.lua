-- bestiary indexes
-- 1: player, 240, 1 ,5, 4
-- 2: slime, 192, 1, 2, 4

bestiary = {
  name = { "player", "slime" },
  anim = { 240, 192 }, -- first frame of animation
  atk = { 1, 1 }, -- attack power
  def = { 0, 0 }, -- defense rating
  hp = { 5, 2 }, -- health
  los = { 4, 4 } -- line of sight
}

items = {
  name = { "iron sword", "leather armor", "sausage", "red potion", "kunai", "wooden stick" },
  kind = { "wep", "arm", "fud", "drk", "thr", "wep" },
  stat_1 = {2, 0, 1, 1, 2, 1},
  stat_2 = {0, 2, 2, 5, 0, 0},
}

function _init()
  t = 0
  d_pal = { 0, 1, 1, 2, 1, 13, 6, 4, 4, 9, 3, 13, 1, 13, 14 }
  -- fade palette
  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  crv_sig = { 0b11111111, 0b11010110, 0b01111100, 0b10110011, 0b11101001 }
  crv_msk = { 0b00000000, 0b00001001, 0b00000011, 0b00001100, 0b00000110 }

  debug = {}

  is_dyn_gen = true

  start_game()
end

function start_game()
  -- fade percentage (1 ==  fully opaque)
  fade_perc = 1
  -- buffer for inputs
  butt_buff = -1
  -- flag for skipping AI
  skip_ai = false
  -- array for living mobs
  -- this includes player
  mobs = {}
  -- array for dead mobs
  d_mobs = {}
  d_map = {}
  -- reference for the player mob
  player = add_mob(1, 1, 1)
  a_t = 0
  thr_dx, thr_dy = 1, 0
  inv, eqp = {}, {}

  -- map opacity grid
  fog = blank_map(0)
  
  windows = {}
  float = {}
  dialog_box = nil
  
  hp_box = add_window(5, 5, 28, 13, {})
  
  _upd = update_game
  _drw = draw_game

  win = false
  win_flr = 9
  
  gen_floor(0)
  unfog()
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
  if is_dyn_gen then
    fade_perc = 0
  else
    check_fade()
  end

  cursor(4, 4)
  color(12)
  for d in all(debug) do
    print(d)
  end
end