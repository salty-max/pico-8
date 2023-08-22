function draw_game()
  cls(0)
  map()

  draw_spr(get_frame(p.anim), p.x * 8, p.y * 8, 9)
  draw_spr(get_frame(p.anim), p.x * 8 + p.ox, p.y * 8 + p.oy, p.c)
end