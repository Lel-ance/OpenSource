local CSV = {}

function CSV:getLines(str: string)
    local lines = {}
    for line in str:gmatch("(.-)\n") do
        table.insert(lines, line)
    end
    return lines
end

function CSV:Convert(import: string)
    local Lines = self:getLines(import)
    local FirstLine = Lines[1]
    local Converted = {}
    table.remove(Lines, 1)
    local SeperatedValues = FirstLine:split(",")
    warn(table.concat(SeperatedValues, " : "))
    for num, l in next, Lines do
        local split = l:split(",")
        local asTable = {}
        for i, v in next, split do
            local according = SeperatedValues[i]
            asTable[according] = v
        end
        Converted[num] = asTable
    end
    return Converted
end

return CSV

-- Usage:
local CSV = require(script.CSV)
local test = [[#,Name,Type 1,Type 2,Total,HP,Attack,Defense,Sp. Atk,Sp. Def,Speed,Generation,Legendary
1,Bulbasaur,Grass,Poison,318,45,49,49,65,65,45,1,False]]
CSV:Convert(test)

-- Output:
--[[
                    ["#"] = "1",
                    ["Attack"] = "49",
                    ["Defense"] = "49",
                    ["Generation"] = "1",
                    ["HP"] = "45",
                    ["Legendary"] = "False",
                    ["Name"] = "Bulbasaur",
                    ["Sp. Atk"] = "65",
                    ["Sp. Def"] = "65",
                    ["Speed"] = "45",
                    ["Total"] = "318",
                    ["Type 1"] = "Grass",
                    ["Type 2"] = "Poison"
]]
