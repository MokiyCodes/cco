_G.table.create = table.create
  or function(count, value)
    local t = {}
    for i = 1, count, 1 do
      t[i] = value
    end
    return t
  end
