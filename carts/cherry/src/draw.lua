function draw_game()
  cls(0)
  draw_starfield()
  draw_ship()
  draw_bullets()
  draw_ui()
end

function draw_ship()
  if muzzle > 0 then
    circfill(ship_x + 3, ship_y - 2, muzzle, 7)
  end

  spr(ship_spr, ship_x, ship_y)
  spr(ship_flm[flm_idx], ship_x, ship_y + 7)
end

function draw_bullets()
  for b in all(bul) do
    spr(b.anm[b.spr], b.x, b.y)
  end
end

function draw_ui()
  print("score: " .. score, 4, 4, 12)

  for i = 1, 3 do
    local s = 64
    if lives < i then
      s = 65
    end
    spr(s, 89 + (i * 9), 4)
  end
end

function draw_starfield()
  for s in all(stars) do
    local c = 6
    if s.spd < 1 then
      c = 1
    elseif s.spd  < 1.5 then
      c = 13
    end
    pset(s.x, s.y, c)
  end
end

function draw_menu()
  cls(0)
  draw_starfield()
  spr(192, 64 - 8 * 6, 32, 12, 2)
  print_center("press ❎ to start", 80, blink())
  spr(255, 116, 116)
end

function draw_gover()
  cls(0)
  draw_starfield()
  print_center("game over", 32, 8)
  print_center("score: "..score, 50, 6)
  print_center("press ❎ to start", 80, blink())
end