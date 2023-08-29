function draw_game()
  cls(0)
  map()

  for m in all(d_mobs) do
    m.die -= 1

    if sin(time() * 8) > 0 then
      draw_mob(m)
    end

    if m.die <= 0 then
      del(d_mobs, m)
    end
  end

  for m in all(mobs) do
    if m ~= player then
      draw_mob(m)
    end
  end

  draw_mob(player)

  for f in all(float) do
    o_print_8(f.s, f.x, f.y, f.c, 0)
  end
end

function draw_gover()
  cls(2)
  o_print_8("u ded", 54, 60, 7, 0)
end

function draw_mob(_m)
  local c = _m.c
  if _m.flash > 0 then
    _m.flash -= 1
    c = 7
  end
  draw_spr(get_frame(_m.anim), _m.x * 8 + _m.ox, _m.y * 8 + _m.oy, c, _m.flp)
end
