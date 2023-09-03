function start_end()
  local high, low, px, py, ex, ey = 0, 999
  
  repeat
    px, py = flr(rnd(16)), flr(rnd(16))
  until is_walkable(px, py)

  calc_dist(px, py)
  
  for x = 0, 15 do
    for y = 0, 15 do
      local tmp = d_map[x][y]
      if is_walkable(x, y) and tmp > high then
        px, py = x, y
        high = tmp
      end
    end
  end

  calc_dist(px, py)
  high = 0
  for x = 0, 15 do
    for y = 0, 15 do
      local tmp = d_map[x][y]
      if tmp > high and can_carve(x, y) then
        ex, ey, high = x, y, tmp
      end
    end
  end

  mset(ex, ey, 14)
  snapshot()

  for x = 0, 15 do
    for y = 0, 15 do
      local tmp = d_map[x][y]
      if tmp > 0 and tmp < low and can_carve(x, y) then
        px, py, low = x, y, tmp
      end
    end
  end


  mset(px, py, 15)
  player.x, player.y = px, py
  snapshot()
end

function place_doors()
  for d in all(doors) do
    if mget(d.x, d.y) == 1 and is_walkable(d.x, d.y) and is_door(d.x, d.y) then
      mset(d.x, d.y, 13)
      snapshot()
    end
  end
end