require "dataGraph"

-- Create a graph programmatically

--[[

A->B,A->C,B->D,C->D,D->E,E-F,

--]]

local g = dataGraph("Test")

a = g.addVertex('A',{cost=10,label="First Vertex"})
b = g.addVertex('B',{cost=20,label="Second Vertex"})
c = g.addVertex('C',{cost=10,label="Third Vertex"})
d = g.addVertex('D',{cost=30,label="Fourth Vertex"})
e = g.addVertex('E',{cost=10,label="Fifth Vertex"})
f = g.addVertex('F',{cost=50,label="Sixth Vertex"})

g.addEdge(a,b,'A->B',{length=40})
g.addEdge(a,c,'A->C',{length=50})
g.addEdge(b,d,'B->D',{length=50})
g.addEdge(c,d,'C->D',{length=70})
g.addEdge(d,e,'D->E',{length=80})
g.addEdge(e,f,'E->F',{length=90})

printDataGraph(g,{'cost','label'},{'length'})
