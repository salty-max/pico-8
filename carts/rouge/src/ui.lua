function add_window(wx, wy, ww, wh, txt)
  local w = {
    x = wx,
    y = wy,
    w = ww,
    h = wh,
    txt = txt
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

    if w.dur then
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

function show_msg(txt, dur)
  local width = (#txt + 2) * 4 + 7
  local w = add_window(63 - width / 2, 50, width, 13, { " " .. txt })
  w.dur = dur
end

function show_dialog(txt)
  local dialog_h = #txt * 6 + 7
  local start_y = (128 - dialog_h) / 2
  dialog_box = add_window(16, start_y, 94, dialog_h, txt)
  dialog_box.butt = true
end

function add_float(txt, fx, fy, col)
  add(
    float, {
      s = txt,
      x = fx,
      y = fy,
      end_y = fy - 10,
      c = col,
      t = 0
    }
  )
end

function do_floats()
  for f in all(float) do
    f.y += (f.end_y - f.y) / 10
    f.t += 1
    if f.t > 70 then
      del(float, f)
    end
  end
end

function handle_hp_box()
  hp_box.txt[1] = "♥" .. player.hp .. "/" .. player.hp_max
  local hpy = 5
  if player.y < 8 then
    hpy = 110
  end

  hp_box.y += (hpy - hp_box.y) / 5
end