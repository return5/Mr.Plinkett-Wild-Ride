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
	Nadine.fightNadine(plinkett,rand,options)
end

function Dispatcher.surrenderNadine(plinkett,rand,options)
	Nadine.surrenderNadine(plinkett,rand,options)
end

function Dispatcher.eatPizzaRollsNadine(plinkett,rand,options)
	Nadine.eatPizzaRollsNadine(plinkett,rand,options)
end

function Dispatcher.nightCourtNadine(plinkett,rand,options)
	Nadine.nightCourtNadine(plinkett,rand,options)
end

function Dispatcher.eatPizzaRollsCops(plinkett,rand)
	Police.eatPizzaRollsCops(plinkett,rand)
end

function Dispatcher.nightCourtCops(plinkett,rand)
	Police.nightCourtCops(plinkett,rand)
end

function Dispatcher.surrender(plinkett,rand,options)
	Police.surrender(plinkett,rand,options)
end

function Dispatcher.fightPolice(plinkett,rand,options)
	Police.fightPolice(plinkett,rand,options)
end

function Dispatcher.findNightCourt(plinkett,rand,options)

end

function Dispatcher.killMikeJay(plinkett,rand,options)

end

function Dispatcher.cocktailWaitress(plinkett,rand,options)

end

function Dispatcher.kidnapClub(plinkett,rand,options)

end

function Dispatcher.kidnapHooker(plinkett,rand,options)

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
        PizzaRolls.emptySend[rand(#PizzaRolls.emptySend)](plinkett,rand)
    end
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
    if plinkett.mikeJayDead then
        return true,"You went to call Mike and Jay to fix your VCR but remembered that you killed them.This brings a smile to your face\n", plinkett:adjustBrainValue(2,rand)
    end
    if plinkett.mikeJay then
        return true,"You try to call Mike and Jay but you later realize they are already at your house.This darkens your mood.\n",plinkett:adjustBrainValue(-1,rand)
    end
    local option <const> = MikeJay.call[plinkett.isLucid][rand(#MikeJay.call[plinkett.isLucid])]
    return option.func(plinkett,rand),option.message
end

function Dispatcher.quit(plinkett)
    plinkett.deathMssg = "You quit, you quitter."
    return false,"You quit the game. Life as Plinkett isn't for the faint of heart.\n"
end

return Dispatcher