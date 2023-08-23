function add_window(_x, _y, _w, _h, _txt)
  local w = {
    x = _x,
    y = _y,
    w = _w,
    h = _h,
    txt = _txt
  }

  add(windows, w)
  return w
end

function draw_windows()
  for w in all(windows) do
    local wx, wy, ww, wh = w.x, w.y, w.w, w.h

    rect_fill(wx, wy, ww, wh, 0)
    rect_fill(wx + 1, wy + 1, ww - 2, wh - 2, 6)
    rect_fill(wx + 2, wy + 2, ww - 4, wh - 4, 0)
    clip(wx, wy, ww - 8, wh - 8)
    for i = 1, #w.txt do
      local txt = w.txt[i]
      local tx, ty = wx + 4, wy + 4 + (i - 1) * 7
      print(txt, tx, ty, 7)
    end
  end
end