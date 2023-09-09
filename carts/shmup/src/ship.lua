function move_ship()
  ship_vx = 0
  ship_vy = 0

  if btn(0) then
    ship_vx = -1
  elseif btn(1) then
    ship_vx = 1
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
    bul_ct += 1
    sfx(0)
    local bx = bul_ct % 2 == 0 and ship_x - 4 or ship_x + 4
    make_bullet(bx, ship_y - 4)
  end
end