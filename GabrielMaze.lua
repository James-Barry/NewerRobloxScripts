--[[Gabriel graph maker for maze gen. Wewt. Less boring than squares/rectangles, but (hopefully) much easier than a Voronoi diagram. (it's pretty obvs (to me) that a Delaunay triangulation isn't quite right for the job.)]]

numpoints = 32

mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new
pi = math.pi
d = local function(a,b) return (a-b).magnitude end -- locals fns get stuck to the stack. (teeny bit faster when used a bunch.)

rooms = {} -- a list of the nodes for each room
lines = {}
points = {}

function Part(par,siz,cf,anch,col,trans)
	local p = Instance.new("Part",par)
	p.formFactor = "Custom"
	p.Size = siz
	p.Anchored = true
	p.Color = col
	p.Transparency = trans
	p.Position = V3(0,1984,0)
	p.CFrame = cf
	return p
end


function angleSort(tpts, aroundpt, ptst) -- takes a table of point indexes, ... , &  ptst is where the Vector3's really are -- returns the ordered points & angles
	local angltbl = {}
	-- get angles
	for i,v in ipairs(tpts) do
		local ng = math.atan((ptst[v].z-aroundpt.z)/(ptst[v].x-aroundpt.x))
		table.insert(angletbl,ng)
	end
	-- sort dat steff (insertion sort)
	for i = 2,#tpts do
		local th = angltbl[i]
		local n = i
		while n > 1 and th<angltbl[n-1] do
			local tmp = angltbl[n]
			angltbl[n] = th
			n = n-1
		end
		table.remove(angltbl,i)
		table.insert(angltbl,th,n)
		local tmp = tpts[i]
		table.remove(tpts,i)
		table.insert(tpts,tmp,n)
	end
	--
	return tpts, angltbl
end

function GabrielGraph(pts) -- returns the lines and rooms
	lns = {} -- the i'th table in lns will correspond to the i'th thing in rms 
	mdl = Instance.new("Model",Workspace)
	--[[An algorithm _to try_: (I'm doing it a more lame way right now.)
	[ if there is a point inside the circle (midpoint = center, dist b/w = diameter) then switchpoints]
	that one is more likely to be a neighbor
	after you find a valid point,
	there will be no more neighbor points whose dist in that direction is greater (or equal) to that diameter.
	is there some really neat mathing that will take care of > half the choices at once? ]]
	
	-- find neighbor points ≈ O(n^2/2)) right now.
	cons = {}
	for i,v in ipairs(pts) do
	table.insert(cons,{})
	end
	for i = 1, #pts-1 do
	v = pts[i]
	local ptcons = cons[i] -- I don't even use this... it's just helping me keep things together in mah headware.
		for j = i+1, #pts do
			-- if it's not already a neighbor the other way around then
			w = pts[j]
			bl = true
			tempp = (w+v)/2
			r = d(w,v)/2
			for k,v2 in ipairs(pts) do
				if d(tempp,v2)<r then 
				bl = false 
				break
				end
			end
			if bl then
				table.insert(cons[i],j)
				table.insert(cons[j],i) -- pts[j] is in ptcons, which is cons[i]
				Part(mdl,V3(2,1,(pts[i]-pts[j]).magnitude),CF((pts[i]+pts[j])/2,pts[j]),true, C3(.25,.25,.5),0)
			end
			--else
			--	table.insert(ptcons,j) [or do nothing! Nothing is fun and productive to do sometimes.]
			--end
		end
	end
	
	-- find rooms [and neighbor rooms at ≈ the same time]
		-- I might get to use Eulers Formula. Huzzah!
		-- ... or not.
	rms = {}
	bwcons = {}
	for i,v in ipairs(cons) do
	for j,w in ipairs(v) do -- as many rms as there are lines/connections to other pts/nodes
	table.insert(bwcons,nil)
	end
	end
	-- use n+1 = (n+1)%#v+1
	thispts, angles = angleSort(tpts, aroundpt, ptst)
	--TODO

	return lns, rms --, nrms = room neighbors
end

-- doing a recursive split & stitch back together will increase efficiency
-- May require restructuring the thing a bit.
testpts = {}

for i=1,20 do
	table.insert(testpts,V3(mr(-50,50),10,mr(-50,50)))
end

GabrielGraph(testpts)

