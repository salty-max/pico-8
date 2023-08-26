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