local Character <const> = require('model.Character')
local OptionsTable <const> = require('options.OptionsTable')
local Output <const> = require('io.Output')
local Input <const> = require('io.Input')

local function printOptions(options)
    local keys <const> = {}
    for k,v in pairs(options) do
        keys[#keys + 1] = k
        Output.write("\t",#keys,") ",v.message,"\n")
    end
    return keys
end

local function takeInput(options)
    Output.write("What would you like to do today Mr.Plinkett?\n")
    local keys <const> = printOptions(options)
    local input <const> = Input.readNumber("n")
    if type(input) == "number" and input > 0 and #keys >= input and options[keys[input]] then
        return options[keys[input]].func
    end
    Output.write("Wat? that wasn't correct, please try again.\n")
    Input.readLine()
    return takeInput(options)
end

local function makeOptions()
    return {
        CallMikeJay = OptionsTable.CallMikeJay,
        BrainMedicine = OptionsTable.BrainMedicine,
        EatPizzaRoll = OptionsTable.EatPizzaRoll,
        NightCourt = OptionsTable.NightCourt,
        SocialSecurity = OptionsTable.SocialSecurity,
        BuyPizzaRoll = OptionsTable.BuyPizzaRoll
    }
end

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
    --and if he doesnt already have the option to do those other two and his mental state is warped.
    if plinkett.mentalState < -8 and not plinkett.wife and not plinkett.clubGirl and not options.KidNapClub and not options.KidNapHooker and not options.CocktailWaitress and rand(10) > 7 then
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
    return 1
end

local checkConditionTbl <const> = {
    checkHooker, checkMikeJay, checkWife,checkClubGirl
}

local function checkConditions(plinkett,rand,options)
    local brainState = 0
    for i=1,#checkConditionTbl,1 do
       brainState = brainState + checkConditionTbl[i](plinkett,rand,options)
    end
    return plinkett:adjustBrainValue(brainState,rand)
end

local function printStats(plinkett)
    Output.write("score: ",plinkett.score,", money: ",plinkett.money,", brain medicine: ",plinkett.medicineCount,", pizza rolls: ",plinkett.pizzaRolls,"\n")
end

local function loopBody(plinkett,rand,options)
    printStats(plinkett)
    local brainMessage <const> = checkConditions(plinkett,rand,options)
    Output.write(brainMessage,"\n")
    local func <const> = takeInput(options)
    return func(plinkett,rand,options)
end

local function gameLoop()
    local plinkett <const> = Character:new()
    local rand <const> = math.random
    local options <const> = makeOptions()
    local cond = true
    while cond do
       cond = loopBody(plinkett,rand,options)
    end
end

local function main()
    math.randomseed(os.time())
    gameLoop()
end

main()
