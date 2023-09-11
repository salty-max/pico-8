function make_starfield()
  for i = 1, 100 do
    add(stars, {
      x = flr(rnd(128)),
      y = flr(rnd(128)),
      spd = rnd(1.5) + 0.5
    })
  end
end