function get_frame(a)
  return a[flr(t / 8) % #a + 1]
end

function draw_spr(_s, _x, _y, _c)
  palt(0, false)
  pal(6, _c)
  spr(_s, _x, _y)
  pal()
end