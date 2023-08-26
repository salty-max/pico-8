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
  rectfill(_x, _y, _x + max(_w - 1, 0), _y + max(_h - 1, 0), _c)
end

function o_print_8(_s, _x, _y, _c, _c2)
  for i = 1, 8 do
    print(_s, _x + dir_x[i], _y + dir_y[i], _c2)
  end
  print(_s, _x, _y, _c)
end