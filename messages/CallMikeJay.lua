local Option <const> = require('options.Option')

local suicideMssg <const> = "After mistakenly calling a suicide help hotline and being told to do it, Mr.Plinkett in his confused state does what he is told.Rest In Peace Harry S. Plinkett."

local function makeLucidTbl()
    return {
        Option:new("You tried to call Mike and Jay but got the wrong number.",function(plinkett) plinkett.mikeJay = false ; return true end),
        Option:new("You call Mike and Jay. They are on their way to fix your VCR.",function(plinkett) plinkett.mikeJay = true; return true end),
        Option:new("You call Mike and Jay. They are on their way to fix your VCR.",function(plinkett) plinkett.mikeJay = true; return true end),
        Option:new("You call Mike and Jay but it is their day off.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You tried to call Mike and Jay but accidentally called a nigerian scammer and sent him some money. ",
                function(plinkett) plinkett.mikeJay = false; plinkett:adjustMoney(-50); return true end),
        Option:new("You try to call Mike and Jay but accidentally called a trans help hotline. You are now more confused than ever.",
                function(plinkett,rand) plinkett.mikeJay = false; plinkett:worsenBrainState(1,rand); return true end)
    }
end

local function makeCrazyTbl()
    return {
        Option:new("You tried to call Mike and Jay but the phone tried to kill you so you shot it.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You try to call Mike And Jay but you slipped on a pizza roll and brok your hip.",function(plinkett) plinkett.mikeJay = false; return true end),
        Option:new("You attempt to call Mike and Jay but accidentally call a suicide help hotline. They tell you to do it and so you do.",
                function(plinkett) plinkett.mikeJay = false;plinkett.deathMessage = suicideMssg; return false end),
        Option:new("While Attempting to call Mike and Jay you accidentally call meth addiction hotline and tell them your entire life story. They call the police to your house.",
                function(plinkett) plinkett.mikeJay = false;plinkett.police = true; return true end),
        Option:new("You call Mike and Jay. They recognize how feeble your mind is right now and rush over to take advantage of your dementia.",
                function(plinkett) plinkett.mikeJay = true; return true end),
        Option:new("You accidentally call a sex hotline. It takes you over an hour to realize what is going on before you hang up.",
                function(plinkett) plinkett.mikeJay = false; plinkett.adjustMoney(-60); return true end)
    }
end

return {[true] = makeLucidTbl(),[false] = makeCrazyTbl()}
