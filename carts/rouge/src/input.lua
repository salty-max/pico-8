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

function handle_butt(b)
  if b < 0 then return end

  if b < 4 then
    move_player(dir_x[b + 1], dir_y[b + 1])
  elseif b == 4 then
    map_gen()
  elseif b == 5 then
    show_inv()
  end
end