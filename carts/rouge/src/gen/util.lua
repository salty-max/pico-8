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

function is_floor_tile(x, y)
  local tle = mget(x, y)
  return tle == 1 or tle == 4 or tle == 5 or tle == 6 or tle == 7
end