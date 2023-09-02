function gen_floor(f)
  floor = f
  map_gen()
end

function map_gen()
  for x = 0, 15 do
    for y = 0, 15 do
      mset(x, y, 2)
    end
  end

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
end

