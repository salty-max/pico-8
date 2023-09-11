function update_game()
  a_t += 1
  update_starfield()
  update_ship()
  update_bullets()
end

function update_bullets()
  for b in all(bul) do
    if b.y < -7 then
      del(bul, b)
    end
    b.y -= bul_spd
    b.spr = 1 + flr((a_t / 6) % #b.anm)
  end
end

function update_ship()
  move_ship()
  shoot()

  -- react flame animation
  flm_idx = 1 + flr((a_t / 2) % #ship_flm)

  -- muzzle flash
  if muzzle > 0 then
    muzzle -= 1
  end

  if btnp(4) then
    _upd = update_gover
    _drw = draw_gover
  end
end

function update_starfield()
  for s in all(stars) do
    s.y += s.spd
    if s.y > 128 then
      s.y = 0
      s.x = flr(rnd(128))
      s.spd = rnd(1.5) + 0.5
    end
  end
end

function update_menu()
  update_starfield()

  if btnp(5) then
    start_game()
  end
end

function update_gover()
  update_starfield()

  if btnp(5) then
    start_game()
  end
end