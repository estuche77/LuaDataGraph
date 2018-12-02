require "dataGraph"

-- Create a graph programmatically

--[[

A->B,A->C,B->D,C->D,D->E,E-F,

--]]

g = dataGraph("Test")

a = g.addVertex('A',{cost=10,label="First Vertex"})
b = g.addVertex('B',{cost=20,label="Second Vertex"})
c = g.addVertex('C',{cost=10,label="Third Vertex"})
d = g.addVertex('D',{cost=30,label="Fourth Vertex"})
e = g.addVertex('E',{cost=10,label="Fifth Vertex"})
f = g.addVertex('F',{cost=50,label="Sixth Vertex"})

g.addEdge(a,b,'10',{cost=20})
g.addEdge(a,c,'20',{cost=20})
g.addEdge(b,d,'30',{cost=20})
g.addEdge(c,d,'40',{cost=20})
g.addEdge(d,e,'50',{cost=20})
g.addEdge(e,f,'60',{cost=20})

printDataGraph(g, {'cost','label'}, {'cost'})
print("\n")

-- Testing TGF file reading
local graph = readTFG('samples/data.tgf', 'TEST')
printDataGraph(graph)
printDataGraph(graph, {'Label','size','age'}, {'weight'})
