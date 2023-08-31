function update_game()
  if dialog_box then
    if get_butt() == 5 then
      dialog_box.dur = 0
      dialog_box = nil
    end
  end
  buffer_butt()
  handle_butt(butt_buff)
  butt_buff = -1
end

function update_gover()
  if btnp(5) then
    fade_out()
    start_game()
  end
end

function update_pturn()
  buffer_butt()

  a_t = min(a_t + 0.128, 1)
  player:mov()

  if a_t == 1 then
    _upd = update_game
    if check_end() then
      do_ai()
    end
    -- calc_dist(player.x, player.y)
  end
end

function update_ai_turn()
  buffer_butt()
  a_t = min(a_t + 0.128, 1)

  for m in all(mobs) do
    if m != player and m.mov then
      m:mov()
    end
  end

  if a_t == 1 then
    _upd = update_game
    check_end()
  end
end

function update_inv()
  if btnp(4) then
    _upd = update_game
    inv_box.dur = 0
    stat_box.dur = 0
  end

  move_menu(inv_box)
end