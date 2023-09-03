-- bestiary indexes
-- 1: player, 240, 1 ,5, 4
-- 2: slime, 192, 1, 2, 4

bestiary = {
  name = split("player,slime"),
  anim = split("240, 192"), -- first frame of animation
  atk = split("1, 1"), -- attack power
  def = split("0, 0"), -- defense rating
  hp = split("5, 2"), -- health
  los = split("4, 4") -- line of sight
}

items = {
  name = split("iron sword,leather armor,sausage,red potion,kunai,wooden stick"),
  kind = split("wep,arm,fud,drk,thr,wep"),
  stat_1 = split("2, 0, 1, 1, 2, 1"),
  stat_2 = split("0, 2, 2, 5, 0, 0"),
}

function _init()
  t = 0
  d_pal = split("0, 1, 1, 2, 1, 13, 6, 4, 4, 9, 3, 13, 1, 13, 14")
  -- fade palette
  dir_x = split("-1, 1, 0, 0, 1, 1, -1, -1")
  dir_y = split("0, 0, -1, 1, -1, 1, 1, -1")

  crv_sig = split("255, 214, 124, 179, 233")
  crv_msk = split("0, 9, 3, 12, 6")

  wall_sig=split("251,233,253,84,146,80,16,144,112,208,241,248,210,177,225,120,179,0,124,104,161,64,240,128,224,176,242,244,116,232,178,212,247,214,254,192,48,96,32,160,245,250,243,249,246,252")
  wall_msk=split("0,6,0,11,13,11,15,13,3,9,0,0,9,12,6,3,12,15,3,7,14,15,0,15,6,12,0,0,3,6,12,9,0,9,0,15,15,7,15,14,0,0,0,0,0,0")



  debug = {}

  is_dyn_gen = false

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
  
  windows = {}
  float = {}
  dialog_box = nil
  
  hp_box = add_window(5, 5, 28, 13, {})
  
  _upd = update_game
  _drw = draw_game

  win = false
  win_flr = 9
  
  gen_floor(0)
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