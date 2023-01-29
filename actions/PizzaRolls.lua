
local PizzaRolls <const> = {buy = {}}
PizzaRolls.__index = PizzaRolls
_ENV = PizzaRolls


local function sendPizzaRollsAte(plinkett,rand)
	plinkett:adjustPizzaRolls(-3)
	plinkett:adjustChanceToGetMoney(-1)
	plinkett:adjustScore(-5)
	return true,"You tried to send some pizza rolls but ate them instead.\n",plinkett:adjustBrainValue(.5,rand)
end

local function sendPizzaRollsCut(plinkett,rand)
	plinkett:adjustChanceToGetMoney(-1)
	plinkett:adjustScore(-5)
	return true,"You were putting pizza rolls into envelopes but ended up cutting your finger on an envelope. The pain drives you into a rage.\n",plinkett:adjustBrainValue(-1,rand)
end

local function sendPizzaRolls(plinkett,rand)
	plinkett:adjustPizzaRolls(-3)
	plinkett:adjustChanceToGetMoney(1)
	plinkett:adjustScore(5)
	return true,"You sent some pizza rolls to commenters on your webzone.\n",plinkett:adjustBrainValue(-.5,rand)
end

local function sendLotsPizzaRolls(plinkett,rand)
	if plinkett.pizzaRolls > 5 then
		plinkett:adjustPizzaRolls(-5)
		plinkett:adjustChanceToGetMoney(2)
		plinkett:adjustScore(10)
		return true,"You send out a bunch of pizza rolls to commenters. You also made sure they were hot and delicious before sending them.\n",plinkett:adjustBrainValue(-1,rand)
	end
	return sendPizzaRolls(plinkett,rand)
end

local function emptySendPizzaRollsCrazy(plinkett, rand)
	plinkett:adjustScore(-5)
	return true,"You went to send pizza rolls but discovered you were out of them. You feel an overwhelming sense of dread.\n",plinkett:adjustBrainValue(-2,rand)
end

local function emptySendPizzaRolls(plinkett, rand)
	return true,"You tried to send pizza rolls to your webzone but you dont have any pizza rolls.\n",plinkett:adjustBrainValue(-1,rand)
end

PizzaRolls.emptySend = {
	emptySendPizzaRollsCrazy, emptySendPizzaRollsCrazy, emptySendPizzaRollsCrazy, emptySendPizzaRolls, emptySendPizzaRolls,
	emptySendPizzaRolls, emptySendPizzaRolls, emptySendPizzaRolls, emptySendPizzaRolls, emptySendPizzaRolls
}

PizzaRolls.send = {
	sendPizzaRolls,sendPizzaRolls,sendPizzaRolls,sendPizzaRolls,sendLotsPizzaRolls,sendLotsPizzaRolls,sendPizzaRollsCut,
	sendPizzaRollsCut,sendPizzaRollsAte,sendPizzaRollsAte
}

local function eatPizzaRollsSpill(plinkett,rand)
	plinkett:adjustScore(-10)
	plinkett:adjustPizzaRolls(-5)
	return true,"You cooked some pizza rolls but accidentally spilled them on yourself and burned yourself pretty bad.\n",plinkett:adjustBrainValue(-2,rand)
end

local function eatPizzaRollsExtras(plinkett,rand)
	plinkett:adjustScore(15)
	plinkett:eatPizzaRolls(-5)
	return true,"You opened the bag of pizza rolls and found it contains many extra pizza rolls. this brightens your mood.\n",plinkett:adjustBrainValue(2,rand)
end

local function eatPizzaRollsChoke(plinkett)
	plinkett:adjustScore(-200)
	plinkett:eatPizzaRolls(-5)
	plinkett.deathMssg = "You choked to death on a pizza roll.It isn't a glorious way to go, but it isn't unexpected.\n"
	return false,"You were happily eating pizza rolls until you started to choke on one. It's finally the end of Plinkett.\n"
end

local function eatPizzaRolls(plinkett,rand)
	plinkett:adjustScore(5)
	plinkett:eatPizzaRolls(-5)
	return true,"You cook and eat some pizza rolls.You feel full and mentally are feeling better.\n",plinkett:adjustBrainValue(1,rand)
end

local function emptyEatPizzaRolls(plinkett,rand)
	plinkett:adjustScore(-5)
	return true,"You want to eat pizza rolls but you don't have any.This is a tragic moment.\n",plinkett:adjustBrainValue(-1,rand)
end

PizzaRolls.emptyEat = emptyEatPizzaRolls
PizzaRolls.eat = {
	eatPizzaRolls,eatPizzaRolls,eatPizzaRolls,eatPizzaRolls,eatPizzaRollsChoke,eatPizzaRollsExtras, eatPizzaRollsExtras,
	eatPizzaRollsSpill,eatPizzaRollsSpill
}

local function buyPizzaRollsCrazyBigFail(plinkett,rand)
	return true,"You went to the store to buy pizza rolls but somehow ended up in mexico with an unknown infection.\n",plinkett:adjustBrainValue(-2,rand)
end

local function buyPizzaRollsCrazyFail(plinkett,rand)
	return true,"You went to buy pizza rolls but were forced out of the store after yelling at can of beans for an hour.\n",plinkett:adjustBrainValue(-2,rand)
end

local function buyPizzaRollsCrazyDeath(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You got hit by a car trying to buy pizza rolls\n"
	return false,"While going ot the store to buy pizza rolls you saw a dog and tried to pet it but turns out it was actually a speeding car.In your confusion you got hit.\n"
end

local function buyPizzaRollsDeath(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You died by being thrown off a bridge.\n"
	return false,"While walking to the store you get thrown off a bridge by two mysterious men. One of them might have been amish.\n"
end

local function buyPizzaRollsFail(plinkett,rand)
	return true,"You went to the store to buy pizza rolls but they wouldn't give you any since you don't have any money.\n",plinkett:adjustBrainValue(-1,rand)
end

local function buyPizzaRollsSuccess(plinkett,rand)
	if plinkett.money >= 5 then
		plinkett:adjustMoney(-5)
		plinkett:adjustScore(10)
		plinkett:adjustPizzaRolls(10)
		return true,"You went to the store and bought some more pizza rolls.You cant wait to get home and eat some.\n",plinkett:adjustBrainValue(1,rand)
	end
	return buyPizzaRollsFail(plinkett,rand)
end

PizzaRolls.buy[true] = {
	buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,
	buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsDeath
}
PizzaRolls.buy[false] = {
	buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,buyPizzaRollsSuccess,
	buyPizzaRollsCrazyBigFail,buyPizzaRollsCrazyBigFail,buyPizzaRollsCrazyDeath,buyPizzaRollsCrazyFail,buyPizzaRollsCrazyFail,buyPizzaRollsCrazyFail
}
return PizzaRolls
