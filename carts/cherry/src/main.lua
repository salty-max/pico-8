function _init()
  stars = {}
  make_starfield()

  _upd = update_menu
  _drw = draw_menu

  debug = {}
end

function start_game()
  a_t = 0

  ship_x = 60
  ship_y = 112
  ship_vx = 0
  ship_vy = 0
  ship_spr = 2
  ship_flm = {32, 33, 34, 35 ,36}
  flm_idx = 1

  muzzle = 0

  bul = {}
  bul_spd = 2

  

  score = 1337
  lives = 2

  _upd = update_game
  _drw = draw_game
end

function _update60()
  _upd()
end

function _draw()
  _drw()

  cursor(4, 4)
  color(12)
  for d in all(debug) do
    print(d)
  end
end