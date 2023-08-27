function draw_game()
  cls(0)
  map()

  for m in all(mobs) do
    local c = m.c
    if m.flash > 0 then
      m.flash -= 1
      c = 7
    end
    draw_spr(get_frame(m.anim), m.x * 8 + m.ox, m.y * 8 + m.oy, c, m.flp)
  end

  for f in all(float) do
    o_print_8(f.s, f.x, f.y, f.c, 0)
  end
end