function gen_floor(f)
  floor = f
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

  mobs = {}
  add(mobs, player)

  gen_rooms()
  maze_worm()
  place_flags()
  carve_doors()
  carve_scuts()
  start_end()
  fill_ends()
  place_doors()
  spawn_mobs()
end

