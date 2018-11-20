local write = io.write
require "dataVector"
require "CSV"

function dataGraph()
  local table = {vertex={},edge={},first={},
    last={},next={},adjacent={},mark={}}
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
  table.addEdge = function(vdx1,vdx2,label,fields)
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

local function printVertex(graph,vdx,fields)
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
    printVertex(graph,adjacent,fields)
    index = graph.next[index]
  end
end

function printDataGraph(graph,fields)
  graph.resetMark()
  printVertex(graph,1,fields)
end
