function gen_floor(f)
  floor = f
  mobs = {}
  add(mobs, player)
  fog = blank_map(0)

  if floor == 0 then
    copy_map(16, 0)
  elseif floor == win_flr then
    copy_map(32, 0)
  else
    fog = blank_map(0)
    map_gen()
  end

  unfog()
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
  prettify_walls()
  place_doors()
  spawn_mobs()
  deco_rooms()
end

function snapshot()
  if not is_dyn_gen then return end
  cls()
  map()
  for i = 0, 5 do
    flip()
  end
end

