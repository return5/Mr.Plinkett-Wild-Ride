--file to hold all the functions used to check conditions at the start of each round.

local OptionsTable <const> = require('options.OptionsTable')
local abs <const> = math.abs

local ConditionCheck <const> = {}
ConditionCheck.__index = ConditionCheck

_ENV = ConditionCheck

local function checkHooker(plinkett,rand,options)
    if plinkett.hooker then
        plinkett:changePoliceChance(1)
        if not options.KillHooker then
            if rand(10) > 8 then
                options.KillHooker = OptionsTable.KillHooker
            end
        end
        return -1
    end
    if options.KillHooker then
        options.KillHooker = nil
    end
    --if plinkett hasnt already kidnapped a club girl and he doesnt have a wife and hasnt kidnapped a hooker,
    --and if he doesnt already have the option to do those other two and his mental state is warped.
    if not plinkett.isLucid and not plinkett.wife and not plinkett.clubGirl and not options.KidNapClub and not options.KidNapHooker and not options.CocktailWaitress and rand(10) > 7 then
        options.KidNapHooker = OptionsTable.KidnapHooker
    end
    return 0
end

local function checkClubGirl(plinkett,rand,options)
    if plinkett.clubGirl then
        plinkett:changePoliceChance(1)
        if not options.KillWoman then
            if rand(10) > 8 then
                options.KillWoman = OptionsTable.KillWoman
            end
        end
        return -1
    end
    if options.KillWoman then
        options.KillWoman = nil
    end
    --if plinkett hasnt already kidnapped a club girl and he doesnt have a wife and hasnt kidnapped a hooker,
    --and if he doesnt already have the option to do those two and his mental state is warped.
    if  not plinkett.isLucid and not plinkett.wife and not plinkett.hooker and  not options.KidNapClub and not options.KidNapHooker and not options.CocktailWaitress and rand(10) > 7 then
        options.KidNapClub = OptionsTable.KidnapClub
    end
    return 0
end

local function checkWife(plinkett,rand,options)
    if plinkett.wife then
        if not options.KillWife then
            if rand(10) > 8 then
                options.KillWife = OptionsTable.KillWife
            end
        end
        return -1
    end
    if options.KillWife then
        options.KillWife = nil
    end
    --if plinkett hasnt already kidnapped a club girl and he doesnt have a wife and hasnt kidnapped a hooker,
    --and if he doesnt already have the option to do those other two.
    if not plinkett.wife and not plinkett.clubGirl and not options.KidNapClub and not options.KidNapHooker and not options.CocktailWaitress and rand(10) > 6 then
        options.CocktailWaitress = OptionsTable.CocktailWaitress
    end
    return 0
end

local function checkMikeJay(plinkett,rand,options)
    if plinkett.mikeJay then
        if options.CallMikeJay then
            options.CallMikeJay = nil
        end
        if not options.KillMikeJay and not plinkett.isLucid and rand(10) > 7 then
            options.KillMikeJay = OptionsTable.KillMikeJay
        end
        return -1
    end
    if options.KillMikeJay then
        options.KillMikeJay = nil
    end
    if plinkett.mikeJayDead then
        return 1
    end
    return 0
end

local function checkNightCourt(plinkett,rand,options)
    if plinkett.discoveredMissingNightCourt then
        options.FindNightCourt = OptionsTable.FindNightCourt
        return 0
    end
    options.FindNightCourt = nil
    if plinkett.mikeJay and plinkett.hasNightCourt and rand(10) > 8 then
        plinkett.hasNightCourt = false
        plinkett.nightCourtMssg = "Mike and or Jay lost your Night Court tape.\n"
        return 0
    end
    if plinkett.hasNightCourt and rand(10) > 8 then
        plinkett.hasNightCourt = false
        plinkett.nightCourtMssg = "Looks like you lost your precious Night Court tape.\n"
        return 0
    end
    return 0
end

local checkConditionTbl <const> = {
    checkHooker, checkMikeJay,checkWife,checkClubGirl,checkNightCourt
}

local function getBrainMessage(plinkett,rand,brainState)
    local prevState <const> = plinkett.mentalState
    local message <const> = plinkett:adjustBrainValue(brainState,rand)
    if abs(prevState - plinkett.mentalState) > 1 then
        return message .. "\n"
    end
    return ""
end

function ConditionCheck:checkConditions(plinkett,rand,options)
    local brainState = 0
    for i=1,#checkConditionTbl,1 do
        brainState = brainState + checkConditionTbl[i](plinkett,rand,options)
    end
    return getBrainMessage(plinkett,rand,brainState)
end

return ConditionCheck
