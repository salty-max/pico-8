function draw_game()
  cls(0)
  map()

  palt(0, false)
  pal(6, p.c)
  spr(240, p.x * 8, p.y * 8)
  pal()
end