function make_player(x, y)
  p = {
    x = x,
    y = y,
    ox = 0,
    oy = 0,
    c = 10,
    anim = { 240, 241, 242, 243 }
  }

  return p
end

function update_pturn()
  if p.ox > 0 then
    p.ox -= 1
  end
  if p.ox < 0 then
    p.ox += 1
  end

  if p.oy > 0 then
    p.oy -= 1
  end
  if p.oy < 0 then
    p.oy += 1
  end

  if p.ox == 0 and p.oy == 0 then
    _upd = update_game
  end
end