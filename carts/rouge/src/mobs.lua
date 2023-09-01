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
    base_atk = bestiary.atk[type],
    atk = bestiary.atk[type],
    def_min = 0,
    def_max = 0,
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

function hit_mob(am, dm, raw)
  local dmg = am and am.atk or raw
  local def = dm.def_min + flr(rnd(dm.def_max - dm.def_min + 1))
  dmg -= min(def, dmg)

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
      local bdst, cand = 999, {}
      calc_dist(self.tx, self.ty)
      for i = 1, 4 do
        local dx, dy = dir_x[i], dir_y[i]
        local tx, ty = self.x + dx, self.y + dy
        if is_walkable(tx, ty, "check_mobs") then
          local dst = d_map[tx][ty]
          if dst < bdst then
            cand = {}
            bdst = dst
          end

          if dst == bdst then
            add(cand, { x = dx, y = dy })
          end
        end
      end
      if #cand > 0 then
        local c = get_rnd(cand)
        mob_walk(self, c.x, c.y)
        return true
      end
    end
  end

  return false
end

function can_see(m1, m2)
  return los(m1.x, m1.y, m2.x, m2.y) and dist(m1.x, m1.y, m2.x, m2.y) <= m1.los
end

-- check Line of Sight (LoS) between two points using Bresenham's line algorithm.
function los(x1, y1, x2, y2)
  -- initial setting of `frst` to denote first point in line check.
  local frst, sx, sy, dx, dy = true

  -- if distance between the two points is 1, they have direct sight.
  if dist(x1, y1, x2, y2) == 1 then return true end

  -- determine the direction of movement on the x-axis.
  -- if starting x is less than ending x, move right. Otherwise, move left.
  if x1 < x2 then
    sx, dx = 1, x2 - x1
  else
    sx, dx = -1, x1 - x2
  end

  -- determine the direction of movement on the y-axis.
  -- if starting y is less than ending y, move down. Otherwise, move up.
  if y1 < y2 then
    sy, dy = 1, y2 - y1
  else
    sy, dy = -1, y1 - y2
  end

  -- starting error for Bresenham's algorithm.
  local err, e2 = dx - dy

  -- traverse from (x1, y1) to (x2, y2) one grid cell at a time.
  while (x1 == x2 and y1 == y2) == false do
    -- if the current cell isn't the first and isn't walkable, LoS is blocked.
    if not frst and not is_walkable(x1, y1, "sight") then return false end

    -- calculate error to determine next cell in path.
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

  -- if function reaches here, there's an unblocked line of sight.
  return true
end

function update_stats()
  local atk, def_min, def_max = player.base_atk, 0, 0

  if eqp[1] then
    atk += items.stat_1[eqp[1]]
  end

  if eqp[2] then
    def_min += items.stat_1[eqp[2]]
    def_max += items.stat_2[eqp[2]]
  end

  player.atk = atk
  player.def_min = def_min
  player.def_max = def_max
end

function consume(mob, itm)
  local eft = items.stat_1[itm]

  if eft == 1 then
    -- heal
    heal_mob(mob, items.stat_2[itm])
  end
end

function heal_mob(mob, amt)
  amt = min(amt, mob.hp_max - mob.hp)
  mob.hp += amt
  mob.flash = 10
  add_float("+"..amt, mob.x * 8, mob.y * 8, 11)
end