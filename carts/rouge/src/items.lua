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