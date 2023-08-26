function draw_game()
  cls(0)
  map()

  for m in all(mobs) do
    draw_spr(get_frame(m.anim), m.x * 8 + m.ox, m.y * 8 + m.oy, m.c, m.flp)
  end
end