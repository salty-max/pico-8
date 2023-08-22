function update_game()
  if btnp(0) then
    p.x -= 1
  end
  if btnp(1) then
    p.x += 1
  end
  if btnp(2) then
    p.y -= 1
  end
  if btnp(3) then
    p.y += 1
  end
end