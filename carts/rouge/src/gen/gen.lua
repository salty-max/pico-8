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
  fill_ends()
  start_end()
  place_doors()
end

