function make_player(x, y)
  p = {
    x = x,
    y = y,
    ox = 0,
    oy = 0,
    sox = 0,
    soy = 0,
    c = 10,
    t = 0,
    flip = false,
    anim = { 240, 241, 242, 243 }
  }

  return p
end

function update_pturn()
  p.t = min(p.t + 0.128, 1)

  p.ox = p.sox * (1 - p.t)
  p.oy = p.soy * (1 - p.t)

  if p.t == 1 then
    _upd = update_game
  end
end