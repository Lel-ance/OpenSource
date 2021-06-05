	local function prefixZero(str, base)
		if not base then base = 3 end
		local str = tostring(str)
		if #str >= base then return str end
		local quantity = base-#str
		return ('0'):rep(quantity)..str
	end

-- // Can be used to auto-fill empty spaces
-- prefixZero(65, 3) -> 065
-- prefixZero(125, 5) -> 00125
-- etc.
