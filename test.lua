require "dataGraph"

-- Create a graph programmatically

--[[

A->B,A->C,B->D,C->D,D->E,E-F,

--]]

a = addVertex('A',{cost=10,label="First Vertex"})
b = addVertex('B',{cost=20,label="Second Vertex"})
c = addVertex('C',{cost=10,label="Third Vertex"})
d = addVertex('D',{cost=30,label="Fourth Vertex"})
e = addVertex('E',{cost=10,label="Fifth Vertex"})
f = addVertex('F',{cost=50,label="Sixth Vertex"})

addEdge(a,b,'10')
addEdge(a,c,'20')
addEdge(b,d,'30')
addEdge(c,d,'40')
addEdge(d,e,'50')
addEdge(e,f,'60')

printVertex(a,{'cost','label'})
print("\n")
printVertex(b)
print("\n")

-- Testing TGF file reading
local graph = readTFG('samples/data.tgf')
printVertex(graph['1'])
printVertex(graph['1'], {'Label','size','age'})