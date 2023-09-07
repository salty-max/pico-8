function _init()
  ball = {
    x = 62,
    y = 120,
    dx = 0,
    dy = 0,
    spd = 1
  }
end

function _update()
  if btn(4) then
    ball.dx = ball.spd
    ball.dy = -ball.spd
  end

  if ball.x < 0 or ball.x > 121 then
    ball.dx = -ball.dx
  end

  if ball.y < 0 then
    ball.dy = -ball.dy
  end

  ball.x += ball.dx
  ball.y += ball.dy
end

function _draw()
  cls()
  spr(1, ball.x, ball.y)
end