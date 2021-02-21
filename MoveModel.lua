-- Lelance @ Sun. 21 Feb. 2021
-- Script: Move model
-- Based off Sleitnick made somewhere

local function newCFrameModel(model)
	local Primary
	if model.ClassName == 'Model' then
		Primary = model.PrimaryPart
	else
		Primary = model
	end
	local PrimaryCFrame = Primary.CFrame
	local Cache = {}
	local Connection

	for _, d in next, model:GetDescendants() do
		if (d:IsA("BasePart") or d:IsA("MeshPart") or d:IsA("UnionOperation") and d ~= Primary) then
			Cache[d] = PrimaryCFrame:ToObjectSpace(d.CFrame)
		end
	end

	Connection = model.DescendantAdded:Connect(function(d)
		if model == nil then
			Connection:Disconnect()
			return
		end
		if (d:IsA("BasePart") or d:IsA("MeshPart") or d:IsA("UnionOperation") and d ~= Primary) then
			Cache[d] = PrimaryCFrame:ToObjectSpace(d.CFrame)
		end
	end)

	local mt
	mt = setmetatable({
		Recache = function()
			Cache = {}
			for _, d in next, model:GetDescendants() do
				if (d:IsA("BasePart") or d:IsA("MeshPart") or d:IsA("UnionOperation") and d ~= Primary) then
					Cache[d] = PrimaryCFrame:ToObjectSpace(d.CFrame)
				end
			end
			return mt
		end
	}, {
		__call = function(_, cf, exempt)
			local exempt = type(exempt) == 'table' and exempt
			local c = Cache
			if exempt then
				for o in next, c do
					if exempt[o] then
						c[o] = nil
					end
				end
			end
			Primary.CFrame = cf
			for p, off in next, Cache do
				p.CFrame = cf * off
			end				
		end
	})
	return mt
end

-- // Example Usage

local Model = workspace.Model
local Bases = newCFrameModel(Model)
local PrimaryCF = Model.PrimaryPart.CFrame
local NewCF = PrimaryCF + PrimaryCF.LookVector * 50
Bases(NewCF)
