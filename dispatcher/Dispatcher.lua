local MikeJay <const> = require('messages.MikeJay')
local Nadine <const> = require('actions.Nadine')
local Police <const> = require('actions.Police')
local Hooker <const> = require('actions.Hooker')
local ClubGirl <const> = require('actions.ClubGirl')
local Wife <const> = require('actions.Wife')
local PizzaRolls <const> = require('actions.PizzaRolls')
local Youtubes <const> = require('actions.Youtubes')
local NightCourt <const> = require('actions.NightCourt')
local SocialSecurity <const> = require('actions.SocialSecurity')

local Dispatcher <const> = {}
Dispatcher.__index = Dispatcher

_ENV = Dispatcher

function Dispatcher.fightNadine(plinkett,rand,options)
	return Nadine.fightNadine(plinkett,rand,options)
end

function Dispatcher.surrenderNadine(plinkett,rand,options)
	return Nadine.surrenderNadine(plinkett,rand,options)
end

function Dispatcher.eatPizzaRollsNadine(plinkett,rand,options)
	return Nadine.eatPizzaRollsNadine(plinkett,rand,options)
end

function Dispatcher.nightCourtNadine(plinkett,rand,options)
	return Nadine.nightCourtNadine(plinkett,rand,options)
end

function Dispatcher.eatPizzaRollsCops(plinkett,rand)
	return Police.eatPizzaRollsCops(plinkett,rand)
end

function Dispatcher.nightCourtCops(plinkett,rand,options)
	return Police.nightCourtCops(plinkett,rand,options)
end

function Dispatcher.surrender(plinkett,rand,options)
	return Police.surrender(plinkett,rand,options)
end

function Dispatcher.fightPolice(plinkett,rand,options)
	return Police.fightPolice(plinkett,rand,options)
end

function Dispatcher.findNightCourt(plinkett,rand)
	return NightCourt.find[plinkett.isLucid][rand(#NightCourt.find[plinkett.isLucid])](plinkett,rand)
end

function Dispatcher.killMikeJay(plinkett,rand)
    return MikeJay.kill[rand(#MikeJay.kill)](plinkett,rand)
end

function Dispatcher.cocktailWaitress(plinkett,rand)
    return Wife.trumpCasino(plinkett,rand)
end

function Dispatcher.kidnapClub(plinkett,rand)
    return ClubGirl.kidnap[rand(ClubGirl.kidnap)](plinkett,rand)
end

function Dispatcher.kidnapHooker(plinkett,rand)
    return Hooker.kidnap[rand(Hooker.kidnap)](plinkett,rand)
end

function Dispatcher.killHooker(plinkett,rand,options)
    return Hooker.kill[plinkett.isLucid][rand(#Hooker.kill[plinkett.isLucid])](plinkett,rand,options)
end

function Dispatcher.killWoman(plinkett,rand)
    return ClubGirl.kill[plinkett.isLucid][rand(#ClubGirl.kill[plinkett.isLucid])](plinkett,rand)
end

function Dispatcher.killWife(plinkett,rand)
    return Wife.kill[plinkett.isLucid][rand(#Wife.kill[plinkett.isLucid])](plinkett,rand)
end

function Dispatcher.sendPizzaRoll(plinkett,rand)
    if plinkett.pizzaRolls == 0 then
        return PizzaRolls.emptySend[rand(#PizzaRolls.emptySend)](plinkett,rand)
    end
    return PizzaRolls.send[rand(#PizzaRolls.send)](plinkett,rand)
end

function Dispatcher.socialSecurity(plinkett,rand)
    return SocialSecurity[plinkett.isLucid][rand(#SocialSecurity[plinkett.isLucid])](plinkett,rand)
end

function Dispatcher.eatPizzaRoll(plinkett,rand)
    if plinkett.pizzaRolls == 0 then
        return PizzaRolls.emptyEat(plinkett,rand)
    end
    return PizzaRolls.eat[rand(#PizzaRolls.eat)](plinkett,rand)
end

function Dispatcher.buyPizzaRoll(plinkett,rand)
    return PizzaRolls.buy[plinkett.isLucid][rand(#PizzaRolls.buy[plinkett.isLucid])](plinkett,rand)
end

function Dispatcher.nightCourt(plinkett,rand)
    return NightCourt.watchNightCourt(plinkett,rand)
end

function Dispatcher.youtubeVideo(plinkett,rand)
    if rand(10) > 5 then
        return Youtubes.failed[rand(#Youtubes.failed)](plinkett,rand)
    end
    return Youtubes.success[rand(#Youtubes.success)](plinkett,rand)
end

function Dispatcher.brainMedicine(plinkett,rand)
    return true,plinkett:takeBrainMedicine(rand)
end

function Dispatcher.callMikeJay(plinkett,rand)
    return MikeJay.call(plinkett,rand)
end

function Dispatcher.quit(plinkett)
    plinkett.deathMssg = "You quit, you quitter."
    return false,"You quit the game. Life as Plinkett isn't for the faint of heart.\n"
end

return Dispatcher