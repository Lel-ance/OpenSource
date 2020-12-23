local ChessBoard = game.StarterGui.Main.Chessboard

local Odd, Even = Color3.fromRGB(86, 83, 59), Color3.fromRGB(59, 52, 47)

local Orders = {'a','b','c','d','e','f','g','h'}

local lastColor = 'Even'

for i = 1,64 do
	local FlooredDiv = (math.ceil(i/8)<1) and 1 or math.ceil(i/8)
	local Remainder = i%8+1
	local Letter = Orders[FlooredDiv]
	local newFrame = Instance.new('Frame')
	newFrame.Name = Letter:upper()..Remainder
	newFrame.BackgroundColor3 = Remainder == 1 and (lastColor == 'Even' and Odd or Even) or (lastColor == 'Odd' and Odd or Even)
	if Remainder ~= 8 then
		lastColor = lastColor == 'Odd' and 'Even' or 'Odd'
	end
	newFrame.Parent = ChessBoard
end
