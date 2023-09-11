function move_ship()
  ship_vx = 0
  ship_vy = 0
  ship_spr = 2

  if btn(0) then
    ship_vx = -1
    ship_spr = 1
  elseif btn(1) then
    ship_vx = 1
    ship_spr = 3
  end
  
  if btn(2) then
    ship_vy = -1
  elseif btn(3) then
    ship_vy = 1
  end

  ship_x += ship_vx
  ship_y += ship_vy

  if ship_x < -7 then
    ship_x = 127
  elseif ship_x > 127 then
    ship_x = 0
  end

  if ship_y < -7 then
    ship_y = 127
  elseif ship_y > 127 then
    ship_y = 0
  end
end

function shoot()
  if btnp(4) then
    sfx(0)
    muzzle = 5
    make_bullet(ship_x, ship_y - 6)
  end
end

function make_bullet(x, y)
  add(bul, {
    x = x,
    y = y,
    spr = 1,
    anm = {16, 17}
  })
end