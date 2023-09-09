function _init()
  ship_x = 60
  ship_y = 112
  ship_vx = 0
  ship_vy = 0

  bul = {}
  bul_spd = 2
  bul_ct = 0

  debug = {}
end

function _update60()
  move_ship()
  shoot()

  for b in all(bul) do
    if b.y < -7 then
      del(bul, b)
    end
    b.y -= bul_spd
  end
end

function _draw()
  cls(0)
  
  for b in all(bul) do
    spr(48, b.x, b.y)
  end

  spr(1, ship_x, ship_y)

  cursor(4, 4)
  color(12)
  for d in all(debug) do
    print(d)
  end
end

function make_bullet(x, y)
  add(bul, {x = x, y = y})
end