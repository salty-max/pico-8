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
    rect(wx + 1, wy + 1, wx + ww - 2, wy + wh - 2, 6)

    wx += 4
    wy += 4

    clip(wx, wy, ww - 8, wh - 8)
    for i = 1, #w.txt do
      local txt = w.txt[i]

      print(txt, wx, wy, 6)
      wy += 6
    end
    clip()

    if w.dur != nil then
      w.dur -= 1
      if w.dur <= 0 then
        local dif = wh / 4
        w.y += dif / 2
        w.h -= dif

        if wh < 3 then
          del(windows, w)
        end
      end
    else
      if w.butt then
        o_print_8("❎", wx + ww - 15, wy - 1 - max(0, sin(time())), 6, 0)
      end
    end
  end
end

function show_msg(_txt, _dur)
  local width = (#_txt + 2) * 4 + 7
  local w = add_window(63 - width / 2, 50, width, 13, { " " .. _txt })
  w.dur = _dur
end

function show_dialog(_txt)
  local dialog_h = #_txt * 6 + 7
  local start_y = (128 - dialog_h) / 2
  dialog_box = add_window(16, start_y, 94, dialog_h, _txt)
  dialog_box.butt = true
end