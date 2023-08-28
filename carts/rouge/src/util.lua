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

function dist(_fx, _fy, _tx, _ty)
  local dx, dy = _fx - _tx, _fy - _ty
  return sqrt(dx * dx + dy * dy)
end

function do_fade()
  local p, kmax, col, k = flr(mid(0, fade_perc, 1) * 100)
  for j = 1, 15 do
    col = j
    kmax = flr((p + j * 1.46) / 22)
    for k = 1, kmax do
      col = d_pal[col]
    end
    pal(j, col, 1)
  end
end

function fade_out(_spd, _dur)
  if (_spd == nil) _spd = 0.04
  if (_dur == nil) _dur = 0
  repeat
    fade_perc = min(fade_perc + _spd, 1)
    do_fade()
    flip()until fade_perc == 1
  wait(_dur)
end

function check_fade()
  if fade_perc > 0 then
    fade_perc = max(fade_perc - 0.04, 0)
    do_fade()
  end
end

function wait(_dur)
  repeat
    _dur -= 1
    flip()until _dur < 0
end