--[[Dvk to Qwerty. Made by bigbadbob234. Enjoy!]]

ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character -- WaitFor/ repeat until...
cam = workspace.CurrentCamera
cam:clearAllChildren() -- just for now?
h = char.Head
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



--for i,v in ipairs(game.Players:getChildren()) do
local sg = Instance.new("BillboardGui", h)
sg.Adornee = h
sg.Size = UD(0,200,0,20)
sg.StudsOffset = V3(0,3,0)
mainfr = Frame(sg, "Talk", UD(0,200,0,30), UD(0,0,0,0), C3(0,0,0), 1)

tl = TextL(mainfr, "txt", UD(1,0,1,0), UD(0,0,0,0), C3(0,0,0), "", 0.6)
tl.TextColor3 = C3(0.5,1,1)
tl.TextXAlignment = 2
tl.TextYAlignment = 0
tl.FontSize = "Size12"
tl.TextWrapped = true

dvk = [[',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz"<>PYFGCRL?+AOEUIDHTNS_:QJKXBMWVZ! = ]]
nml = [[qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?! = ]]

for i=0,9 do
	dvk = dvk..i
	nml = nml..i
end

function transl(msg)
local nws = ""
	for i = 1, string.len(msg) do
		for j = 1, string.len(nml)-1 do
		if string.sub(nml,j,j) == string.sub(msg,i,i) then
		nws = nws..string.sub(dvk,j,j)
		end
		end
	end
return nws
end

ply.Chatted:connect(function (msg)
--if string.sub(msg, 1) == "/" then
	local m = transl(msg)
--	else
--	m = msg
--end
	tl.Text = "bbb:"..m
end)

--[[----------------------------------------------------------
    Hi! I bet you're a wonderful person. Have a great life! :D
    ----------------------------------------------------------]]--

