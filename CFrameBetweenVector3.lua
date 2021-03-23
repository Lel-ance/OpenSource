local V3 = Vector3.new
return function(P0, P1)
	local V0, V1 = P0.Position, P1.Position
	return CFrame.fromMatrix(V0,(V0-V1).Unit:Cross(V3(0,1,0)),(V0-V1).Unit:Cross(V3(0,1,0)):Cross((V0-V1).Unit))*CFrame.Angles(0,math.pi/2,0)
end

--[[
Example Usage:
local CFrameBetweenV3 = require(script.CFrameBetweenV3)
workspace.Visualizer.CFrame = CFrameBetweenV3(workspace.a, workspace.b)
]]
