-- Lelance @ Sun. 14 Feb. 2021
-- Script: Class function - make OOP easy.
-- Inspiration from JavaScript's Class method.
local function Class(preset: table)
	local Proxy = newproxy(true)
	local Meta = getmetatable(Proxy)
	Meta.__len = function()
		local class = {}
		class.__index = class
		setmetatable(type(preset[1]) == 'table' and preset[1] or {}, class)
		function class:new(...)
			local newClass = class
			local func
			if (typeof(preset[1]) == 'function') then
				func = preset[1]
			elseif (typeof(preset[2]) == 'function') then
				func = preset[2]
			else
				func = function(self)
					return self
				end
			end
			return func(newClass, ...)
		end
		return class
	end
	return Proxy
end

-- Example usage:

local ret = #Class {{}, function(self, passed)
	self.pass = passed
	warn(self.pass)
	return self
end}

local new = ret:new 'yay'
function new:cool()
	return 'nice'
end

warn(new:cool())
