--[[ The name of the wind is bob... Big. Bad. Bob. This is a random fun project thing.]]

ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character
cam = workspace.CurrentCamera
mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new
pi = math.pi

hb = Instance.new("HopperBin",ply.Backpack)
hb.Name = "Thing"

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

function WeldPart(p0,siz,relcf,col,trans)
        local p = Instance.new("Part",p0)
        p.formFactor = "Custom"
        p.Size = siz
        p.Anchored = false
        p.Color = col
        p.Transparency = trans
        p.Position = V3(0,1984,0)
		p.CanCollide = false
        p.CFrame = p0.CFrame
		--
		local wld = Instance.new("Weld", p0)
        wld.Part0 = p0
        wld.Part1 = p
        wld.C0 = relcf
        return p
end

function makeBallPart(parent, anch, trans, collide, color, size, cf)
	p = Instance.new("Part")
	p.Parent = parent
	p.formFactor = "Custom"
	p.Shape = "Ball"
	p.Anchored = anch
	p.Transparency = trans
	p.CanCollide = collide
	p.Color = color
	p.Size = size
	p.TopSurface = 0
	p.CFrame = cf
	return p        
end

function makeWedgePart(parent, anch, trans, collide, color, size, cf)
	p = Instance.new("WedgePart")
	p.Parent = parent
	p.formFactor = "Custom"
	p.Anchored = anch
	p.Transparency = trans
	p.CanCollide = collide
	p.Color = color
	p.Size = size
	p.TopSurface = 0
	p.BottomSurface = 0
	p.CFrame = cf
	return p        
end

function weldParts(pt1, pt2, c0, c1)
	w = Instance.new("Weld")
	w.Parent = pt1
	w.Part0 = pt1
	w.Part1 = pt2
	w.C0 = c0
	w.C1 = c1
	return w
end

spills = Instance.new("Model")
spills.Parent = game.Workspace
spills.Name = "Spills"

numSpills = 0
spillLimit = 40

function spill(cf, col, siz)
	if numSpills < spillLimit then
	p = makePart(spills, true, 0, false, col, siz, CFrame.new(cf.X,1.5,cf.z))
	Instance.new("CylinderMesh",p)
	numSpills = numSpills+1
	else
	numSpills = numSpills-1
	spills[1]:remove()
	end
end

function FireBall(start, fin)
	mainBall = makeBallPart(game.Workspace, true, 0, true, Color3.new(1,0,0), Vector3.new(1,1,1), start)
	Instance.new("Fire",mainBall).Size = 5
	for i = 1, (start.p-fin.p).magnitude do
	mainBall.CFrame = CFrame.new(start.p,fin.p)*CFrame.new(0,0,i*-1)
	wait()
	end
	mainBall:remove()
end

function FusRohDah(modx)
v = modx:getChildren()
for i = 1, #v do
if v[i].className == "Part" then
	table.insert(clones, v[i]:clone())
	g = splitPart(v[i],true)
	table.insert(bunches, g)
	for j = 1, #g do
	g[j].Anchored = false
	g[j].Velocity = (g[j].Position-char.Torso.Position).unit*math.random(100,125)
	end
end
end
end

function eachBit(a, b)
	for i=1,33 do
	a.CFrame = a.CFrame:lerp(b, i*.01) -- Yeh?
	wait()
	end
	a:remove()
end

function fix(thing, tbl)
	mycfs = getSplitCFs(thing)
	for i,v in ipairs(mycfs) do
	if tbl[i] ~= nil then
		tbl[i].Anchored = true
		tbl[i].CanCollide = false
		-- lerp to the cf
		local cr = coroutine.create(eachBit)
		coroutine.resume(cr, tbl[i], v) -- Yehck. this seems like an inefficient way to do things.
	end
	end
	wait(.9)
	thing.Parent = workspace -- change l8r
end

cfs1 = {CA(0,pi/2,0),CA(0,pi/-2,0),CA(0,pi/2,0),CA(0,pi/-2,0)}

function getSplitCFs(part)
	cftable = {}
	local siz = Vector3.new(part.Size.Z,part.Size.Y/2,part.Size.X/2)
	local pcf = part.CFrame
	for i = 1, 2 do
	local iang = CA(math.rad(i*180),0,0)
	local cb = CF(0,part.Size.Y/-4,part.Size.X/4)*iang
	local cf = pcf*cfs1[1]*cb
	table.insert(cftable,cf)
	local cf = pcf*cfs1[2]*cb
	table.insert(cftable,cf)
	local cf = pcf*cfs1[3]*CA(math.rad(180),0,0)*cb
	table.insert(cftable,cf)
	local cf = pcf*cfs1[4]*CA(math.rad(180),0,0)*cb
	table.insert(cftable,cf)
	end
	return cftable
end

function splitPart(part, collide)
	rtt = {}
	ptt2 = {}
	mod = Instance.new("Model")
	mod.Parent = game.Workspace
	mod.Name = "Parts"
	local a = part.Anchored
	local siz = Vector3.new(part.Size.Z,part.Size.Y/2,part.Size.X/2)
	local tr = part.Transparency
	local pcl = part.Color
	local pcfs = getSplitCFs(part)
	for i,v in ipairs(pcfs) do
	local p = makeWedgePart(mod, a, tr, collide, pcl, siz, v)
	p.Name = "S"
	table.insert(rtt,p)
	end
	part:remove()
return rtt
end

clones = {}
bunches = {}

hb.Selected:connect(function(mouse)
mouse.Button1Down:connect(function() -- Smite
	t = mouse.Target
	if t ~= nil then 
	if t.Parent:findFirstChild("Humanoid") ~= nil then
	modl = t.Parent
	FusRohDah(modl)
	elseif t.className == "Part" and mouse.Target.Name ~= "Base" then
	table.insert(clones, t:clone())
	g = splitPart(t,true)
	for j = 1, #g do
	g[j].Anchored = false
	g[j].Velocity = (g[j].Position-char.Torso.Position).unit*math.random(100,125)
	end
	table.insert(bunches, g)
	end
	end
end)

mouse.KeyDown:connect(function(key)
if key == "q" then -- Another smite of sorts
	if mouse.Target ~= nil then 
	if mouse.Target.Parent:findFirstChild("Humanoid") ~= nil then
	modl = mouse.Target.Parent
	elseif mouse.Target.className == "Part" and mouse.Target.Name ~= "Base" then
	g = splitPart(mouse.Target,true)
	for j = 1, #g do
	g[j].Anchored = false
	g[j].Velocity = (g[j].Position-char.Torso.Position).unit*math.random(100,125)
	end
	end
	end
end

if key == "e" then -- Smite of sorts
	if mouse.Target then
	mpos = mouse.Hit
	FireBall(char.Head.CFrame, mouse.Hit)
	np = makeBallPart(game.Workspace, true, 0.5, false, Color3.new(1,0,0), Vector3.new(30,30,30), mpos)
	game:getService("Debris"):AddItem(np,0.5)
	E = Instance.new("Explosion")
	E.Parent = game.Workspace
	E.Position = mpos.p
	E.BlastRadius = 15
	E.BlastPressure = 0
	E.Hit:connect(function(pt)
	if pt.Size.X*pt.Size.Y*pt.Size.Z <= 30 then
	catch(pt)
	pt:BreakJoints()
	pt.Velocity = (mpos.p-pt.Position).unit*pt.Size.X*pt.Size.Y*pt.Size.Z*-25
	end
	end)
	end
end

if key == "r" then -- Put it all back together
	for i,v in ipairs(clones) do
		fix(v,bunches[i]) -- yeah? mebe?
	end
end

if key == "f" then
	if mouse.Target then
    --  
	end
end

end)
end)

for i=1,10 do
	Part(workspace,V3(10,10,10),CF(75+mr(-30,30),mr(5,30),mr(-30,30)), false, C3(mr(),mr(),mr()),.7)
end

--[[----------------------------------------------------
-- Hi! I'm bob. Nice to meet you. Have a great life! --
------------------------------------------------------]]

