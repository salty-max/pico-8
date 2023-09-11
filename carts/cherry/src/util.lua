function print_center(s, y, c)
  print(s, 64 - #s * 2, y, c)
end

function blink()
  return 5 + min(abs(sin(time() / 2) * 4), 1)
end