function get_frame(a)
  return a[flr(t / 15) % #a + 1]
end

function draw_spr(_s, _x, _y, _c, _flip)
  palt(0, false)
  pal(6, _c)
  spr(_s, _x, _y, 1, 1, _flip)
  pal()
end

function rect_fill(_x, _y, _w, _h, _c)
  rectfill(_x, _y, _x + _w - 1, _y + _h - 1, _c)
end