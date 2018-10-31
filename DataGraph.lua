DataGraph = {}

DataGraph = function()
  local table = {vertex={},edge={},first={},last={},next={}}
  table.addVertex = function(label,fields)
   local n = #table.vertex + 1
    table.vertex[n] = label
    table.first[n] = 0
    table.last[n] = 0
    if fields then
      for k,v in pairs(fields) do
        table[k][n]=v
      end
    end
    return n
  end
  table.addEdge = function(vdx1,vdx2,label)
    local n = #table.edge + 1
    table.edge[n] = label
    if table.first[vdx1] == 0 then
      table.first[vdx1] = vdx2
    else
      table.next[] = 
    end
    table.last[vdx1] = vdx2
    return n
  end
  return table
end

local graph = DataGraph()

function addVertex(label)
  return graph.addChild(label)
end

function addEdge(v1,v2,label)
  return graph.addEdge(v1,v2,label)
end

function printVertex(vertex,fields)
  print(graph.name(vertex))
  local adjacent = graph.first(vertex)
  while adjacent ~= 0 do
    printVertex(adjacent,fields)
    adyacent = graph.next(adyacent)
  end
end

-- Create a graph programmatically

acme = nodeVertex("Acme Inc.")
  accounting = addChild(acme,"Accounting")
    software = addChild(accounting,"New Software")
    standards = addChild(accounting,"New Accounting Standards")
  research = addChild(acme,"Research")
    newProductLine = addChild(research,"New Product Line")
    newLabs = addChild(research,"New Labs")
  it = addChild(acme,"IT")
    outsource = addChild(it,"Outsource")
    agile = addChild(it,"Go agile")
    goToR = addChild(it,"Switch to R")
    
printNode(acme)

-- Custom fields in constructor

birds = nodeVertex("Aves", {vulgo = "Bird"})
addChild(birds,"Neognathae", {vulgo = "New Jaws", species = 10000})
addChild(birds,"Palaeognathae", {vulgo = "Old Jaws", species = 60})

printNode(birds, {"vulgo", "species"})
