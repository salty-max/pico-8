function get_sig(x, y)
  local sig, dgt = 0
  for i = 1 ,8 do
    local dx, dy = x + dir_x[i], y + dir_y[i]

    dgt = is_walkable(dx, dy) and 0 or 1
    sig = bor(sig, shl(dgt, 8 - i))
  end

  return sig
end