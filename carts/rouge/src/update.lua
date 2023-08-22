function update_game()
  for i = 0, 3 do
    if btnp(i) then
      move_player(dir_x[i + 1], dir_y[i + 1])
      return
    end
  end
end