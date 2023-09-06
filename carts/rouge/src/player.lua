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
      else
        skip_ai = true
      end
    end
  end

  unfog()
end

function trigger_bump(tile, dx, dy)
  if tile == 64 then
    -- tablets
    if floor == 0 then
      show_dialog({"", " welcome to my", " cheaply-made tower!", "", " inside: briefly", " trained monsters, ", " puzzles i forgot to", " finish, and the", " famous glowing rock!", "", " climb, if you dare!", " mwa ha ha ha ha ha", " *cough* *cough*", ""})
    end
  elseif tile == 109 then
    win = true
  elseif tile == 65 or tile == 66 then
    -- pots
    sfx(59)
    local dbr_pool = split("9, 14, 15")
    mset(dx, dy, rnd(dbr_pool))
    if rnd(3) < 1 and floor > 0 then
      if rnd(5) < 1 then
        add_mob(rnd(m_pool), dx, dy)
      else
        if get_free_slot() == -1 then
          show_msg("inventory full!", 60)
          skip_ai = true
        else
          local itm = rnd(flr_i_pool_com)
          take_item(itm)
          show_msg("found " .. items.name[itm] .. "!", 60)
        end
      end
    end
  elseif tile == 68 or tile == 70 then
    -- chests
    
    if get_free_slot() == -1 then
      sfx(60)
      show_msg("inventory full!", 60)
    else
      sfx(61)
      mset(dx, dy, tile - 1)
      local itm = tile == 70 and get_rare_item() or rnd(flr_i_pool_com)
      take_item(itm)
      show_msg("found " .. items.name[itm] .. "!", 60)
    end
  elseif tile == 71 then
    -- doors
    sfx(62)
    mset(dx, dy, 1)
  end
end

function trigger_step()
  local tle = mget(player.x, player.y)

  if tle == 72 then
    player.bless = 0
    fade_out()
    gen_floor(floor + 1)
    show_flr_msg()
    return true
  end

  return false
end

function check_end()
  if win then
    _upd = update_win
    _drw = draw_win
    windows = {}
    fade_out(0.02)
    return false
  elseif player.hp <= 0 then
    _upd = update_gover
    _drw = draw_gover
    windows = {}
    fade_out(0.02)
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
  local itm, tx, ty = inv[thr_slot], throw_tile()

  if is_in_bounds(tx, ty) then
    local mob = get_mob_at(tx, ty)

    if mob then 
      if items.kind[itm] == "fud" or items.kind[itm] == "drk" then
        consume(mob, itm)
      else
        sfx(58)
        hit_mob(nil, mob, items.stat1[itm])
      end
    end
  end

  mob_bump(player, thr_dx, thr_dy)
  inv[thr_slot] = nil
  a_t = 0
  _upd = update_pturn
end

function throw_tile()
  local tx, ty = player.x, player.y

  repeat
    tx += thr_dx
    ty += thr_dy
  until not is_walkable(tx, ty, "check_mobs")

  return tx, ty
end