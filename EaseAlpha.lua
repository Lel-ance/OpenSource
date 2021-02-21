-- Lelance @ Sun. 21 Feb. 2021
-- Script: Ease name to alpha function
local Timings = {}
local TweenService = game:GetService('TweenService')

function Timings.try(name: string)
	if not name then return false end
	name = name:lower()
	local _dir, _style
	if name:find('ease') then
		name = name:split('ease')[2]
	end
	for _, dir in next, Enum.EasingDirection:GetEnumItems() do
		local str = tostring(dir):split('Enum.EasingDirection.')[2]:lower()
		if name:find(str) then
			_dir = dir
			name = name:split(str)[2]
			break
		end
	end
	for _, style in next, Enum.EasingStyle:GetEnumItems() do
		local str = tostring(style):split('Enum.EasingStyle.')[2]:lower()
		if name == str then
			_style = style
			break
		end
	end
	
	return function(alpha)
		return TweenService:GetValue(alpha, _style, _dir)
	end
end

-- Example Usage:
local TestWith = .6
local EaseStyle = 'easeInCubic'
local AlphaFunction = Timings.try(EaseStyle)
warn(("New Alpha: %s"):format(AlphaFunction(TestWith)))
