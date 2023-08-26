function move_player(_dx, _dy)
  local destx, desty = p.x + _dx, p.y + _dy
  local tile = mget(destx, desty)

  if _dx < 0 then
    p.flp = true
  elseif _dx > 0 then
    p.flp = false
  end

  if fget(tile, 0) then
    -- wall
    p.sox, p.soy = _dx * 8, _dy * 8
    p.ox, p.oy = 0, 0
    p_t = 0
    p.mov = move_bump
    _upd = update_pturn

    if fget(tile, 1) then
      trigger_bump(tile, destx, desty)
    end
  else
    sfx(63)
    p.x += _dx
    p.y += _dy
    p.sox, p.soy = -_dx * 8, -_dy * 8
    p.ox, p.oy = p.sox, p.soy
    p_t = 0
    p.mov = move_walk
    _upd = update_pturn
  end
end

function update_pturn()
  buffer_butt()

  p_t = min(p_t + 0.128, 1)
  p.mov(p, p_t)

  if p_t == 1 then
    _upd = update_game
  end
end

function trigger_bump(_tile, _dx, _dy)
  if _tile == 6 then
    -- tablets
    show_dialog({ "welcome to my lair", "", "climb the tower", "if you dare", "", "bwa ha ha ha ha", "*cough* *cough*" }, 120)
  elseif _tile == 7 or _tile == 8 then
    -- pots
    sfx(59)
    mset(_dx, _dy, 1)
  elseif _tile == 10 or _tile == 12 then
    -- chests
    sfx(61)
    mset(_dx, _dy, _tile - 1)
  elseif _tile == 13 then
    -- doors
    sfx(62)
    mset(_dx, _dy, 1)
  end
end