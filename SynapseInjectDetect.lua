-- Lelance // Made this some time in the early summer of 2020, didn't release though
-- Will be inaccurate because it does it based on Client Memory Usage

local Client = game.Players.LocalPlayer
local Stats = game:GetService('Stats')
spawn(function()
    while wait() do
        local CurrentUsage = Stats:GetTotalMemoryUsageMb()
        if CurrentUsage > 400 then
            Client:Kick'exploit inject lol'
            break
        end
        wait(2.5)
    end
end)
