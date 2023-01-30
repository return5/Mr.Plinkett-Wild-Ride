
local OptionsTable <const> = require('options.OptionsTable')

local Police <const> = {}
Police.__index = Police

_ENV = Police


local function resetOptions(options)
	for k,_ in pairs(options) do
		options[k] = nil
	end
end

local function setOptions(plinkett,options)
	if not plinkett.mikeJayDead  then
		options.CallMikeJay = OptionsTable.CallMikeJay
	end
	options.BrainMedicine = OptionsTable.BrainMedicine
	options.EatPizzaRoll = OptionsTable.EatPizzaRoll
	options.NightCourt = OptionsTable.NightCourt
	options.SocialSecurity = OptionsTable.SocialSecurity
	options.BuyPizzaRoll = OptionsTable.BuyPizzaRoll
	options.Quit = OptionsTable.Quit
end

function Police.eatPizzaRollsCops(plinkett,rand,options)
	if rand(100) > 89 then
		plinkett:score(250)
		plinkett:adjustPizzaRolls(-5)
		resetOptions(options)
		setOptions(plinkett,options)
		return true,"You sit down and eat some delicious pizza rolls.When the police come in you offer them some. They accept your offer and you enjoy eating pizza rolls together.After they finish they wish you good night and leave.\n"
	end
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You were arrested trying to eat pizza rolls.You never did get to eat them, and now you are sad at the thought of those once hot delicious pizza rolls sitting there cold and wasted.\n"
end

function Police.nightCourtCops(plinkett,rand,options)
	if rand(100) > 92 then
		plinkett:score(250)
		resetOptions(options)
		setOptions(plinkett,options)
		return true,"You sit down and watch an episode of Night Court. The cops come in but you barely notice them. The eventually sit down and watch Night Court with you. when the episode is over they wish you a good night and leave.\n",plinkett:adjustBrainValue(1,rand)
	end
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You are arrested while watching an episode of Night Court. You are angry the cops didn't let you finish the episode.\n"
	return false,"You sit down and watch Night Court not realizing what is going on.The police barge in and arrest you.This is the last you will ever see of the outside world and of Night Court\n"
end

function Police.surrender(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You were put away in a mental asylum for the rest of your life.Worst of all they have no VCR here, so you will never get to watch your Night Court tape.\n"
	return false,"You surrender to the police. You are immediately sent to a mental hospital for evaluation. Your life will furnish material for psychological studies for years to come.\n"
end

local function fightSuccess(plinkett,rand,options)
	plinkett:adjustScore(200)
	resetOptions(options)
	setOptions(plinkett,options)
	return true,"You popped those cops in mo-town.Luckily for you they didn't report in before entering your house so now nobody will ever know what happened to them.Your life can go back to normal\n",plinkett:adjustBrainValue(-2,rand)
end

local function fightFailure(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You were gunned down by the police.The streets of Milwaukee are a tad bit safer for hookers now.\n"
	return false,"You go into a shoot out with the police. You weren't going down without a fight.You squeezed your gats til the clips is empty for the last time.\n"
end

local fightPoliceTbl <const> = {fightSuccess,fightFailure,fightFailure,fightFailure,fightFailure,fightFailure}

function Police.fightPolice(plinkett,rand,options)
	return fightPoliceTbl[rand(#fightPoliceTbl)](plinkett,rand,options)
end

return Police
