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

  mset(ex, ey, 72)
  snapshot()

  for x = 0, 15 do
    for y = 0, 15 do
      local tmp = d_map[x][y]
      if tmp > 0 and tmp < low and can_carve(x, y) then
        px, py, low = x, y, tmp
      end
    end
  end


  mset(px, py, 73)
  player.x, player.y = px, py
  snapshot()
end

function place_doors()
  for d in all(doors) do
    local tle = mget(d.x, d.y)
    if (tle == 1 or tle == 4 or tle == 5 or tle == 6 or tle == 7) and is_walkable(d.x, d.y) and is_door(d.x, d.y) and not is_next_to_tile(d.x, d.y, 71) then
      mset(d.x, d.y, 71)
      snapshot()
    end
  end
end

function prettify_walls()
  for x = 0, 15 do
    for y = 0, 15 do
      if mget(x, y) == 2 then
        local sig, tle = get_sig(x, y), 3

        for i = 1, #wall_sig do
          if sig_comp(sig, wall_sig[i], wall_msk[i]) then
            tle = i + 15
            break
          end
        end

        mset(x, y, tle)
      elseif mget(x, y) == 1 then
        local tle = mget(x, y - 1)
        if not is_walkable(x, y - 1) then
          if tle == 35 or tle == 37 or tle == 53 then
            mset(x, y, 5)
          elseif tle == 36 or tle == 39 or tle == 55 then
            mset(x, y, 7)
          elseif tle == 54 then
            mset(x, y, 6)
          else
            mset(x, y, 4)
          end
        end
      end
    end
  end
end

function deco_rooms()
  for r in all(rooms) do
    local funcs, func = {deco_carpet, deco_dirt, deco_torch, deco_farn, deco_pots}

    func = rnd(funcs)

    for x = 0, r.w - 1 do
      for y = 0, r.h - 1 do
        func(r, r.x + x, r.y + y, x, y)
      end
    end
  end
end

function deco_carpet(r, tx, ty, x, y)
  deco_torch(r, tx, ty, x, y)
  if x > 0 and y > 0 and x < r.w - 1 and y < r.h - 1 then
    mset(tx, ty, 8)
  end
end

function deco_dirt(r, tx, ty)
  if mget(tx, ty) == 1 then
    local t_arr = split("1, 9, 14, 15")
    mset(tx, ty, rnd(t_arr))
  end
end

function deco_torch(r, tx, ty, x ,y)
  if rnd(3) > 1 and y % 2 == 1 and mget(tx, ty) == 1 and not is_next_to_tile(tx, ty, 71) then
    if x == 0 then
      mset(tx, ty, 112)
    elseif x == r.w - 1 then
      mset(tx, ty, 114)
    end
  end
end

function deco_farn(r, tx, ty)
  if mget(tx, ty) == 1 then
    local t_arr = split("1, 9, 10, 10, 10, 11, 11, 11, 12, 13")
    mset(tx, ty, rnd(t_arr))
  end
end

function deco_pots(r, tx, ty)
  if mget(tx, ty) == 1 and is_walkable(tx, ty, "check_mobs") and not is_next_to_tile(tx ,ty, 71) and not sig_comp(get_sig(tx, ty), 0, 0b00001111) then
    local t_arr = split("1, 1, 65, 66")
    mset(tx, ty, rnd(t_arr))
  end
end

function is_next_to_tile(x, y, tle)
  for i = 1, 4 do
    local dx, dy = x + dir_x[i],  y + dir_y[i]
    if is_in_bounds(dx, dy) and mget(dx, dy) == tle then
      return true
    end
  end

  return false
end
