function create_entity(_x, _y, _anim)
  return {
    x = _x,
    y = _y,
    ox = 0,
    oy = 0,
    sox = 0,
    soy = 0,
    c = 10,
    t = 0,
    flip = false,
    anim = _anim
  }
end