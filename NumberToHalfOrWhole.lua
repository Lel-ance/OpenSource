local function FillUp(Amnt)
	local AmountOfFull = Amnt%1 == 0 and math.ceil(Amnt) or math.ceil(Amnt) - 1
	local AmountOfHalf = Amnt%1 == 0 and 0 or 1
	
	warn("INPUT: " .. tostring(Amnt) .. " Whole: " .. AmountOfFull .. " | Half: " .. AmountOfHalf)
  return AmountOfFull, AmountOfHalf
end

-- Testing: 
local TestWith = {1,1.5,1.75,2,2.34}
table.foreach(TestWith, function(_, a) FillUp(a) end)
