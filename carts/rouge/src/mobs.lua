function add_mob(_type, _x, _y)
  local m = {
    x = _x,
    y = _y,
    ox = 0,
    oy = 0,
    sox = 0,
    soy = 0,
    c = 10,
    flp = false,
    mov = nil,
    anim = {}
  }
  for i = 0, 3 do
    add(m.anim, bestiary.anim[_type] + i)
  end

  add(mobs, m)

  return m
end

function get_mob_at(_x, _y)
  for m in all(mobs) do
    if m.x == _x and m.y == _y then
      return m
    end
  end
  return nil
end

function is_walkable(_x, _y, _mode)
  local mode = ""
  local tile = mget(_x, _y)

  if (_mode) mode = _mode
  if is_in_bounds(_x, _y) then
    if fget(tile, 0) then
      return false
    else
      if mode == "check_mobs" then
        return not get_mob_at(_x, _y)
      end
      return true
    end
  end

  return false
end

function is_in_bounds(_x, _y)
  local check = _x < 0 or _x > 15 or _y < 0 or _y > 15
  return not check
end

function mob_walk(_m, _dx, _dy)
  _m.x += _dx
  _m.y += _dy
  _m.sox, _m.soy = -_dx * 8, -_dy * 8
  _m.ox, _m.oy = _m.sox, _m.soy
  _m.mov = move_walk
end

function mob_bump(_m, _dx, _dy)
  _m.sox, _m.soy = _dx * 8, _dy * 8
  _m.ox, _m.oy = 0, 0
  _m.mov = move_bump
end

function mob_flip(_m, _dx)
  if _dx < 0 then
    _m.flp = true
  elseif _dx > 0 then
    _m.flp = false
  end
end

function move_walk(_m, _mt)
  _m.ox = _m.sox * (1 - _mt)
  _m.oy = _m.soy * (1 - _mt)
end

function move_bump(_m, _mt)
  local time = _mt

  if _mt > 0.5 then
    time = 1 - _mt
  end

  _m.ox = _m.sox * time
  _m.oy = _m.soy * time
end

function hit_mob(_ma, _mb)
  -- TODO
end