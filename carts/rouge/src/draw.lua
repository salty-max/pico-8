function draw_game()
  cls(0)
  map()

  -- for x = 0, 15 do
  --   for y = 0, 15 do
  --     if d_map[x][y] > 0 then
  --       print(d_map[x][y], x * 8, y * 8, 8)
  --     end
  --   end
  -- end

  for m in all(d_mobs) do
    m.die -= 1

    if sin(time() * 8) > 0 then
      draw_mob(m)
    end

    if m.die <= 0 then
      del(d_mobs, m)
    end
  end

  for i = #mobs, 1, -1 do
    draw_mob(mobs[i])
  end

  if _upd == update_throw then
    local tx, ty = throw_tile()
    local lx1, ly1 = player.x * 8 + 4 + thr_dx * 4, player.y * 8 + 4 + thr_dy * 4
    local lx2, ly2 = mid(0, tx * 8 + 4, 127), mid(0, ty * 8 + 4, 127)
    line(lx1 + thr_dy, ly1 + thr_dx, lx2 + thr_dy, ly2 + thr_dx, 0)
    line(lx1 - thr_dy, ly1 - thr_dx, lx2 - thr_dy, ly2 - thr_dx, 0)
    
    if flr(t / 7) % 2 == 0 then
      fillp(0b1010010110100101)
    else
      fillp(0b0101101001011010)
    end

    line(lx1, ly1, lx2, ly2, 7)
    fillp()
    o_print_8("+", lx2 - 1, ly2 - 2, 7, 0)
  end

  for x = 0, 15 do
    for y = 0, 15 do
      if fog[x][y] == 1 then
        rect_fill(x * 8, y * 8, 8, 8, 0)
      end
    end
  end

  for f in all(float) do
    o_print_8(f.s, f.x, f.y, f.c, 0)
  end
end

function draw_gover()
  cls(2)
  o_print_8("u ded", 54, 60, 7, 0)
end

function draw_mob(m)
  local c = m.c
  if m.flash > 0 then
    m.flash -= 1
    c = 7
  end
  draw_spr(get_frame(m.anim), m.x * 8 + m.ox, m.y * 8 + m.oy, c, m.flp)
end