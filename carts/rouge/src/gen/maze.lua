function maze_worm()
  for x = 0, 15 do
    for y = 0, 15 do
      if not is_walkable(x, y) then
        if can_carve(x, y) then
          mset(x, y, 3)
        else
          mset(x, y, 2)
        end
      end
    end
  end
end

function can_carve(x, y)
  if is_in_bounds(x, y) then
    local sig = get_sig(x, y)
    for i = 1, #crv_sig do
      if sig_comp(sig, crv_sig[i], crv_msk[i]) then
        return true
      end
    end
  end

  return false
end

function sig_comp(sig, match, mask)
  local mask = mask or 0
  return bor(sig, mask) == bor(match, mask)
end

function get_sig(x, y)
  local sig, dgt = 0
  for i = 1 ,8 do
    local dx, dy = x + dir_x[i], y + dir_y[i]

    dgt = is_walkable(dx, dy) and 0 or 1
    sig = bor(sig, shl(dgt, 8 - i))
  end

  return sig
end