local write = io.write
require "dataVector"
require "CSV"

function dataGraph(id)
  local oid = id or ""
  local fields = {'vertex','edge','first','last','next','adjacent','mark'}
  local table = {}
  local _table = table
  table = {oid=id}
  for _,k in pairs(fields) do
    _table[k] = vector(table.oid..tostring(k))
  end
  local metatable = {
    __newindex = function(table,k,v)
      _table[k] = v
    end,
    __index = function(table,k)
      return _table[k]
    end
  }
  table.addVertex = function(label,fields)
    local n = table.vertex.size() + 1
    table.vertex[n] = label
    table.first[n] = 0
    table.last[n] = 0
    if fields then
      for k,v in pairs(fields) do
        if table[k] == nil then
          table[k] = vector(table.oid..tostring(k))
        end
        table[k][n] = v
      end
    end
    return n
  end
  table.addFields = function(fields)
    local n = table.vertex.size()
    if fields then
      for i=1,n do
        for k,v in pairs(fields) do
          if table[k] == nil then
            table[k] = vector(table.oid..tostring(k))
          end
          table[k][i] = v
        end
      end
    end
    return n
  end
  table.addEdge = function(vdx1,vdx2,label,fields)
    local m = table.edge.size() + 1
    table.next[m] = 0
    table.edge[m] = label
    table.adjacent[m] = vdx2
    if table.first[vdx1] == 0 then
      table.first[vdx1] = m
    else
      table.next[table.last[vdx1]] = m
    end
    table.last[vdx1] = m
    if fields then
      for k,v in pairs(fields) do
        if table[k] == nil then
          table[k] = vector(table.oid..tostring(k))
        end
        table[k][m] = v
      end
    end
    return m
  end
  table.resetMark = function()
    for i,k in pairs(table.mark) do
      table.mark[i] = false
    end
  end
  setmetatable(table,metatable)
  return table
end

function printDataGraph(graph,fields1,fields2)
  write("oid: "..graph.oid..'\n')
  for vtx=1,graph.vertex.size() do
    write(graph.vertex[vtx]..' ')
    if fields1 then
      for i=1,#fields1 do
        if graph[fields1[i]][vtx] then
          write(graph[fields1[i]][vtx]..' ')
        end
      end
    end
    write('\n')
    local index = graph.first[vtx]
    local adj = nil
    while index ~= 0 do
      adj = graph.adjacent[index]
      write(graph.edge[adj]..' ')
      if fields2 then
        for i=1,#fields2 do
          if graph[fields1[i]][adj] then
            write(graph[fields2[i]][adj]..' ')
          end
        end
      end
      index = graph.next[index]
      write('\n')
    end
  end
end

-- reads custom TFG file format
function readTFG(file, name)
  -- initialize graph
  local graph = dataGraph(name)
  -- reads lines
  local lines = lines_from(file)
  -- i represents the i-th line from file
  local i = 1
  local line = lines[i]
  -- read headers atributes for vertex
  local atributes = ParseCSVLine(line)
  -- store each vertex
  local vertex = {}
  i = i + 1
  line = lines[i]
  -- until finds '#' or no line
  while line ~= nil and string.sub(line, 1, 1) ~= "#" do
    -- parse the line
    local data = ParseCSVLine(line)
    local id = data[1]
    -- fetch atributes
    local fields = {}
    for j, atribute in pairs(atributes) do
      fields[atribute] = data[j]
    end
    -- adds the vertex with its name as index
    vertex[id] = graph.addVertex(id, fields)
    i = i + 1
    line = lines[i]
  end
  i = i + 1
  line = lines[i]
  -- reads headers for edges
  atributes = ParseCSVLine(line)
  i = i + 1
  line = lines[i]
  while line ~= nil do
    -- parse the line
    data = ParseCSVLine(line)
    local vertex1 = data[1]
    local vertex2 = data[2]
    local name = data[3]
    -- fetch atributes
    local fields = {}
    for j, atribute in pairs(atributes) do
      fields[atribute] = data[j]
    end
    -- adds a new edge with fields if it has them
    if #atributes == 0 then graph.addEdge(vertex[vertex1], vertex[vertex2], name)
    else graph.addEdge(vertex[vertex1], vertex[vertex2], name, fields) end
    -- next line
    i = i + 1
    line = lines[i]
  end
  -- end
  return graph
end