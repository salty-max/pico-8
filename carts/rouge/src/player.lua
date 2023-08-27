function move_player(_dx, _dy)
  local destx, desty = p.x + _dx, p.y + _dy
  local tile = mget(destx, desty)

  mob_flip(p, _dx)

  if not is_walkable(destx, desty, "check_mobs") then
    -- not walkable
    p_t = 0
    mob_bump(p, _dx, _dy)
    _upd = update_pturn

    local mob = get_mob_at(destx, desty)
    if not mob then
      -- interact
      if fget(tile, 1) then
        trigger_bump(tile, destx, desty)
      end
    else
      -- hit mob
      sfx(58)
      hit_mob(p, mob)
    end
  else
    sfx(63)
    p_t = 0
    mob_walk(p, _dx, _dy)
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