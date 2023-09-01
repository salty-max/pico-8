function move_player(dx, dy)
  local destx, desty = player.x + dx, player.y + dy
  local tile = mget(destx, desty)

  if is_walkable(destx, desty, "check_mobs") then
    sfx(63)
    mob_walk(player, dx, dy)
    a_t = 0
    _upd = update_pturn
  else
    -- not walkable
    mob_bump(player, dx, dy)
    a_t = 0
    _upd = update_pturn

    local mob = get_mob_at(destx, desty)
    if mob then
      -- hit mob
      sfx(58)
      hit_mob(player, mob)
    else
      -- interact
      if fget(tile, 1) then
        trigger_bump(tile, destx, desty)
      end
    end
  end

  unfog()
end

function trigger_bump(tile, dx, dy)
  if tile == 6 then
    -- tablets
    show_dialog({ "welcome to my lair", "", "climb the tower", "if you dare", "", "bwa ha ha ha ha", "*cough* *cough*" }, 120)
  elseif tile == 7 or tile == 8 then
    -- pots
    sfx(59)
    mset(dx, dy, 1)
  elseif tile == 10 or tile == 12 then
    -- chests
    sfx(61)
    mset(dx, dy, tile - 1)
  elseif tile == 13 then
    -- doors
    sfx(62)
    mset(dx, dy, 1)
  end
end

function check_end()
  if player.hp <= 0 then
    _upd = update_gover
    _drw = draw_gover
    windows = {}
    fade_out(0.02)
    reload(0x2000, 0x2000, 0x1000)
    return false
  end

  return true
end

function unfog()
  local px, py = player.x, player.y
  for x = 0, 15 do
    for y = 0, 15 do
      if fog[x][y] == 1 and dist(px, py, x, y) <= player.los and los(px, py, x, y) then
        unfog_tile(x, y)
      end
    end
  end
end

function unfog_tile(x, y)
  fog[x][y] = 0
  if is_walkable(x, y, "sight") then
    for i = 1, 4 do
      local tx, ty = x + dir_x[i], y + dir_y[i]
      if is_in_bounds(tx, ty) and not is_walkable(tx, ty, "sight") then
        fog[tx][ty] = 0
      end
    end
  end
end

function throw()
  _upd = update_game
end

function throw_tile()
  local tx, ty = player.x, player.y

  repeat
    tx += thr_dx
    ty += thr_dy
  until not is_walkable(tx, ty, "check_mobs")

  return tx, ty
end