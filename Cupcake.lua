--[[ Cupcakes. O'viously.]]
ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character
cam = workspace.CurrentCamera
mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new
db = function (a,b) game:GetService("Debris"):AddItem(a,b) end

function part(par,siz,cf,anch,col,mat,ccl)
	pt = Instance.new("Part")
	pt.Material = "Grass" -- Neon, Foil, Sand
	pt.formFactor = "Custom"
	pt.CanCollide = ccl
	pt.Anchored = anch
	pt.Size = siz
	pt.Position = Vector3.new(0,150,0)
	pt.CFrame = cf
	pt.Color = col
	pt.Material = mat
	pt.Parent = par
	return pt
end

function weld(p0,p1,c0,c1)
	wl = Instance.new("Weld")
	wl.Parent = p0
	wl.Part0 = p0
	wl.Part1 = p1
	wl.C0 = c0
	wl.C1 = c1 or CFrame.new()
	return wl
end

function fileMesh(p,scale,id)
	blk = Instance.new("FileMesh",pt)
	blk.Scale = Vector3.new(1.05,1.05,1.05)
	return blk
end


function getNearNormal(pt, cf) -- more complicated than nesc? Prolly, yeah. This is for brick-shaped parts, spheres are easy.
	-- returns something _like_ the normal nearest to cf, might not work at corners.
	-- it really returns the _direction_ of the normal, not the magnitude.
	local vdif = pt.CFrame:toObjectSpace(cf)
	local siz = pt.Size
	local x,y,z = siz.X,siz.Y,siz.Z -- just more inefficiencies?
	local x2,y2,z2 = vdif.X,vdif.Y,vdif.Z
	print("vdif: "..x2..","..y2..","..z2) -- ehh?
	local key = 0 
	local temp = math.abs(x2)*2/x
	local a = {math.abs(y2)*2/y, math.abs(z2)*2/z}
	for i,v in ipairs(a) do -- not as efficient as a bunch of ifs?
		if v < temp then
			key = i
			temp = v
		end
	end
	local cn = CF(0,0,0)
	if key == 0 then
		cn = CA(0,math.rad(90),0)
	elseif key == 1 then
		cn = CA(0,0,0)
	elseif key == 2 then
		cn = CA(math.rad(90),0,0)
	end
	--for debugging
	local nwpt = part(pt,V3(.1,.1,4),pt.CFrame*cn*CF(0,0,2),true,C3(1,0,0),"Plastic",false) -- Size should depend on original size.
	db(nwpt, 3)
	--for debugging
	return cn:toWorldSpace(pt.CFrame)
end

function shadowAndSplat(pt,shadowCol,shadowTime) -- So that you can use this for other things 
	local inAir = true
	pt.Touched:connect(function (pt2)
		-- splat here
		if pt2.Parent ~= pt then
			-- Direction of the cyl's top = some fn of the rel. vel and rel. position/size?
			local oldcf = pt.CFrame
			local dir = getNearNormal(pt2,oldcf)
			local nwpt = part(pt,V3(4,.1,4),dir*CA(0,math.rad(90),0),true,pt.Color,"Plastic",false) -- Size should depend on original size.
			-- weld to the hit part?
		end
		inAir = false
	end)
	local lastpos = pt.Position
	while inAir do
		wait()
		local sh = part(pt,V3(.1,.1,(pt.Position-lastpos).magnitude),CF((pt.Position+lastpos)/2,lastpos),true,shadowCol,"Plastic",false)
		game:getService("Debris"):AddItem(sh,shadowTime)
		lastpos = pt.Position
	end	
end

cupcolors = {C3(1,1,1),C3(1,0,1),C3(1,.5,1),C3(.7,0,.7),C3(0.3,1,1),C3(.8,.5,.8)}

function cupcake(cf,velocity)
	mdl = Instance.new("Model",workspace)
	mdl.Name = "Cupcake"
	cupc = cupcolors[mr(1,#cupcolors)]
	cc = Instance.new("Color3Value",mdl)
	cc.Value = cupc
	p1 = part(mdl,V3(1,1,1),cf,false,cupc, "Plastic", true) -- base
	--	fl = fileMesh(p1,V3(.3,.3,.3),"")
	p2 = part(mdl,V3(1,1,1),cf,false,cupc, "Plastic", false) -- top
	--	fl = fileMesh(p2,V3(.3,.3,.3),"")
	weld(p1,p2,CF(0,0.3,0))
	p1.Velocity = cf.lookVector*velocity
	p2.Velocity = cf.lookVector*velocity
	cr = coroutine.create(shadowAndSplat)
	coroutine.resume(cr, p1, cupc, 1) -- tweak me!
	return mdl
end

hb = Instance.new("HopperBin",ply.Backpack)
hb.Selected:connect(function (mouse)
	position1 = char.Head.Position

	mouse.Button1Down:connect(function()
		position1 = mouse.hit.p
		go = part(cam,V3(1,1,1),CF(position1),true,C3(0,1,1),"Plastic",false)
	end)

	mouse.Move:connect(function ()
		if go and mouse.Target then
			mp2 = mouse.hit.p
			go.Size = V3(.1,.1,(mp2-position1).magnitude-1)
			go.CFrame = CF((mp2+position1)/2,mp2)
		end
	end)

	mouse.Button1Up:connect(function()
		go:remove()-- = nil -- remove it?
		mycupcake = cupcake(CFrame.new(position1,mouse.hit.p)*CFrame.new(0,0,2),150) -- TODO: make the velocity a controllable thing.		
	end)

end)

--Hi! I bet you're a wonderful person. Have a great life! ~ Bigbadbob

