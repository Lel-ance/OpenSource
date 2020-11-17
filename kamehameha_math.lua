		power = function(target, beam, user)
			local core = beam.Core
			local maxDistBonus = 700
			local distFromCore = math.clamp((target.Character.HumanoidRootPart.Position - core.Position).magnitude, 1, maxDistBonus)
      local PLAYER_LEVEL
			local lvlMult = math.clamp(PLAYER_LEVEL, 4, math.huge) or 4
			local base = 80
			return math.abs(base*lvlMult/2)+((maxDistBonus-distFromCore)*(PLAYER_LEVEL < 4 and PLAYER_LEVEL or lvlMult)*.8)
		end
