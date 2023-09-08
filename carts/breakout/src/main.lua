function _init()
  ball = {
    x = 61,
    y = 124,
    r = 2,
    dx = 2,
    dy = 2,
  }

  frame = 0
end

function _update()
  --frame += 1

  if ball.x < 0 or ball.x > 127 then
    ball.dx = -ball.dx
    sfx(0)
  end

  if ball.y < 0 or ball.y > 127 then
    ball.dy = -ball.dy
    sfx(0)
  end

  ball.x += ball.dx
  ball.y += ball.dy
end

function _draw()
  cls(1)
  circfill(ball.x, ball.y, ball.r, 10)
end