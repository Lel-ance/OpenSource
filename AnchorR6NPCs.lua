-- Lelance @ Wed. 28 Oct. 2020
-- Script: Anchor all R6 npcs

-- Paste into command line and execute it (will work in a script too, but command line is more sufficient)
local collideData = {
    Head = true,
    HumanoidRootPart = false,
    ['Left Arm'] = false,
    ['Left Leg'] = false,
    ['Right Arm'] = false,
    ['Right Leg'] = false,
    Torso = true
}

local AnchoredData = {
    Head = false,
    HumanoidRootPart = true,
    ['Left Arm'] = false,
    ['Left Leg'] = false,
    ['Right Arm'] = false,
    ['Right Leg'] = false,
    Torso = false
}

game:GetService("ChangeHistoryService"):SetWaypoint("FixNPCs")
for _, v in next, workspace:GetDescendants() do
    if v:FindFirstChild'HumanoidRootPart' and v:FindFirstChild'Head' then
        pcall(function()
            for _, v2 in next, v:GetChildren() do
                if collideData[v2.Name] ~= nil then
                    v2.CanCollide = collideData[v2.Name]
                end
                if AnchoredData[v2.Name] ~= nil then
                    v2.Anchored = AnchoredData[v2.Name]
                end
            end
        end)
    end
end
