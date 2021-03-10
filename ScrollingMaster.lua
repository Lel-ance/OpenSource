-- Module for auto-scaling scrolling frames
local ScrollingMaster = {}
ScrollingMaster.Debugging = false

function ScrollingMaster:Exists(Frame)
	if not self.Listening then self.Listening = {} end
	return self.Listening[Frame] ~= nil
end

function ScrollingMaster:isSF(SF: any)
	local s, e = pcall(function()
		return SF.ClassName == 'ScrollingFrame'
	end)
	if s and e and SF.ClassName == 'ScrollingFrame' then return true end
	return false
end

function ScrollingMaster:ClearConnections(t: table)
	if not typeof(t) == 'table' then return end
	for _, c in next, t do
		pcall(c.Disconnect, c)
	end
end

function ScrollingMaster:SetupConnections(SF)
	local Connections = {}
	local Grid_Or_List = (SF:FindFirstChildOfClass('UIGridLayout') and SF:FindFirstChildOfClass('UIGridLayout').Name)
		or (SF:FindFirstChildOfClass('UIListLayout') and SF:FindFirstChildOfClass('UIListLayout').Name) or false
	if Grid_Or_List == false then
		if self.Debugging then
			warn('ScrollingMaster:SetupConnections: invalid call. Scrolling frame has no UIListLayout/UIGridLayout')
		end
		return {}
	end
	Grid_Or_List = SF[Grid_Or_List]
	
	local function refresh()
		local ABSCS = Grid_Or_List.AbsoluteContentSize
		SF.CanvasSize = UDim2.new(0, 0, 0, math.ceil(ABSCS.Y))
	end
	
	refresh()
	return {Grid_Or_List:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(refresh)}
end

function ScrollingMaster:onStartup()
	if not self.Listening then self.Listening = {} end
end

function ScrollingMaster:ClearAllConnections()
	if not self.Listening then self.Listening = {} end
	for _, c in next, self.Listening do
		self:ClearConnections(c)
	end
	self.Listening = {}
end

function ScrollingMaster:Disconnect(ScrollingFrame: instance)
	if not self.Listening then self.Listening = {} end
	local Connection = self.Listening[ScrollingFrame]
	if not Connection then return end
	self:ClearConnections(Connection)
	self.Listening[ScrollingFrame] = nil
end

function ScrollingMaster:Add(ScrollingFrame: instance)
	if not self:isSF(ScrollingFrame) then return end
	if not self.Listening then self.Listening = {} end
	if self:Exists(ScrollingFrame) then return end
	self.Listening[ScrollingFrame] = self:SetupConnections(ScrollingFrame)
end

ScrollingMaster:onStartup()
return ScrollingMaster
