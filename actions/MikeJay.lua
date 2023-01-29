local Option <const> = require('options.Option')

local MikeJay <const> = {}
MikeJay.__index = MikeJay
_ENV = MikeJay

local suicideMssg <const> = "After mistakenly calling a suicide help hotline and being told to do it, Mr.Plinkett in his confused state does what he is told.Rest In Peace Harry S. Plinkett."

local callTbl <const> = {
    [true] = {
        Option:new("You tried to call Mike and Jay but got the wrong number.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You call Mike and Jay. They are on their way to fix your VCR.",function(plinkett) plinkett.mikeJay = true; plinkett:adjustScore(25); return true end),
        Option:new("You call Mike and Jay. They are on their way to fix your VCR.",function(plinkett) plinkett.mikeJay = true; plinkett:adjustScore(25); return true end),
        Option:new("You call Mike and Jay but it is their day off.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You tried to call Mike and Jay but accidentally called a nigerian scammer and sent him some money. ",
                function(plinkett,rand) plinkett.mikeJay = false; plinkett:adjustMoney(-50); plinkett:adjustScore(-10); return true,plinkett:worsenBrainState(-1,rand) end),
        Option:new("You try to call Mike and Jay but accidentally called a trans help hotline. You are now more confused than ever.",
                function(plinkett,rand) plinkett.mikeJay = false;plinkett:adjustScore(-5); return true,plinkett:worsenBrainState(1,rand) end)
    },
    [false] = {
        Option:new("You tried to call Mike and Jay but the phone tried to kill you so you shot it.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You try to call Mike And Jay but you slipped on a pizza roll and brok your hip.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You attempt to call Mike and Jay but accidentally call a suicide help hotline. They tell you to do it and so you do.",
                function(plinkett) plinkett.mikeJay = false;plinkett.deathMessage = suicideMssg; plinkett:adjustScore(-50); return false end),
        Option:new("While Attempting to call Mike and Jay you accidentally call meth addiction hotline and tell them your entire life story. They call the police to your house.",
                function(plinkett) plinkett.mikeJay = false;plinkett.police = true; plinkett:adjustScore(-50);return true end),
        Option:new("You call Mike and Jay. They recognize how feeble your mind is right now and rush over to take advantage of your dementia.",
                function(plinkett) plinkett.mikeJay = true; plinkett:adjustScore(-20);return true end),
        Option:new("You accidentally call a sex hotline. It takes you over an hour to realize what is going on before you hang up.",
                function(plinkett) plinkett.mikeJay = false; plinkett.adjustMoney(-60); plinkett:adjustScore(-25);return true end)
    }
}


function MikeJay.call(plinkett,rand)
    if plinkett.mikeJayDead then
        return true,"You went to call Mike and Jay to fix your VCR but remembered that you killed them.This brings a smile to your face\n", plinkett:adjustBrainValue(2,rand)
    end
    if plinkett.mikeJay then
        return true,"You try to call Mike and Jay but you later realize they are already at your house.This darkens your mood.\n",plinkett:adjustBrainValue(-1,rand)
    end
    local option <const> = callTbl[plinkett.isLucid][rand(#callTbl[plinkett.isLucid])]
    return option.func(plinkett,rand),option.message
end

return MikeJay
