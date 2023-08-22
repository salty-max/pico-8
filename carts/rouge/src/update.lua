function update_game()
  for i = 0, 3 do
    if btnp(i) then
      local dx, dy = dir_x[i + 1], dir_y[i + 1]
      p.x += dx
      p.y += dy
      if dx < 0 then
        p.flip = true
      elseif dx > 0 then
        p.flip = false
      end
      p.sox, p.soy = -dx * 8, -dy * 8
      p.ox, p.oy = p.sox, p.soy
      p.t = 0
      _upd = update_pturn
      return
    end
  end
end