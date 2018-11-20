function vector(args)
  local table = args or {}
  local _table = table
  table = {}
  local metatable = {
    __newindex = function(table,k,v)
      _table[k] = v
    end,
    __index = function(table,k)
      return _table[k]
    end
  }
  table.size = function()
    return #_table
  end
  setmetatable(table,metatable)
  return table
end

c = function(args) return vector(args) end

function printVector(vct)
  for i = 1,vct.size() do
    print(i..":"..tostring(vct[i]))
  end
end
