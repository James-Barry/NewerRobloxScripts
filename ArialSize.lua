--[[
Just a simple thing that gives you the approx size of the arial font.
getSize(string, fontSize) --> approx x pixelnumbers.

Btw, this is redundant. You can use "TextLabel.TextBounds" 
to get a Vector2 for how big the text is in the TextLabel.
Yep. That's the better way.
]]

la = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!?. ,-'"
ln = {
08,8.25,8,08,08,04,		-- a..
08,08,04,04,07,04.5,	-- g..
13,08,08,08,08,05.5,	-- m..
08,04,08,07,11,07,		-- s..
07,07,10,10,11,11,		-- y..
10,09,12,11,04,08,		-- E..
10,08,12,11,12,10,		-- K..
12,11,10,10,11,10,		-- Q..
15,10,10,10,05,08,		-- W..
03,04,05,05,03,08		-- ...
} -- May need tweaking
-- Approx x-pixels _for arial at height 16_.

ss = string.sub
sf = string.find
myFontSize = 32

function getSize(str,fontSize) -- takes a string [and fontSize] and returns the estimated x.size
	fontSize = fontSize or 12
	local sum = 0
	for letter in string.gmatch(str,"\.") do
		sum = sum + ln[sf(la,letter)]*fontSize/16 -- breaks on not-specified symbols/nums
	end
	return sum
end
	
--[[--------------------------
Below things used for testing.
----------------------------]]

-- tested using localscript in TextLabel.
sp = script.Parent 
sp.Changed:connect(function()
	sp.Size = UDim2.new(0,getSize(sp.Text,myFontSize),0,myFontSize)
end)

for v in string.gmatch(la,"\.") do -- test all the letters
	sp.Text = "l"..string.rep(v,25).."l"
	wait(.25)
end

--[[
Baby pandas,
	~bigbadbob234
]]
