function draw_game()
  cls(0)
  map()

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