local Helpers <const> = require('auxiliary.Helpers')

local Hooker <const> = { kill = {}}
Hooker.__index = Hooker
_ENV = Hooker

local function failed(plinkett)
	plinkett:adjustScore(-10)
	return true,"You try to kill her, but you forgot where you put the key to the basement so you put it off till another day.\n"
end

local function lucidKillFunc(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:adjustPoliceChance(1)
	plinkett.policeMessage.hookerKilled = "The police were called about a decaying smell coming form your house. they found the body of the hooker.\n"
	plinkett:killHooker()
	return true,"You get sick of hearing about her baby, so you suffocate her in a crawl space using raid.\n",plinkett:adjustBrainValue(-1,rand)
end

local function lucidEscape(plinkett,rand,options)
	plinkett:adjustScore(-100)
	plinkett:adjustPoliceChance(0)
	plinkett.hooker = false
	Helpers.setNadineOptions(options,plinkett)
	return true,"After promising to watch Revenge Of The Sith with you, she tricks you and runs away.\n",plinkett:adjustBrainValue(-2,rand)
end

local function crazyEscape(plinkett,rand,options)
	plinkett:adjustScore(-100)
	plinkett:adjustPoliceChance(0)
	plinkett.nadineRevenge = true
	Helpers.setNadineOptions(options,plinkett)
	return true,"While trying to feed her some delicious pizza rolls she kicks you runs away.\n",plinkett:adjustBrainValue(-2,rand)
end

local function crazyKill(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:adjustPoliceChance(1)
	plinkett:killHooker()
	plinkett.policeMessage.hookerKilled = "Your neighbors heard the agonized cries of the hooker you forced to watch Attack of the Clones. They called the police.\n"
	return true,"You force her to eat pizza rolls and watch Attack Of The Clones on repeat until she can't take it anymore and kills herself.",plinkett:adjustBrainValue(-2,rand)
end


Hooker.kill[false] = {crazyEscape,crazyKill,crazyKill,crazyKill,crazyKill,failed,failed,failed,failed,failed}
Hooker.kill[true] = {lucidKillFunc,lucidKillFunc,lucidKillFunc,lucidKillFunc,lucidEscape,failed,failed,failed,failed,failed}

local function kidnapSuccess(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:adjustPoliceChance(1)
	plinkett.hooker = true
	plinkett.policeMessage.hookerKidnapped = "The police were called about the missing hooker. Their investigation lead them to your house.\n"
	return true,"You Go out and kidnap a nice hooker. She is now tied up in your creepy basement.",plinkett:adjustBrainValue(-1,rand)
end

local function kidnapFail(plinkett)
	plinkett:adjustScore(-10)
	return true,"You drive around all night but never manage to find a hooker to kidnap.\n"
end

local function kidnapDeath(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg("You were stabbed to death by a crack whore.You should have watched Surviving Edged Weapons.\n")
	return false,"You tried to kidnap a hooker, but she took out a lipstick shaped knife and stabbed you. You bleed to death in the gutter wondering how your life got to this point\n"
end

local function kidnapCrazyFail(plinkett,rand)
	plinkett:adjustScore(-25)
	plinkett:adjustPoliceChance(2)
	plinkett:adjustMoney(-10)
	plinkett.policeMessage.hookerKidnapped = "The hooker who took your money was eventually picked up by the police. She told them what happened.\n"
	return true,"You drive up to a hooker, but since you are speaking gibberish she takes all the money you have in your pocket and then runs off.\n",plinkett:adjustBrainValue(-1,rand)
end

local function kidnapCrazySuccess(plinkett,rand)
	plinkett:adjustScore(50)
	plinkett:adjustPoliceChance(2)
	plinkett.hooker = true
	plinkett.policeMessage.hookerKidnapped = "Someone saw you kidnap the hooker you thought was an alien. They reported it to the police and now the police have found you.\n"
	return true,"You spot what you think is an alien so you kidnap it with plans to anally probe it in revenge for all those times your were abducted.\n",plinkett:adjustBrainValue(-2,rand)
end

Hooker.kidnap = {
	kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapFail,kidnapFail,kidnapFail,
	kidnapCrazyFail,kidnapCrazyFail,kidnapCrazySuccess,kidnapCrazySuccess,kidnapDeath
}

return Hooker