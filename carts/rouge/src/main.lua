-- bestiary indexes
-- 1: player
-- 2: slime

bestiary = {
  anim = { 240, 192 },
  atk = { 1, 1 },
  hp = { 5, 2 }
}

function _init()
  t = 0

  dir_x = { -1, 1, 0, 0, 1, 1, -1, -1 }
  dir_y = { 0, 0, -1, 1, -1, 1, 1, -1 }

  _upd = update_game
  _drw = draw_game

  debug = {}
  start_game()
end

function start_game()
  butt_buff = -1
  mobs = {}

  player = add_mob(1, 1, 1)

  for y = 0, 15 do
    for x = 0, 15 do
      for i, m in pairs(bestiary.anim) do
        if mget(x, y) == m then
          add_mob(i, x, y)
          mset(x, y, 1)
        end
      end
    end
  end

  p_t = 0

  windows = {}
  float = {}
  dialog_box = nil
end

function _update60()
  t += 1
  _upd()
  do_floats()
end

function _draw()
  _drw()
  draw_windows()
  cursor(4, 4)
  color(8)
  for d in all(debug) do
    print(d)
  end
end