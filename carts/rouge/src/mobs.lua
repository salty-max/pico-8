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
  mode = mode or ""
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
  m.flp = dx == 0 and m.flp or dx < 0
end

function move_walk(self)
  local time = 1 - a_t
  self.ox = self.sox * time
  self.oy = self.soy * time
end

function move_bump(self)
  local time = a_t > 0.5 and 1 - a_t or a_t
  self.ox = self.sox * time
  self.oy = self.soy * time
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
      moving = m:task() or moving
    end
  end

  if moving then
    _upd = update_ai_turn
    a_t = 0
  end
end

function ai_wait(self)
  if can_see(self, player) then
    -- aggro
    self.task = ai_chase
    self.tx, self.ty = player.x, player.y
    add_float("!", self.x * 8 + 2, self.y * 8, 10)

    return true
  end

  return false
end

function ai_chase(self)
  if dist(self.x, self.y, player.x, player.y) == 1 then
    -- attack player
    local dx, dy = player.x - self.x, player.y - self.y
    mob_bump(self, dx, dy)
    hit_mob(self, player)
    sfx(57)
    return true
  else
    -- move towards player
    if can_see(self, player) then
      self.tx, self.ty = player.x, player.y
    end

    if self.x == self.tx and self.y == self.ty then
      --de aggro
      self.task = ai_wait
      add_float("?", self.x * 8 + 2, self.y * 8, 10)
    else
      local bdst, bx, by = 999, 0, 0
      for i = 1, 4 do
        local dx, dy = dir_x[i], dir_y[i]
        local tx, ty = self.x + dx, self.y + dy
        if is_walkable(tx, ty, "check_mobs") then
          local dst = dist(tx, ty, self.tx, self.ty)
          if dst < bdst then
            bdst, bx, by = dst, dx, dy
          end
        end
      end

      mob_walk(self, bx, by)
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
    sx, dx = 1, x2 - x1
  else
    sx, dx = -1, x1 - x2
  end
  if y1 < y2 then
    sy, dy = 1, y2 - y1
  else
    sy, dy = -1, y1 - y2
  end
  local err, e2 = dx - dy

  while (x1 == x2 and y1 == y2) == false do
    if not frst and not is_walkable(x1, y1, "sight") then return false end
    e2, frst = err + err, false
    if e2 > -dy then
      err -= dy
      x1 += sx
    end
    if e2 < dx then
      err += dx
      y1 += sy
    end
  end
  return true
end