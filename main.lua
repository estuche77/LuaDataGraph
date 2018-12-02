require "dataGraph"

local g = nil

function drawing(graph,Vlabel,Elabel)
  for vtx=1,graph.vertex.size() do
    rect(graph.x[vtx],graph.y[vtx],8,8)
    text(graph[Vlabel][vtx],graph.x[vtx]+2,graph.y[vtx])
    local index = graph.first[vtx]
    local adj = nil
    while index ~= 0 do
      adj = graph.adjacent[index]
      line(graph.x[vtx],graph.y[vtx],graph.x[adj],graph.y[adj])
      text(graph[Elabel][index],(graph.x[vtx]+graph.x[adj])/2,(graph.y[vtx]+graph.y[adj])/2)
      index = graph.next[index]
    end
  end
end

function randomGraphLayout(graph,vertex,x,y,w,h)
  math.randomseed(os.time())
  for i=1,graph.vertex.size() do
    graph.x[i] = math.random()*w+x
    graph.y[i] = math.random()*h+y
  end
end

function setup()
  size(650,520)
  background(178)
  local f = createFont('data/Vera.ttf',13)
  textFont(f)
  
  -- Testing TGF file reading
  g = readTFG('samples/data.tgf', 'Graph')
  printDataGraph(g)
  printDataGraph(g, {'Label','size','age'}, {'weight'})

  g.addFields({x=0,y=0})

  randomGraphLayout(g,1,10,10,620,460)
end

function draw()
  drawing(g,'Label','relationship')
  -- drawing(g,'size','weight')
end