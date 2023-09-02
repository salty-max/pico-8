function maze_worm()
  local cand
  repeat
    cand = {}
    for mx = 0, 15 do
      for my = 0, 15 do
        if not is_walkable(mx, my) and get_sig(mx, my) == 255 then
          add(cand, {x = mx, y = my})
        end
      end
    end

    if #cand > 0 then
      local c = rnd(cand)
      dig_worm(c.x, c.y)
    end
  until #cand <= 1
end

function dig_worm(x, y)
  local dir, stp = 1 + flr(rnd(4)), 0

  repeat
    local cand = {}
    mset(x, y, 1)
    if not can_carve(x + dir_x[dir], y + dir_y[dir], false) or (rnd() < 0.5 and stp > 2) then
      stp = 0
      for i = 1, 4 do
        if can_carve(x + dir_x[i], y + dir_y[i], false) then
          add(cand, i)
        end
      end

      if #cand == 0 then
        dir = 8
      else
        dir = rnd(cand)
      end
    end

    x += dir_x[dir]
    y += dir_y[dir]
    stp += 1
  until dir == 8
end

function can_carve(x, y, walk)
  if is_in_bounds(x, y) and is_walkable(x, y) == walk then
    local sig = get_sig(x, y)
    for i = 1, #crv_sig do
      if sig_comp(sig, crv_sig[i], crv_msk[i]) then
        return true
      end
    end
  end

  return false
end

function fill_ends()
  local cand, tle

  repeat
    cand = {}
    for mx = 0, 15 do
      for my = 0, 15 do
        tle = mget(mx, my)
        if  can_carve(mx ,my, true) and tle != 14 and tle != 15 then
          add(cand, {x = mx, y = my})
        end
      end
    end

    for c in all(cand) do
      mset(c.x, c.y, 2)
    end
  until #cand == 0
end