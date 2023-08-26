function _init()
  t = 0

  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  _upd = update_game
  _drw = draw_game

  start_game()
end

function start_game()
  butt_buff = -1
  p = make_player(1, 1)

  windows = {}
  dialog_box = nil
end

function _update60()
  t += 1
  _upd()
end

function _draw()
  _drw()
  draw_windows()
end