function add_mob(type, mx, my)
  local m = {
    x = mx,
    y = my,
    ox = 0,
    oy = 0,
    c = 10,
    flp = false,
    anim = {},
    flash = 0,
    atk = bestiary.atk[type],
    hp = bestiary.hp[type],
    hp_max = bestiary.hp[type],
    los = bestiary.los[type],
    task = ai_wait
  }

  for i = 0, 3 do
    add(m.anim, bestiary.anim[type] + i)
  end

  add(mobs, m)
  return m
end

function get_mob_at(x, y)
  for m in all(mobs) do
    if m.x == x and m.y == y then
      return m
    end
  end
  return false
end

function is_walkable(x, y, mode)
  if mode == nil then mode = "" end
  if is_in_bounds(x, y) then
    local tile = mget(x, y)
    if mode == "sight" then
      return not fget(tile, 2)
    else
      if not fget(tile, 0) then
        if mode == "check_mobs" then
          return not get_mob_at(x, y)
        end
        return true
      end
    end
  end

  return false
end

function is_in_bounds(x, y)
  local check = x < 0 or x > 15 or y < 0 or y > 15
  return not check
end

function mob_walk(m, dx, dy)
  m.x += dx
  m.y += dy

  mob_flip(m, dx)

  m.sox, m.soy = -dx * 8, -dy * 8
  m.ox, m.oy = m.sox, m.soy
  m.mov = move_walk
end

function mob_bump(m, dx, dy)
  mob_flip(m, dx)
  m.sox, m.soy = dx * 8, dy * 8
  m.ox, m.oy = 0, 0
  m.mov = move_bump
end

function mob_flip(m, dx)
  if dx < 0 then
    m.flp = true
  elseif dx > 0 then
    m.flp = false
  end
end

function move_walk(m, mt)
  m.ox = m.sox * (1 - mt)
  m.oy = m.soy * (1 - mt)
end

function move_bump(m, mt)
  local time = mt

  if mt > 0.5 then
    time = 1 - mt
  end

  m.ox = m.sox * time
  m.oy = m.soy * time
end

function hit_mob(am, dm)
  local dmg = am.atk
  dm.hp -= dmg
  dm.flash = 10

  add_float("-" .. dmg, dm.x * 8, dm.y * 8, 9)

  if dm.hp <= 0 then
    add(d_mobs, dm)
    del(mobs, dm)
    dm.die = 20
  end
end

function do_ai()
  local moving
  for m in all(mobs) do
    if m != player then
      m.mov = nil
      moving = m.task(m) or moving
    end
  end

  if moving then
    _upd = update_ai_turn
    p_t = 0
  end
end

function ai_wait(m)
  if can_see(m, player) then
    -- aggro
    m.task = ai_chase
    m.tx, m.ty = player.x, player.y
    add_float("!", m.x * 8 + 2, m.y * 8, 10)

    return true
  end

  return false
end

function ai_chase(m)
  if dist(m.x, m.y, player.x, player.y) == 1 then
    -- attack player
    local dx, dy = player.x - m.x, player.y - m.y
    mob_bump(m, dx, dy)
    hit_mob(m, player)
    sfx(57)
    return true
  else
    -- move towards player
    if can_see(m, player) then
      m.tx, m.ty = player.x, player.y
    end

    if m.x == m.tx and m.y == m.ty then
      --de aggro
      m.task = ai_wait
      add_float("?", m.x * 8 + 2, m.y * 8, 10)
    else
      local bdst, bx, by = 999, 0, 0
      for i = 1, 4 do
        local dx, dy = dir_x[i], dir_y[i]
        local tx, ty = m.x + dx, m.y + dy
        if is_walkable(tx, ty, "check_mobs") then
          local dst = dist(tx, ty, m.tx, m.ty)
          if dst < bdst then
            bdst, bx, by = dst, dx, dy
          end
        end
      end

      mob_walk(m, bx, by)
      return true
    end
  end

  return false
end

function can_see(m1, m2)
  return los(m1.x, m1.y, m2.x, m2.y) and dist(m1.x, m1.y, m2.x, m2.y) <= m1.los
end

function los(x1, y1, x2, y2)
  local frst, sx, sy, dx, dy = true
  --★
  if dist(x1, y1, x2, y2) == 1 then return true end
  if x1 < x2 then
    sx = 1
    dx = x2 - x1
  else
    sx = -1
    dx = x1 - x2
  end
  if y1 < y2 then
    sy = 1
    dy = y2 - y1
  else
    sy = -1
    dy = y1 - y2
  end
  local err, e2 = dx - dy, nil

  while (x1 == x2 and y1 == y2) == false do
    if not frst and not is_walkable(x1, y1, "sight") then return false end
    frst = false
    e2 = err + err
    if e2 > -dy then
      err = err - dy
      x1 = x1 + sx
    end
    if e2 < dx then
      err = err + dx
      y1 = y1 + sy
    end
  end
  return true
end