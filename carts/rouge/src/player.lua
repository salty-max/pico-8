function move_player(_dx, _dy)
  local destx, desty = player.x + _dx, player.y + _dy
  local tile = mget(destx, desty)

  if is_walkable(destx, desty, "check_mobs") then
    sfx(63)
    mob_walk(player, _dx, _dy)
    p_t = 0
    _upd = update_pturn
  else
    -- not walkable
    mob_bump(player, _dx, _dy)
    p_t = 0
    _upd = update_pturn

    local mob = get_mob_at(destx, desty)
    if mob == false then
      -- interact
      if fget(tile, 1) then
        trigger_bump(tile, destx, desty)
      end
    else
      -- hit mob
      sfx(58)
      hit_mob(player, mob)
    end
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

function check_end()
  if player.hp <= 0 then
    _upd = update_gover
    _drw = draw_gover
    windows = {}
    fade_out(0.02)
    return false
  end

  return true
end