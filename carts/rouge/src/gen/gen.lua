function map_gen()
  for x = 0, 15 do
    for y = 0, 15 do
      mset(x, y, 2)
    end
  end

  gen_rooms()
end
