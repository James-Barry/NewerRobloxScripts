--[[3D-ish minimap. Made by bigbadbob234. Enjoy!]]

ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character -- WaitFor/ repeat until...
cam = workspace.CurrentCamera
cam:clearAllChildren() -- just for now?
t = char.Torso
mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new
d = function (a,b) return (a-b).magnitude end

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

function Frame(par, name, siz, pos, col, trans)
        fr = Instance.new("Frame")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.BackgroundTransparency = trans
        fr.ClipsDescendants = true
        fr.Name = "Skies"
        return fr
end

function ScrollingFrame(par, name, siz, pos, col, trans)
        fr = Instance.new("ScrollingFrame")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.BackgroundTransparency = trans
        fr.ClipsDescendants = true
        fr.Name = "Skies"
        return fr
end

function ImageB(par, name, siz, pos, col, img, trans)
        fr = Instance.new("ImageButton")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.Image = img
        fr.BackgroundTransparency = trans
        fr.Name = "Skies"
        fr.AutoButtonColor = false
        return fr
end

function ImageL(par, name, siz, pos, col, img, trans)
        fr = Instance.new("ImageLabel")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.Image = img
        fr.BackgroundTransparency = trans
        fr.Name = name
        return fr
end

function TextB(par, name, siz, pos, col, txt, trans)
        fr = Instance.new("TextButton")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.Text = txt
        fr.BackgroundTransparency = trans
        fr.Name = "Skies"
        fr.AutoButtonColor = false
        return fr
end

function TextL(par, name, siz, pos, col, txt, trans)
        fr = Instance.new("TextLabel")
        fr.Parent = par
        fr.Size = siz
        fr.Position = pos
        fr.BackgroundColor3 = col
        fr.Text = txt
        fr.BackgroundTransparency = trans
        fr.Name = name
        return fr
end


maptable1 = {}
maptable2 = {}
maptable3 = {}
tracktab3 = {} -- large immobile/anchored things
tracktab2 = {} -- large moving/unanchored things
tracktab1 = {} -- Anything with a Humanoid in it
-- The tracktabs should be parts with the right scale/position, so don't just track a model.

dist = 100 -- the radius/zoomed-out-ness of the map

angle = CA(0,0,0)
main = Part(cam, V3(5,5,5), CFrame.new((cam.CoordinateFrame*CF(0,0,-.5)).p)*angle, true, C3(.2,.5,.6), .5)
main.CanCollide = false
main.TopSurface = 0

sg = Instance.new("SurfaceGui",ply.PlayerGui)
sg.Adornee = main
sg.Face = "Top"
sg.CanvasSize = Vector2.new(dist,dist) -- tweak me?
mainfr = Frame(sg, "Expl", UD(1,0,1,0), UD(0,0,0,0), C3(0,0,0), 1)

sg2 = Instance.new("SurfaceGui",ply.PlayerGui)
sg2.Adornee = main
sg2.Face = "Front"
sg2.CanvasSize = Vector2.new(500,500) -- tweak me?

mainfr2 = ScrollingFrame(sg2, "Expl", UD(1,0,1,20), UD(0,0,0,0), C3(0,0,0), 1)

sg3 = Instance.new("SurfaceGui",ply.PlayerGui)
sg3.Adornee = main
sg3.Face = "Left"
sg3.CanvasSize = Vector2.new(500,500) -- tweak me?

mainfr3 = ScrollingFrame(sg3, "Expl2", UD(1,0,1,20), UD(0,0,0,0), C3(0,0,0), 1)

function update(pmaptable, tracktable)
	for i,v in ipairs(pmaptable) do
		v:remove() -- wastes a ton of memory?
	end
	local maptable = {}
	--
	for i,v in ipairs(tracktable) do
		if v == nil then 
			table.remove(tracktable,i)
		elseif d(t.Position, v.Position) < dist then
		local vc = t.Position-v.Position
		local x,y,z = t.CFrame:toObjectSpace(v.CFrame):toEulerAnglesXYZ()
		local p = WeldPart(
			main,
			V3(v.Size.X*5/dist,v.Size.Y*5/dist,v.Size.Z*5/dist), -- instead of .001 use 5/dist
			CF(vc.X*5/dist,vc.Y*5/dist+2.5,vc.Z*5/dist)*CA(x,y,z), 
			-- Seems hard on the computer... sorry /M[rs]+[.]/ Computer.
			C3(.5,.5,.5), .75) -- tweak me!
		table.insert(maptable,p)
		end
	end
	return maptable, tracktable
end

function newupdate(pmaptable, tracktable)
	for i,v in ipairs(pmaptable) do
		v:remove() -- wastes a ton of memory?
	end
	local maptable = {}
	for i,v in ipairs(tracktable) do
		if v == nil then 
			table.remove(tracktable,i)
		else
		local vc = t.Position-(v.Position)+V3(v.Size.X*.5,0,-v.Size.Z*.5)
--		if vc.magnitude < dist then
		local siz = UD(v.Size.Z/dist,0,v.Size.X/dist,0)--UD(0,v.Size.X/dist,0,v.Size.Z/dist)
		local x,y,z = v.CFrame:toObjectSpace(t.CFrame):toEulerAnglesXYZ()
		local fr = Frame(mainfr, "t", siz, UD(0.5+vc.Z/dist,0,0.5-vc.X/dist,0), v.Color, .3)
		fr.Rotation = y --ye?
		table.insert(maptable, fr)
--		end
		end
--		wait()
	end
	return maptable, tracktable
end


--[[ 
	Dear self,
EVERYTHING IS HARD ON THE COMPUTER.
STOP TRYING TO OPTIMIZE EVERYTHING.
	~past self
]]

function getMdlMass(mdl) 
local mss = 0
local pts = recurseForParts(mdl, 0, false, 10000)
	for i,v in ipairs(pts) do
		mss = mss+v:GetMass()
	end
return mss
end

function recurseForParts(m, min, trackMods, max) 
local ps = {}
local mods = {}
	if m.className == "Part" then
		table.insert(ps,m)
	end
	for i,v in ipairs(m:getChildren()) do
		if v.className == "Part" then --and v:GetMass() > min then
		table.insert(ps,v)
		elseif v.className == "Model" then
--		local k = getMdlMass(v)
--			if k > min then
--				if trackMods and k < max then
--				table.insert(mods,v)
--				else
				local temp = recurseForParts(v, min, trackMods, max)
				for i2,v2 in ipairs(temp) do
				table.insert(ps,v2)
				end
--			end
--			end
		end
	end
return ps, mods -- If your workspaces keeps a sane structure, this should work excellently
end

function getNumDes(thing)
	local count = #thing:getChildren()
	for i,v in ipairs(thing:getChildren()) do
			count = count+getNumDes(v)
	end
return count
end

function simpleExplore(obj,depth)
	local st = obj.Name
	for i,v in ipairs(obj:getChildren()) do
		st = st.."\n"..string.rep("\t",depth)
		st = st..simpleExplore(v,depth+1)
	end
	return st
end

function unfoldTable(tbl)
	nt = {}
	for i,v in ipairs(tbl) do
		if v.type == table then
		return unfoldTable(v)
		else
		table.insert(nt,v)
		end
	end
	return nt
end

explcols = {C3(.8,.8,.8),C3(1,.5,.5),C3(0,1,1),C3(0,1,0.5)}
expltype = {"Part","Model","Script","LocalScript"}

function explore(obj, fr, shift) -- doesn't deal with deletions/insertions yet.
	local tbl = {}
	local mv = UD(0,0,0,#obj:getChildren()*12)
	for j=1,#shift do
		shift[j].Position = shift[j].Position + mv
	end
	--
	for i,v in ipairs(obj:getChildren()) do
		local a = nil
		local newfr = Frame(fr, "Expl", UD(1,-15,1,-i*12), UD(0,15,0,i*12), C3(0,0,0), 1) 
		-- or ScrollingFrame if tbl is bigger than 'max'
		local tb = TextB(newfr, "txt", UD(1,0,0,12), UD(0,0,0,0), C3(1,1,1), v.Name, 1)
		tb.TextColor3 = C3(1,1,1)
		for i2,v2 in ipairs(expltype) do
			if v.ClassName == v2 then
				tb.TextColor3 = explcols[i2]
			end
		end
		tb.TextXAlignment = 0
		tb.TextYAlignment = 0
		table.insert(tbl,newfr)
		tb.MouseButton1Down:connect(function ()
			if #newfr:getChildren()>1 then
			local mv = UD(0,0,0,(getNumDes(newfr)-1)*-6)
				for i,v in ipairs(shift) do
				v.Position = v.Position + mv
				end
				for i,v in ipairs(newfr:getChildren()) do
					if v.className == "Frame" then
						v:remove()
					end
				end
				for j=i+1,#tbl do
					tbl[j].Position = tbl[j].Position + mv
				end
			else
			local t2 = {}
			for j=1,#shift do
				table.insert(t2,shift[j])
			end
			for j=i+1,#tbl do
				table.insert(t2,tbl[j])
			end
			explore(v, newfr, t2)
		end
		end)
	end
end

local tb = TextB(mainfr2, "txt", UD(1,0,1,0), UD(0,0,0,0), C3(1,1,1), "Explorer", 1)
tb.TextColor3 = C3(0.5,1,1)
tb.TextXAlignment = 1
tb.TextYAlignment = 0
explore(game.Workspace, mainfr2, {})

-- one-time get workspace parts, and after that use DescendentAdded to update the tracked parts

if workspace:findFirstChild("TestingModel") then
	workspace.TestingModel:remove()
end
-- Just for testing: 
testmodel = Instance.new("Model",workspace)
testmodel.Name = "TestingModel"
for i=1,15 do
p = Part(testmodel, V3(mr(5,25),mr(2,50), mr(5,30)), CF(mr(110,200),mr(0,20), mr(-50,50)),true,C3(mr(),mr(),mr()),.5)
end

allParts = recurseForParts(workspace, 0, false, 20000) --...allModels = recurseForParts(workspace, 0, true, 20000) -- tweak the min/max
-- for direct children of the workspace this will not check for being under the max.

for i,v in ipairs(allParts) do
	if v:GetMass() > 500 then -- tweak me
	table.insert(tracktab3, v)
	elseif v:GetMass() > 30 then -- tweak me
	table.insert(tracktab2, v)
	else --if v.Anchored == false then
	table.insert(tracktab1, v) -- should I have this or nah?
	end
end

col1 = C3(.7,0.2,0.2)
col2 = C3(.3,0.8,0.8)
col3 = C3(.5,0.5,0.8)

function updateCoroutine()
while 1 do -- see if it works w/o the assignment and returning new tables.
--	for i=1, 20 do
		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		wait(.2)
		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		wait(.2)
		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		wait(.2)
		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		wait(.2)
--[[		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		wait(.1)
		maptable1, tracktab1 = newupdate(maptable1, tracktab1)
		maptable2, tracktab2 = newupdate(maptable2, tracktab2)
		wait(.1)
		maptable3, tracktab3 = newupdate(maptable3, tracktab3)
		wait(.1)]]
--	end
	allParts = recurseForParts(workspace, 0, false, 20000) --...allModels = recurseForParts(workspace, 0, true, 20000) -- tweak the min/max

	for i,v in ipairs(allParts) do
		if v == nil then 
			table.remove(allParts,i)
		elseif (t.Position-(v.Position-v.Size/2)).magnitude < dist then
--[[		if v:GetMass() > 500 then -- tweak me
		table.insert(tracktab3, v)
		elseif v:GetMass() > 30 then -- tweak me
		table.insert(tracktab2, v)
		else --if v.Anchored == false then]]
		table.insert(tracktab1, v) -- should I have this or nah?
		end
	end

end
end

cr = coroutine.create(updateCoroutine)
coroutine.resume(cr)

-- TODO, take care of changed sizes

game:getService("RunService").RenderStepped:connect(function()
	main.CFrame = CFrame.new((cam.CoordinateFrame*CF(-2,-2,-11.5)).p)*angle
	-- update
end)

--[[----------------------------------------------------------
    Hi! I bet you're a wonderful person. Have a great life! :D
    ----------------------------------------------------------]]--


