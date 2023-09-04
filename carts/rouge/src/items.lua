function take_item(itm)
  local idx = get_free_slot()
  if idx < 0 then return false end
  inv[idx] = itm
  return true
end

function get_free_slot()
  for i = 1, 6 do
    if not inv[i] then
      return i
    end
  end

  return -1
end

function make_item_pools()
  i_pool_rar = {}
  i_pool_com = {}

  for i = 1, #items.name do
    local knd = items.kind[i]
    if knd == "wep" or knd == "arm" then
      add(i_pool_rar, i)
    else
      add(i_pool_com, i)
    end
  end
end

function make_flr_i_pool()
  flr_i_pool_rar = {}
  flr_i_pool_com = {}

  for i in all(i_pool_rar) do
    if items.min_f[i] <= floor and items.max_f[i] >= floor then
      add(flr_i_pool_rar, i)
    end
  end

  for i in all(i_pool_com) do
    if items.min_f[i] <= floor and items.max_f[i] >= floor then
      add(flr_i_pool_com, i)
    end
  end
end

function get_rare_item()
  if #flr_i_pool_rar > 0 then
    local itm = rnd(flr_i_pool_rar)
    del(flr_i_pool_rar, itm)
    del(i_pool_rar, itm)
    return itm
  else
    return rnd(flr_i_pool_com)
  end
end