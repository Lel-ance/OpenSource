-- RateLimitV2
-- Rewrite of V1, new "refreshWhenCalled" functionality, OOP based.

local RateLimit = {
	Class = {},
	Nested = {}
}

RateLimit.Class.__index = RateLimit.Class

local DEFAULTS = {
	COOLDOWN = 5
}

local MESSAGES = {
	ASSERTION_ERROR = ("RiyLimit: Invalid Parameter: %s")
}

function RateLimit:new(Name, Cooldown, refreshWhenCalled)
	assert(typeof(Name) == 'string', MESSAGES.ASSERTION_ERROR:format(("[:new] 'Name' Expected string got %s"):format(typeof(Name))))
	if not Cooldown then
		Cooldown = DEFAULTS.COOLDOWN
	end
	assert(Cooldown, MESSAGES.ASSERTION_ERROR:format(("[:new] Expected some form of cooldown, not passed nor is a default set")))
	assert(typeof(Cooldown) == 'number', MESSAGES.ASSERTION_ERROR:format(("[:new] 'Cooldown' Expected number got %s"):format(typeof(Cooldown))))
	assert(not self.Nested[Name], MESSAGES.ASSERTION_ERROR:format(("[:new] %s is already hooked up in the rate limiter"):format(Name)))
	local Created = setmetatable({
		_name = Name,
		_cooldown = Cooldown,
		_refreshOnCall = refreshWhenCalled or false,
		
		_stored = setmetatable({}, {__mode = 'k'})
	}, self.Class)
	self.Nested[Name] = Created
	return Created
end

function RateLimit.Class:add(Player)
	assert(self._name, MESSAGES.ASSERTION_ERROR:format(("[:add] Expected the method to be used on a RateLimit class, got direct call")))
	assert(Player, MESSAGES.ASSERTION_ERROR:format(("[:add] Expected a player to be passed, got nil")))
	
	if not self._stored[Player] then
		self._stored[Player] = tick()
		return false
	end
	local CompareTime, CurrentTime = self._stored[Player], tick()
	local LimitNumber = self._cooldown

	if (CurrentTime - CompareTime) <= LimitNumber then
		if self._refreshOnCall then
			self._stored[Player] = tick()
		end
		return true
	else
		self._stored[Player] = tick()
	end
	return false
end

function RateLimit.Class:remove(Player)
	assert(self._name, MESSAGES.ASSERTION_ERROR:format(("[:remove] Expected the method to be used on a RateLimit class, got direct call")))
	assert(Player, MESSAGES.ASSERTION_ERROR:format(("[:remove] Expected a player to be passed, got nil")))
	pcall(function() self._stored[Player] = nil  end)
end

function RateLimit.Class:New(...) return self:new(...) end
function RateLimit.Class:Add(...) return self:add(...) end
function RateLimit.Class:Remove(...) return self:remove(...) end

return RateLimit
