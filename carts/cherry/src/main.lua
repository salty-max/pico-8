function _init()
  frame = 0

  ship_x = 60
  ship_y = 112
  ship_vx = 0
  ship_vy = 0
  ship_spr = 2
  ship_flm = {32, 33, 34, 35 ,36}
  flm_idx = 1

  bul = {}
  bul_spd = 2
  bul_ct = 0

  debug = {}
end

function _update60()
  frame += 1
  move_ship()
  shoot()

  for b in all(bul) do
    if b.y < -7 then
      del(bul, b)
    end
    b.y -= bul_spd
  end

  flm_idx = 1 + flr((frame / 2) % #ship_flm)
end

function _draw()
  cls(0)
  
  for b in all(bul) do
    spr(16, b.x, b.y)
  end

  spr(ship_spr, ship_x, ship_y)
  spr(ship_flm[flm_idx], ship_x, ship_y + 7)

  cursor(4, 4)
  color(12)
  for d in all(debug) do
    print(d)
  end
end

function make_bullet(x, y)
  add(bul, {x = x, y = y})
end