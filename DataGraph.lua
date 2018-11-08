require "ReadFile"

local write = io.write

local DataGraph = {}

DataGraph = function()
  local table = {vertex={},edge={},first={},last={},next={},adjacent={},mark={}}
  table.addVertex = function(label,fields)
    local n = #table.vertex + 1
    table.vertex[n] = label
    table.first[n] = 0
    table.last[n] = 0
    if fields then
      for k,v in pairs(fields) do
        if table[k] == nil then
          table[k] = {}
        end
        table[k][n]=v
      end
    end
    return n
  end
  table.addEdge = function(vdx1,vdx2,label)
    local m = #table.edge + 1
    table.next[m] = 0
    table.edge[m] = label
    table.adjacent[m] = vdx2
    if table.first[vdx1] == 0 then
      table.first[vdx1] = m
    else
      table.next[table.last[vdx1]] = m
    end
    table.last[vdx1] = m
    return m
  end
  table.resetMark = function()
    for i,k in pairs(table.mark) do
      table.mark[i] = false
    end
  end
  return table
end

local graph = DataGraph()

function addVertex(label,fields)
  return graph.addVertex(label,fields)
end

function addEdge(v1,v2,label)
  return graph.addEdge(v1,v2,label)
end

local function _printVertex(vdx,fields)
  if graph.mark[vdx] then
    return
  end
  write(graph.vertex[vdx]..' ')
  if fields then
    for i=1,#fields do
      if graph[fields[i]][vdx] then
        write(graph[fields[i]][vdx]..' ')
      end
    end
  end
  write('\n')
  graph.mark[vdx] = true
  local index = graph.first[vdx]
  local adjacent = nil
  while index ~= 0 do
    adjacent = graph.adjacent[index]
    _printVertex(adjacent,fields)
    index = graph.next[index]
  end
end

function printVertex(vdx,fields)
  graph.resetMark()
  _printVertex(vdx,fields)
end

-- reads tfg file format
function readTFG(file)
  local lines = lines_from(file)

  i = 1
  line = lines[i]

  atributes = ParseCSVLine(line)

  i = i + 1
  line = lines[i]

  vertexs = {}

  while line ~= nil and string.sub(line, 1, 1) ~= "#" do

    data = ParseCSVLine(line)
    id = data[1]
    fields = {}

    for j, atribute in pairs(atributes) do
      table.insert(fields, data[j])
    end

    vertexs[id] = addVertex(id, fields)

    i = i + 1
    line = lines[i]
  end

  i = i + 1
  line = lines[i]

  atributes = ParseCSVLine(line)

  i = i + 1
  line = lines[i]

  edges = {}

  while line ~= nil do

    data = ParseCSVLine(line)
    vertex1 = data[1]
    vertex2 = data[2]
    weight = data[3]
    
    addEdge(vertexs[vertex1], vertexs[vertex2], weight)

    i = i + 1
    line = lines[i]
  end

  return vertexs

end