function gen_floor(f)
  floor = f
  mobs = {}
  add(mobs, player)

  if floor == 0 then
    copy_map(16, 0)
  elseif floor == win_flr then
    copy_map(32, 0)
  else
    map_gen()
  end
end

function map_gen()
  copy_map(48, 0)

  rooms = {}
  roomap = blank_map(0)
  doors = {}

  gen_rooms()
  maze_worm()
  place_flags()
  carve_doors()
  carve_scuts()
  start_end()
  fill_ends()
  place_doors()
  prettify_walls()
  spawn_mobs()
end

function snapshot()
  if not is_dyn_gen then return end
  cls()
  map()
  for i = 0, 5 do
    flip()
  end
end

