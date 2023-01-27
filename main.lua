local Character <const> = require('model.Character')
local OptionsTable <const> = require('options.OptionsTable')
local Output <const> = require('io.Output')
local Input <const> = require('io.Input')
local ConditionsCheck <const> = require('options.ConditionsCheck')

local function printOptions(options)
    local keys <const> = {}
    for k,v in pairs(options) do
        keys[#keys + 1] = k
        Output.write("\t",#keys,") ",v.message,"\n")
    end
    return keys
end

local function takeInput(message,options)
    Output.write(message)
    local keys <const> = printOptions(options)
    local input <const> = Input.readNumber("n")
    if type(input) == "number" and input > 0 and #keys >= input and options[keys[input]] then
        return options[keys[input]].func
    end
    Output.write("Wat? that wasn't correct, please try again.\n")
    Input.readLine()
    return takeInput(message,options)
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
local function printStats(plinkett)
    Output.write("score: ",plinkett.score,", money: ",plinkett.money,", brain medicine: ",plinkett.medicineCount,", pizza rolls: ",plinkett.pizzaRolls,"\n")
end

local function getPoliceMessage(plinkett,rand)
    return "The police are at your door." .. plinkett.policeMessage[rand(#plinkett.policeMessage)]
end

local function checkRandConditions(plinkett,rand,options)
    --TODO figure out proper value
    if plinkett.policeChance > rand(10) then
        options = {
            EatPizzaRoll = OptionsTable.EatPizzaRoll,
            NightCourt = OptionsTable.NightCourt,
            FightPolice = OptionsTable.FightPolice,
            Surrender = OptionsTable.Surrender
        }
        return getPoliceMessage(plinkett,rand)
    end
    return "What would you like to do today Mr.Plinkett?\n"
end

local function loopBody(plinkett,rand,options)
    printStats(plinkett)
    local brainMessage <const> = ConditionsCheck:checkConditions(plinkett,rand,options)
    Output.write(brainMessage,"\n")
    local message <const> = checkRandConditions(plinkett,rand,options)
    local func <const> = takeInput(message,options)
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
