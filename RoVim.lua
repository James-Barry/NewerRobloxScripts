--[[RoVim. Made by bigbadbob234. Enjoy!]]

ply = game.Players.LocalPlayer
mouse = ply:GetMouse()
char = ply.Character -- WaitFor/ repeat until...
cam = workspace.CurrentCamera
cam:clearAllChildren() -- just for now?
t = char.Torso
mr = math.random
V3, CF, CA, C3, UD = Vector3.new, CFrame.new, CFrame.Angles, Color3.new, UDim2.new
ss = string.sub
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
	local fr = Instance.new("Frame")
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
	local fr = Instance.new("ScrollingFrame")
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
	local fr = Instance.new("ImageButton")
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
	fr.Name = "Skies"
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
	fr.Name = "Skies"
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



--[[ Properties ]]

--All the properties.
Properties = {"Name","Parent","RobloxLocked","archivable","className","AttachmentForward","AttachmentPos",
"AttachmentRight","AttachmentUp","BackendAccoutrementState","AnimationId","EditorFont","EditorFontSize","EditorTabWidth",
"ShowDepricatedObjects","ShowPreliminaryObjects","TextureId","ActivationState","BackendToolState","Enabled","Grip",
"GripForward","GripPos","GripRight","GripUp","TeamColor","Active","DeselectedConnectionCount",
"ReplicatedSelectedConnectionCount","BinType","Version","ShowDevelopmentGui","Disabled","LinkedSource","Source",
"P","angularvelocity","HeadColor","LeftArmColor","LeftLegColor","RightArmColor","RightLegColor",
"TorsoColor","force","D","cframe","maxTorque","maxForce","position",
"location","velocity","Value","CameraSubject","CameraType","CoordinateFrame","Focus",
"BaseTextureId","BodyPart","MeshId","OverlayTextureId","FrontendMouseClick","MaxActivationDistance","PantsTemplate",
"ShirtTemplate","BaseUrl","RequestQueueSize","Steer","Throttle","LODX","LODY",
"Offset","Scale","VertexColor","Bevel","Bulge","MeshType","MaxItems",
"AltCdnFailureCount","AltCdnSuccessCount","AvailablePhysicalMemory","BlockMeshSize","CPU","CdnFailureCount","CdnSuccessCount",
"CpuCount","CpuSpeed","DataModel","ElapsedTime","EnforceInstanceCountLimit","ErrorReporting","GfxCard",
"InstanceCount","InstanceCountLimit","IsFmodProfilingEnabled","IsProfilingEnabled","IsScriptStackTracingEnabled","JobCount","LastCdnFailureTimeSpan",
"LuaRamLimit","NameDatabaseBytes","NameDatabaseSize","OsPlatformId",
"OsVer","PageFaultsPerSecond","PageFileBytes","PixelShaderModel","PlayerCount","PrivateBytes","PrivateWorkingSetBytes",
"ProcessCores","ProcessorTime","ProfilingWindow","RAM","ReportExtendedMachineConfiguration","ReportSoundWarnings","Resolution",
"RobloxVersion","SignalConnects","SignalFires","SystemProductName","TickCountPreciseOverride","TotalPhysicalMemory","TotalProcessorTime",
"VertexShaderModel","VideoMemory","VirtualBytes","ConversationDistance","InUse","InitialPrompt","Purpose",
"Tone","ResponseDialog","UserDialog","ConstrainedValue","MaxValue","MinValue","BlastPressure",
"BlastRadius","Position","Face","Shiny","Specular","Texture","StudsPerTileU",
"StudsPerTileV","FaceId","InOut","LeftRight","TopBottom","Color","Heat",
"SecondaryColor","Description","Timeout","BubbleChatLifetime","BubbleChatMaxBubbles","ChatHistory","ChatScrollLength",
"CollisionSoundEnabled","CollisionSoundVolume","ImageUploadPromptBehavior","MaxCollisionSounds","SoftwareSound","SoundEnabled","VideoCaptureEnabled",
"VideoQuality","VideoUploadPromptBehavior","AbsolutePosition","AbsoluteSize","Adornee","ExtentsOffset","Size",
"SizeOffset","StudsOffset","BackgroundColor","BackgroundTransparency","BorderColor","BorderSizePixel","MouseEnterConnectionCount",
"MouseLeaveConnectionCount","MouseMovedConnectionCount","SizeConstraint","Visible","ZIndex","Style","AutoButtonColor",
"Selected","Image","Font","FontSize","Text","TextBounds","TextColor",
"TextTransparency","TextWrap","TextXAlignment","TextYAlignment","ScaleEdgeSize","SlicePrefix","ClearTextOnFocus",
"MultiLine","ReplicatingAbsolutePosition","ReplicatingAbsoluteSize","Transparency","Axes","MouseDragConnectionCount","Faces",
"TargetSurface","Humanoid","Part","Point","Health","Jump","LeftLeg",
"MaxHealth","PlatformStand","RightLeg","Sit","TargetPoint","Torso","WalkDirection",
"WalkSpeed","WalkToPart","WalkToPoint","BaseAngle","CurrentAngle","DesiredAngle","MaxVelocity",
"Hole","Time","Loop","Priority","Ambient","Brightness","GeographicLatitude",
"ShadowColor","TimeOfDay","DefaultWaitTime","GcFrequency","GcLimit","GcPause","GcStepMul",
"Hit","Icon","Origin","Target","TargetFilter","UnitRay","ViewSizeX",
"ViewSizeY","X","Y","Ticket","Port","DataMtuAdjust","ExperimentalPhysicsEnabled",
"IsQueueErrorComputed","IsThrottledByCongestionControl","IsThrottledByOutgoingBandwidthLimit","MaxDataModelSendBuffer","NetworkOwnerRate","PhysicsMtuAdjust","PhysicsReceive",
"PhysicsSend","PhysicsSendRate","PreferredClientPort","PrintEvents","PrintInstances","PrintPhysicsErrors","PrintProperties",
"ReceiveRate","ReportStatURL","ServerLocalScripts","WaitingForCharacterLogRate","Anchored","AlphaModifier","BackParamA",
"BackParamB","BackSurface","BackSurfaceInput","BottomParamA","BottomParamB","BottomSurface","BottomSurfaceInput",
"BrickColor","CFrame","CanCollide","Elasticity","Friction","FrontParamA","FrontParamB",
"FrontSurface","FrontSurfaceInput","LeftParamA","LeftParamB","LeftSurface","LeftSurfaceInput","Locked",
"Material","Reflectance","ResizeIncrement","ResizableFaces","RightParamA","RightParamB","RightSurface",
"RightSurfaceInput","RotVelocity","TopParamA","TopParamB","TopSurface","TopSurfaceInput","Velocity",
"formFactor","Shape","Controller","ControllingHumanoid","MoveState","StickyWheels","AllowTeamChangeOnTouch",
"Neutral","Sides","AreHingesDetected","HeadsUpDisplay","MaxSpeed","Torque","TurnSpeed",
"PrimaryPart","CurrentCamera","DistributedGameTime","AllowSweep","AreAnchorsShown","AreAwakePartsHighlighted","AreModelCoordsShown",
"AreOwnersShown","ArePartCoordsShown","AreRegionsShown","AreUnalignedPartsShown","AreWorldCoordsShown","IsReceiveAgeShown","ParallelPhysics",
"PhysicsEnviromentalThrottle","AccountAge","AccountAgeReplicate","Character","CharacterAppearance","DataComplexity","DataComplexityLimit",
"DataReady","MembershipType","SimulationRadius","userId","EnableReplication","IdleConnectionCount","KeyDownConnectionCount",
"KeyUpConnectionCount","MouseDelta","MouseHit","MouseOrigin","MousePosition","MouseTarget","MouseTargetSurface",
"MouseTargetFilter","MouseUnitRay","MoveConnectionCount","WheelBackwardConnectionCount","WheelForwardConnectionCount","WindowSize","BubbleChat",
"ClassicChat","LocalPlayer","MaxPlayers","NumPlayers","MaskWeight","Weight","PlayerGui",
"Browsable","Deprecated","Preliminary","summary","ExplorerImageIndex","ExplorerOrder","AASamples",
"AllowAmbientOcclusion","AluminumQuality","AlwaysDrawConnectors","Antialiasing","AutoFRMLevel","BatchSize","Bevels",
"CompoundMaterialQuality","CorrodedMetalQuality","DebugCullBlockCount","DebugDisableDebriService","DebugFRMCullHumanoids","DebugLogFRMLogVariables","DiamondPlateQuality",
"EagerBulkExecution","FrameRateManager","GrassQuality","IceQuality","IsAggregationShown","IsSynchronizedWithPhysics","PlasticQuality",
"QualityLevel","Shadow","ShowBoundingBoxes","SlateQuality","TextureCompositingEnabled","TrussDetail","WoodQuality",
"graphicsMode","CartoonFactor","MaxThrust","MaxTorque","TargetOffset","TargetRadius","ThrustD",
"ThrustP","TurnD","TurnP","GarbageCollectionFrequency","GarbageCollectionLimit","ScriptsDisabled","CreatorId",
"CreatorType","JobId","LocalSaveEnabled","PlaceId","Graphic","SkinColor","CelestialBodiesShown",
"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp","StarCount",
"Opacity","RiseVelocity","IsPaused","IsPlaying","Looped","Pitch","PlayCount",
"PlayOnRemove","SoundId","Volume","AmbientReverb","DistanceFactor","DopplerScale","RolloffScale",
"SparkleColor","AreArbitersThrottled","BudgetEnforced","Concurrency","NumRunningJobs","NumSleepingJobs","NumWaitingJobs",
"PriorityMethod","SchedulerDutyCycle","SchedulerRate","SleepAdjustMethod","ThreadAffinity","ThreadPoolConfig","ThreadPoolSize",
"ThrottledJobSleepTime","AutoAssignable","AutoColorCharacters","Score","MouseLock","ControlMode"}

function getProperties(obj)
	local props = {}
	for i,v in pairs(Properties) do
		if pcall(function() return obj[v] end) then
		table.insert(props, v)
	end
end
return props
end

function propertyGui(obj, fr)
	local myps = getProperties(obj)
	local newfr = Frame(fr, "Expl", UD(1,0,1,12), UD(0,0,0,0), C3(0,0,0), 1) 
	for i,v in ipairs(myps) do
		local tl1 = TextL(newfr, "txt", UD(1,-15,0,12), UD(0,0,0,i*12), C3(1,1,1), tostring(v), 1)
		tl1.TextColor3 = C3(1,1,0)
		tl1.TextXAlignment = 0
		local tl2 = TextL(newfr, "txt", UD(1,-15,0,12), UD(0,0,0,i*12), C3(1,1,1), tostring(obj[v]), 1)
		tl2.TextColor3 = C3(1,1,1)
		tl2.TextXAlignment = 1
		-- TextEdit instead?
	end
	return newfr
end

--[[ End properties]]

--[[ Basic text-edit functions ]]

-- these things aren't local for each vimwin right now, but they should be
czstack = {} 
custack = {} -- the ctrl+z/u-able strings, starts with either + or - 
registers = {} -- key = key, value = macro (table of keydowns)

local function moveCursor(cursor, vimWin, oldpos, newstrpos) -- TODO
	--if oldpos and shift-down, add to the selected string 
	cursor.Position = newstrpos
	return
end

local function deleteVimLine(vimWindow, lineNumber) -- test
	if vimWindow:findFirstChild("t"..lineNumber) then
		vimWindow["t"..lineNumber]:remove()
		for i,v in ipairs() do
		local k = tonumber(ss(v.Name,2))
			if k > lineNumber then
			v.Position = v.Position + UDim2.new(0,0,0,-12)
			v.Name = "t"..(k-1)
			end
		end
	end
end

function undo() 
	if #czstack>0 then
	-- move to the custack
	end
end

function redo()
	if #custack>0 then
	-- move to the czstack
	end	
end

function openLine()
	--
end


function highlight(start, fin) 	-- start/fin inclusive
	--	
end

--[[ End general text-edit functions]]

--[[ other vim functions ]]
options = {numbers = true, rnu = false, syntax = lua} 



angle = CA(0,0,0)
main = Part(cam, V3(5,5,5), CFrame.new((cam.CoordinateFrame*CF(0,0,-.5)).p)*angle, true, C3(.2,.5,.6), .5)
main.CanCollide = false
main.TopSurface = 0

sg = Instance.new("SurfaceGui",ply.PlayerGui) -- for RoVimrc
sg.Adornee = main
sg.Face = "Top"
sg.CanvasSize = Vector2.new(dist,dist) -- tweak me?
mainfr = Frame(sg, "Expl", UD(1,0,3,0), UD(0,0,0,0), C3(0,0,0), 1)

sg2 = Instance.new("SurfaceGui",ply.PlayerGui)
sg2.Adornee = main
sg2.Face = "Front"
sg2.CanvasSize = Vector2.new(500,500) -- tweak me?

mainfr2 = ScrollingFrame(sg2, "Expl", UD(.5,0,3,0), UD(0,0,0,0), C3(0,0,0), 1)

sg3 = Instance.new("SurfaceGui",ply.PlayerGui)
sg3.Adornee = main
sg3.Face = "Left"
sg3.CanvasSize = Vector2.new(500,500) -- tweak me?

mainfr3 = ScrollingFrame(sg3, "Expl2", UD(1,0,1,20), UD(0,0,0,0), C3(0,0,0), 1)

sg4 = Instance.new("SurfaceGui",ply.PlayerGui)
sg4.Adornee = main
sg4.Face = "Right"
sg4.CanvasSize = Vector2.new(500,500) -- tweak me?

mainfr4 = ScrollingFrame(sg4, "VimWin2", UD(1,0,1,20), UD(0,0,0,0), C3(0,0,0), 1)

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


explcols = {C3(.8,.8,.8),C3(1,.5,.5),C3(0,1,1),C3(0,1,0.5)}
expltype = {"Part","Model","Script","LocalScript"}
--explfns = {{properties, v, mainfr3},{properties, v, mainfr3},{vimWin, Source, mainfr3, nil},{vimWin, Source, mainfr3, nil}}

selected = nil
selectedProps = nil
selectedGui = nil

function explore(obj, fr, shift, propwindow) -- doesn't deal with deletions/insertions yet.
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
			if v ~= nil then
				if v.ClassName == "LocalScript" and v:findFirstChild("OpenSource") ~= nil then
					vimWin(v.OpenSource.Value, mainfr3, nil) --OpenSource.Value
					-- nml script will pr'bly have metatable set so that Source can't be seen.
					-- Is testing vimWin is a heinous crime? 
					-- prob's. :(.
					-- am bad human person.
				end
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
					explore(v, newfr, t2, propwindow)
				end
				if selected ~= nil then
					print("Making thing")
					selectedGui.TextColor3 = C3(1,1,1)
					for i2,v2 in ipairs(expltype) do
						if selected.ClassName == v2 then
							selectedGui.TextColor3 = explcols[i2]
						end
					end
					selectedProps:remove()
				end
				if propwindow then
					print("Making thing")
					selected = v
					selectedGui = tb
					selectedGui.TextColor3 = C3(1,1,0)
					selectedProps = propertyGui(v, propwindow)
				end
			else
				print("Thing is gone.")
			end
		end)
	end
end



function vimCollect(newfr)
	local bigstring = ""
	local tb = {}
	for i,v in ipairs(newfr:getChildren()) do
		local knm = tonumber(ss(v.Name,2))
		-- if  then -- make sure it's a normal txtbutton
		tb[knm] = v
		-- end
	end
	for i,v in ipairs(tb) do
		bigstring = bigstring..v	
	end
	return bigstring
end

function vimWin(str, fr, rc)
	fr:clearAllChildren()
	--for now, there is no .RoVimrc that does anything
	local newfr = Frame(fr, "RoVim", UD(1,0,1,-15), UD(0,0,0,0), C3(0,0,0), 1) 
	lnnum = ""
	count = 1
	str = "\n"..str -- for the lulz?
	lstp = UD(0,20,0,0)
	lstb = nil
	for i in string.gmatch(str, "\n[^\n]*") do
		lnnum = lnnum..count.."\n"
		count = count+1
		--newfr = ""
		-- look for & syntax-color keywords
		-- if num then
		local tb = TextBox(newfr, "t"..count, UD(1,0,0,12), lstp, C3(.5,.4,.5), i, 0.7)
		tb.Font = 5 -- source sans light
		tb.ClearTextOnFocus = false
		tb.MultiLine = false -- Do newlines manually.
		tb.BorderSizePixel = 0
		tb.TextColor3 = C3(1,1,1)
		tb.TextYAlignment = 2
		tb.TextXAlignment = 0
		lstp = tb.Position+UD(0,0,0,12)
	end
	if count < 100 then
		for i=count,100 do
			lnnum = lnnum.."~\n"
		end
	end
	local lineNums = TextB(newfr, "lntxt", UD(0,20,1,0), UD(0,0,0,0), C3(1,1,1), lnnum, 1)
	lineNums.TextColor3 = C3(1,1,0)	
	lineNums.TextYAlignment = 0
	lineNums.TextXAlignment = 0
	--
	runButton = TextB(fr, "txt", UD(.25,0,0,12), UD(0.625,0,1,-12), C3(0,.7,0), "Run script", 1)
	
	runButton = TextB(fr, "txt", UD(.25,0,0,12), UD(0.625,0,1,-12), C3(0,.7,0), "Run script", 1)
	runButton.MouseButton1Down:connect(function ()
		if NewScript then
		NewScript(vimCollect(newfr))
		end
	end)
	runLocalButton = TextB(fr, "txt", UD(.25,0,0,12), UD(0.125,0,1,-12), C3(0,.7,0), "Run local", 1)
	runButton.MouseButton1Down:connect(function ()
		if NewScript then
		NewLocalScript(vimCollect(newfr))
		end
	end)
	return newfr
end

local tb = TextB(mainfr2, "txt", UD(1,0,1,0), UD(0,0,0,0), C3(1,1,1), "Explorer", 1)
tb.TextColor3 = C3(0.5,1,1)
tb.TextXAlignment = 2
tb.TextYAlignment = 0

mainprops = ScrollingFrame(sg2, "Properties", UD(0.5,0,1,0), UD(.5,0,0,0), C3(.5,.5,.5), 0.5)

explore(game.Workspace, mainfr2, {}, mainprops)

vimWin("Hello\nWorld", mainfr3, nil)

-- one-time get workspace parts, and after that use DescendentAdded to update the tracked parts

game:getService("RunService").RenderStepped:connect(function()
	main.CFrame = CFrame.new((cam.CoordinateFrame*CF(0,0,-7)).p)*angle
	-- update
end)

os = Instance.new("StringValue",script)
os.Name = "OpenSource"
os.Value = [[
function vimWin(str, fr, rc)
	fr:clearAllChildren()
	--for now, there is no .RoVimrc that does anything
	local newfr = Frame(fr, "RoVim", UD(1,0,1,0), UD(0,0,0,0), C3(0,0,0), 1) 
	lnnum = ""
	count = 1
	str = "\n"..str -- for the lulz?
	lstp = UD(0,20,0,0)
	for i in string.gmatch(str, "\n[^\n]*") do
		print("Didathang")
		lnnum = lnnum..count.."\n"
		count = count+1
		--newfr = ""
		-- look for & syntax-color keywords
		local tb = TextB(newfr, "t"..count, UD(1,0,0,12), lstp, C3(.5,.4,.5), i, 0.7)
		tb.TextColor3 = C3(1,1,1)
		tb.TextYAlignment = 2
		tb.TextXAlignment = 0
		lstp = tb.Position+UD(0,0,0,12)
	end
	if count < 100 then
		for i=count,100 do
			lnnum = lnnum.."~\n"
		end
	end
	local lineNums = TextB(newfr, "txt", UD(0,20,1,0), UD(0,0,0,0), C3(1,1,1), lnnum, 1)
	lineNums.TextColor3 = C3(1,1,0)	
	lineNums.TextYAlignment = 0
	lineNums.TextXAlignment = 0
	--
	return newfr
end
]]



--script.Source -- ie, this script's source. The http wasn't working.
-- I am not doing the dirt-bag thing and looking at other scripts... quite the opposite.

--[[----------------------------------------------------------
Hi! I bet you're a wonderful person. Have a great life! :D
	~bbb
----------------------------------------------------------]]--

