function update_game()
  if btnp(0) then
    p.x -= 1
    p.ox = 8
    _upd = update_pturn
  end
  if btnp(1) then
    p.x += 1
    p.ox = -8
    _upd = update_pturn
  end
  if btnp(2) then
    p.y -= 1
    p.oy = 8
    _upd = update_pturn
  end
  if btnp(3) then
    p.y += 1
    p.oy = -8
    _upd = update_pturn
  end
end