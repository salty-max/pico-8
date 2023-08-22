function _init()
  _upd = update_game
  _drw = draw_game

  start_game()
end

function start_game()
  p = make_player(4, 5)
end

function _update()
  _upd()
end

function _draw()
  _drw()
end