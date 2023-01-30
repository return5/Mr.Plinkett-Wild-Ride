local Helpers <const> = require('auxiliary.Helpers')

local Nadine <const> = {}
Nadine.__index = Nadine

_ENV = Nadine


local function fightSuccess(plinkett,rand,options)
	plinkett:adjustScore(200)
	plinkett.killHooker()
	Helpers.resetOptions(options)
	Helpers.setOptions(plinkett,options)
	return true,"In an unlikely turn of events, you managed to over power her and turn her into yet another dead hooker at the hands of Mr.Plinkett.\n",plinkett:adjustBrainValue(-1,rand)
end

local function fightFailure(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You were killed by Nadine. You only wanted to share your pain of hating the prequels with her and now she has killed you.\n"
	return false,"You tried to fight Nadine, but your lack of any physical strength of coordination made it a short lived struggle.\n"
end

function Nadine.fightNadine(plinkett,rand,options)
	return rand(10) > 9 and fightSuccess(plinkett,rand,options) or fightFailure(plinkett,rand)
end

function Nadine.surrenderNadine(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You suffered your fate at the hands of Nadine.RIP Plinkett.\n"
	return false,"You decide to not resist and let Nadine do as she wishes.Perhaps you deserve this fate.\n"
end

local function pizzaRollsSuccess(plinkett,rand)
	plinkett:adjustScore(150)
	plinkett:adjustPizzaRolls(-5)
	plinkett.deathMssg = "You are now a changed man thanks to a revenge obsessed crack whore. From this point on you are living your life for the better.\n"
	return false,"You offer Nadine some hot delicious Pizza Rolls. She accepts. while eating together she talks to you and in that conversation realize how far astray your life has become.you vowe to be a changed man form this point on.\n",plinkett:adjustBrainValue(10,rand)
end

function Nadine.eatPizzaRollsNadine(plinkett,rand)
	if rand(10) > 7 then
		return pizzaRollsSuccess(plinkett,rand)
	end
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "Nadine killed you with pizza rolls.You think death by pizza rolls isn't a bad way to die.\n"
	return false,"You sit down to eat some Pizza Rolls. Nadine see this and is enraged at teh sight of those damned pizza rolls.She shoves them down your throat one by one till you choke to death.\n "
end

function Nadine.nightCourtNadine(plinkett,rand,options)
	if rand(10) > 8 then
		plinkett:adjustScore(200)
		plinkett.wife = true
		Helpers.resetOptions(options)
		Helpers.setOptions(plinkett,options)
		return true,"You sit down and watch an episode of Night Court with Nadine.You two bond and realize how much you have in common and run off to vegas to get married.\n",plinkett:adjustBrainValue(2,rand)
	end
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You died at the hands of a hooker while watching Night Court. All in all not the worse death possible for you.\n"
	return false,"You sit down to watch night court. Nadine burst in through the door and kills you. Good night sweet prince."
end

return Nadine
