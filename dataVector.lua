function vector(arg1,arg2)
  local id = (type(arg1) == "table") and "" or arg1
  local table = (id == "") and arg1 or arg2 or {}
  local _table = table
  table = {oid=id}
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
  print("oid:",vct.oid)
  for i = 1,vct.size() do
    print(i..":"..tostring(vct[i]))
  end
end
