function get_butt()
  for i = 0, 5 do
    if btnp(i) then
      return i
    end
  end

  return -1
end

function buffer_butt()
  if butt_buff == -1 then
    butt_buff = get_butt()
  end
end

function handle_butt(_b)
  if _b < 0 then return end

  if _b >= 0 and _b < 4 then
    move_player(dir_x[_b + 1], dir_y[_b + 1])
  end
end