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
    mov = nil,
    flip = false,
    anim = { 240, 241, 242, 243 }
  }

  return p
end

function move_player(_dx, _dy)
  local destx, desty = p.x + _dx, p.y + _dy
  local tile = mget(destx, desty)

  if _dx < 0 then
    p.flip = true
  elseif _dx > 0 then
    p.flip = false
  end

  if fget(tile, 0) then
    -- wall
    p.sox, p.soy = _dx * 8, _dy * 8
    p.ox, p.oy = 0, 0
    p.t = 0
    p.mov = move_bump
    _upd = update_pturn

    if fget(tile, 1) then
      trigger_bump(tile, destx, desty)
    end
  else
    p.x += _dx
    p.y += _dy
    p.sox, p.soy = -_dx * 8, -_dy * 8
    p.ox, p.oy = p.sox, p.soy
    p.t = 0
    p.mov = move_walk
    _upd = update_pturn
  end
end

function update_pturn()
  p.t = min(p.t + 0.128, 1)

  p.mov()

  if p.t == 1 then
    _upd = update_game
  end
end

function move_walk()
  p.ox = p.sox * (1 - p.t)
  p.oy = p.soy * (1 - p.t)
end

function move_bump()
  local time = p.t

  if p.t > 0.5 then
    time = 1 - p.t
  end

  p.ox = p.sox * time
  p.oy = p.soy * time
end

function trigger_bump(_tile, _dx, _dy)
  if _tile == 5 then
    -- tablets
  elseif _tile == 7 or _tile == 8 then
    -- pots
    mset(_dx, _dy, 1)
  elseif _tile == 10 or _tile == 12 then
    -- chests
    mset(_dx, _dy, _tile - 1)
  elseif _tile == 13 then
    -- doors
    mset(_dx, _dy, 1)
  end
end