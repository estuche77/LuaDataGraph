require "dataGraph"

local g = nil

function drawing(graph)
  for vtx=1,graph.vertex.size() do
    rect(graph.x[vtx],graph.y[vtx],8,8)
    text(graph.name[vtx],graph.x[vtx]+2,graph.y[vtx])
    local index = graph.first[vtx]
    local adj = nil
    while index ~= 0 do
      adj = graph.adjacent[index]
      line(graph.x[vtx],graph.y[vtx],graph.x[adj],graph.y[adj])
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
  local f = createFont("data/Vera.ttf",13)
  textFont(f)
  
  g = dataGraph("Test")

  local a = g.addVertex('A',{value=10,name="First",x=0,y=0})
  local b = g.addVertex('B',{value=20,name="Second",x=0,y=0})
  local c = g.addVertex('C',{value=10,name="Third",x=0,y=0})
  local d = g.addVertex('D',{value=30,name="Fourth",x=0,y=0})
  local e = g.addVertex('E',{value=10,name="Fifth",x=0,y=0})
  local f = g.addVertex('F',{value=50,name="Sixth",x=0,y=0})

  g.addEdge(a,b,{cost=10})
  g.addEdge(a,c,{cost=20})
  g.addEdge(b,d,{cost=20})
  g.addEdge(c,d,{cost=20})
  g.addEdge(d,e,{cost=20})
  g.addEdge(e,f,{cost=20})

  randomGraphLayout(g,1,10,10,620,460)
end

function draw()
  drawing(g)
end
