--[[--------------------------------------------------
Morse code thing! made by bigbadbob234
----------------------------------------------------]]

speed = .5 -- inverse seconds. 1 second ~ len for 1 dah

ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character
cam = workspace.CurrentCamera
mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new

ss = string.sub
sl = string.len
sb = string.byte
sc = string.char

abcs = "abcdefghijklmnopqrstuvwxyz"
abs = {"ab","baa","baba","baa","a","aaba","bba","aaaa","aa","abbb","bab","abaa","bb","ba","bbb","abba","bbab","aba","aaa","b","aab","aaab","abb","baab","babb","bbaa"}

-- Beginning of basic functions 

function Frame(par, name, siz, pos, col, trans)
	local fr = Instance.new("Frame")
	fr.Parent = par
	fr.Size = siz
	fr.Position = pos
	fr.BackgroundColor3 = col
	fr.BackgroundTransparency = trans
	fr.ClipsDescendants = true
	fr.Name = "Frame"
	return fr
end

function ImageB(par, name, siz, pos, col, img, trans)
	local fr = Instance.new("ImageButton")
	fr.Parent = par
	fr.Size = siz
	fr.Position = pos
	fr.BackgroundColor3 = col
	fr.Image = img
	fr.BackgroundTransparency = trans
	fr.Name = "Frame"
	fr.AutoButtonColor = false
	return fr
end

function ImageL(par, name, siz, pos, col, img, trans)
	local fr = Instance.new("ImageLabel")
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
	local fr = Instance.new("TextButton")
	fr.Parent = par
	fr.Size = siz
	fr.Position = pos
	fr.BackgroundColor3 = col
	fr.Text = txt
	fr.BackgroundTransparency = trans
	fr.Name = "Frame"
	fr.AutoButtonColor = false
	return fr
end

function TextBox(par, name, siz, pos, col, txt, trans)
	local fr = Instance.new("TextBox")
	fr.Parent = par
	fr.Size = siz
	fr.Position = pos
	fr.BackgroundColor3 = col
	fr.Text = txt
	fr.BackgroundTransparency = trans
	fr.Name = "Frame"
	return fr
end

function TextL(par, name, siz, pos, col, txt, trans)
	local fr = Instance.new("TextLabel")
	fr.Parent = par
	fr.Size = siz
	fr.Position = pos
	fr.BackgroundColor3 = col
	fr.Text = txt
	fr.BackgroundTransparency = trans
	fr.Name = name
	return fr
end

-- End of basic functions 

function morseToNorm(str)
bl = false
	for i,v in ipairs(abs) do
		if str == v then
		bl = true
		return ss(abcs,i,i)
		end
	end
	if not bl then
	print("Oh noes! You fail'd at doing a thing.")
	end
return ""
end

function normToMorse(str)
	--
end

sg = Instance.new("ScreenGui",ply.PlayerGui)
sg.Name = "MorseThing"

fr = Frame(sg, "Main", UD(0,200,0,400), UD(1,-200,1,-400), C3(0,.2,.2), .5)
imgfr = ImageL(fr, "Imagething", UD(1,0,0,300), UD(0,0,0,0), C3(1,1,1), "rbxassetid://313709213", .5)

txt0 = TextL(fr, "text0", UD(1,0,0,20), UD(0,0,0,300), C3(0,.2,.2), "", 1)
txt0.TextColor3 = C3(1,1,1)
txt0.FontSize = "Size18"
txt1 = TextL(fr, "text1", UD(1,0,0,20), UD(0,0,0,320), C3(0,.2,.2), "Morse: ", 1)
txt1.TextColor3 = C3(1,1,1)
txt1.FontSize = "Size18"
txt2 = TextL(fr, "text2", UD(1,0,0,20), UD(0,0,0,340), C3(0,.2,.2), "English: ", 1)
txt2.TextColor3 = C3(1,1,1)
txt2.FontSize = "Size18"
fr1 = Frame(fr, "back1", UD(1,0,0,50), UD(0,0,0,360), C3(0,.3,.6), 0)
fr2 = Frame(fr, "back2", UD(1,0,0,50), UD(0,0,0,360), C3(0,.2,.4), 0.5)
fr3 = Frame(fr, "mark1", UD(0,2,0,50), UD(0.5,0,0,360), C3(0,.5,.7), 0)

stopped = true
qdown = false
oldStr = ""
str = ""
oldmStr = ""
mstr = ""
thischar = ""
sinwav = Instance.new("Sound",char.Torso)
sinwav.SoundId = "rbxassetid://148644432"
sinwav.Looped = true

local tl = tick()

function updateTxts()
	txt0.Text = thischar
	txt1.Text = "Morse: "..mstr
	txt2.Text = "English: "..str
end

mouse.KeyDown:connect(function (key)
	if key == "q" then
	sinwav:Play()
	qdown = true
	stopped = false
	-- play sinwav
	-- update img
	tn = tick()
	tm = (t-tl)/speed
	tl = tn
	if tm < .5 then
		--jus' nother di/ah
	elseif tm < 1 then
		--new char
		str = str..morseToNorm(thischar)
		mstr = mstr.."/"..thischar
		thischar = ""
	elseif tm < 2 then
		str = str..morseToNorm(thischar).." "
		mstr = mstr.."/"..thischar.."  "
		thischar = ""
		--new word
	else
		oldmStr = mstr
		oldStr = str
		str = ""
		mstr = ""
		thischar = ""
		--new string
	end
	updateTxts()
	end
end)

mouse.KeyUp:connect(function (key)
	if key == "q" then
	qdown = false
	--stop sinwav
	-- stoptag
	tn = tick()
	tm = (t-tl)/speed
	tl = tn
	if tm < .5 then
		thischar = thischar.."a"
--		mstr = mstr.."a"
	else
		repeat
		thischar = thischar.."b"
--		mstr = mstr.."b"
		tm = tm-1
		until tm < .5
	end
	updateTxts()
	sinwav:Pause()
	end
end)

game:getService("RunService").Stepped:connect(function ()
	t = tick()
	local tm = (t-tl)/speed
	if qdown then
		fr2.Size = UD(0,0,0,50)
		if tm < 1 then
		fr1.Size = UD(tm,0,0,50)
		else		
		fr1.Size = UD(1,0,0,50)		
		end
	elseif not stopped then 
		fr1.Size = UD(0,0,0,50)
		if tm < 1 then
		fr2.Size = UD(tm,0,0,50)
		-- new char
		elseif tm > 3 then
		stopped = true

		updateTxts()
		else
		fr2.Size = UD(1,0,0,50)		
		-- update img
		-- put together string.
		end
	end
end)

