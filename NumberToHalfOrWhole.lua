local function FillUpRating(Amnt)
	local AmountOfFullRatings = Amnt%1 == 0 and math.ceil(Amnt) or math.ceil(Amnt) - 1
	local AmountOfHalfRatings = Amnt%1 == 0 and 0 or 1
	
	warn("INPUT: " .. tostring(Amnt) .. " Full Ratings: " .. AmountOfFullRatings .. " | Half Ratings: " .. AmountOfHalfRatings)
  return AmountOfFullRatings, AmountOfHalfRatings
end

-- Testing: 
local TestWith = {1,1.5,1.75,2,2.34}
table.foreach(TestWith, function(_, a) FillUpRating(a) end)
