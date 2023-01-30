
local Wife <const> = {kill = {},marry = {}}
Wife.__index = Wife
_ENV = Wife

local function crazyKillFail(plinkett,rand)
	plinkett:adjustScore(-55)
	plinkett:changePoliceChance(10)
	plinkett.policeMessage = {wife = "Your wife called the police after you tried to make her have an accident.\n"}
	return true,"You tired to do what the pizza rolls want you to do, but your wife ran away.\n",plinkett:adjustBrainValue(-5,rand)
end

local function crazyKill(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:changePoliceChance(3)
	plinkett.wife = false
	plinkett:killWife()
	plinkett.policeMessage.wife = "The police found your wife's dismembered body.\n"
	return true,"You did what the pizza roll told you to do.\n",plinkett:adjustBrainValue(-3,rand)
end

local function successKill(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:changePoliceChance(2)
	plinkett.wife = false
	plinkett:killWife()
	plinkett.policeMessage.wife = "The police investigated your wife's accident and found it very suspicious.\n"
	return true,"Your wife just had an unrelated accident.\n",plinkett:adjustBrainValue(-2,rand)
end

local function lucidFailed(plinkett)
	plinkett:adjustScore(-55)
	plinkett:changePoliceChance(10)
	plinkett.policeMessage = {wife = "Your wife called the police to report what you tried to do.\n"}
	return true,"You had a lucid moment and realized what you were trying to do. Your wife calls the police\n"
end

local function failedKill(plinkett,rand)
	plinkett:adjustScore(-10)
	return true,"Your wife unfortunately failed to have an accident.\n",plinkett:adjustBrainValue(-1,rand)
end

Wife.kill[false] = {
	crazyKill,crazyKill,crazyKill,crazyKill,failedKill,failedKill,failedKill,crazyKillFail,crazyKill
}

Wife.kill[true] = {
	successKill,successKill,successKill,successKill,failedKill,failedKill,failedKill,lucidFailed,lucidFailed
}

local function noMoneyCrazy(plinkett,rand)
	plinkett:adjustScore(-10)
	return true,"You got kicked out of the casino for trying to use monopoly money.Before you left they gave you the boots, medium style.\n",plinkett:adjustBrainValue(-1,rand)
end

local function noMoneyMarriage(plinkett, rand)
	plinkett:adjustScore(25)
	plinkett.wife = true
	return true,"You have no money, but a cocktail waitress heard your incoherent babbling and took pity on you and got married to you.\n",plinkett:adjustBrainValue(1,rand)
end

local casinoNoMoneyCrazy <const> = { noMoneyMarriage, noMoneyMarriage, noMoneyCrazy, noMoneyCrazy, noMoneyCrazy}

local function lucidMarriage(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett.wife = true
	return true,"You met a cocktail waitress at the casino.You shared some of your pills with her and in her inebriated state you two get married.\n",plinkett:adjustBrainValue(1,rand)
end

local function lucidGamble(plinkett,rand)
	plinkett:adjustScore(20)
	plinkett:adjustMoney(20)
	return true,"You went to the trump casino and won 20 dollars playing the slots.\n",plinkett:adjustBrainValue(1,rand)
end

local function lucidFailedMarriage(plinkett,rand)
	plinkett:adjustScore(-10)
	return true,"You went to the casino hoping to get lucky, you neither won any money nor did you meet any women.\n",plinkett:adjustBrainValue(-1,rand)
end

local function lucidFailedGamble(plinkett,rand)
	plinkett:adjustScore(-10)
	plinkett:adjustMoney(-10)
	return true,"You went to the casino and lost 10 dollars playing slots.\n",plinkett:adjustBrainValue(-1,rand)
end

local function lucidExtremeGable(plinkett,rand)
	plinkett:adjustScore(35)
	plinkett:adjustMoney(35)
	return true,"You went to the trump casino and somehow managed to win 35 dollars at blackjack without even playing the game.\n",plinkett:adjustBrainValue(1,rand)
end

local function lucidExtremeMarriage(plinkett,rand)
	plinkett:adjustScore(35)
	plinkett:adjustMoney(10)
	plinkett.wife = true
	return true,"You won 10 dollars playing bingo and also managed to catch the eye of the cocktail waitress. You two had a real vegas wedding.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyMarriage(plinkett,rand)
	plinkett:adjustScore(35)
	plinkett:adjustMoney(-10)
	plinkett.wife = true
	return true,"You got lost and ended up at the indian casino, you lost 10 dollars there. The drunken cocktail waitress took pity on such a crazy old man and you two got married.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyGamble(plinkett,rand)
	plinkett:adjustScore(20)
	plinkett:adjustMoney(10)
	return true,"You got lost on the way to the trump casino and ended up at the indian casino. You won 10 dollars playing indian poker with them.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyFailedMarriage(plinkett,rand)
	plinkett:adjustScore(-20)
	return true,"You tried to hit it off with the cocktailwaitress, but you wewre too crazy even for a drunken crack addicted casino waitress.\n",plinkett:adjustBrainValue(-1,rand)
end

local function crazyFailedGamble(plinkett,rand)
	plinkett:adjustScore(-25)
	plinkett:adjustMoney(-1000000)
	return true,"You tried to go to the trump casino but got lost and ended up at the indian casino.Those lousy indians took all your money.\n",plinkett:adjustBrainValue(-2,rand)
end

local function crazyExtremeGable(plinkett,rand)
	plinkett:adjustScore(50)
	plinkett:adjustMoney(25)
	return true,"You bet monopoly money on roulette, somehow the casino didn't notice it want real money. You won 25 real dollars on the game.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyExtremeMarriage(plinkett,rand)
	plinkett:adjustScore(50)
	plinkett:adjustMoney(50)
	plinkett.wife = true
	return true,"In your crazed foggy mind you thought the buffet line was a casino game. A waitress saw you trying to bet on roast beef and took to to sit down. You hit it off and are now married.Plus you managed to win 50 dollars from teh buffet line.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyCasinoDeath(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You died trying to get to the casino.At least you died doing what you love.\n"
	return false,"You crashed your car into the casino, you mistook the lobby for a parking lot. You died in the hospital from brain injuries.\n"
end

local casinoFuncs = {
	[true] = {
		lucidMarriage,lucidMarriage,lucidMarriage,lucidMarriage,lucidGamble,lucidGamble,lucidGamble,lucidFailedMarriage,
		lucidFailedMarriage,lucidFailedGamble,lucidFailedGamble,lucidExtremeGable,lucidExtremeGable,lucidExtremeMarriage,lucidExtremeMarriage
	},
	[false] = {
		crazyMarriage,crazyMarriage,crazyMarriage,crazyMarriage,crazyGamble,crazyGamble,crazyGamble,
		crazyFailedMarriage,crazyFailedMarriage,crazyFailedGamble,crazyFailedGamble,crazyExtremeGable,crazyExtremeGable,
		crazyExtremeMarriage,crazyExtremeMarriage,crazyCasinoDeath
	}
}

function Wife.trumpCasino(plinkett,rand)
	if plinkett.money < 10 then
		if plinkett.isLucid then
			return true,"You didn't have enough money to gamble, but you did gorge yourself on the free buffet before leaving.\n",plinkett:adjustBrainValue(1,rand)
		end
		return casinoNoMoneyCrazy[rand(#casinoNoMoneyCrazy)](plinkett,rand)
	end
	return casinoFuncs[plinkett.isLucid][rand(#casinoFuncs[plinkett.isLucid])](plinkett,rand)
end

return Wife
