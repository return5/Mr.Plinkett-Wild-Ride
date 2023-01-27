local Character <const> = require('model.Character')
local OptionsTable <const> = require('options.OptionsTable')
local Output <const> = require('io.Output')
local Input <const> = require('io.Input')
local ConditionsCheck <const> = require('options.ConditionsCheck')
local RandConditions <const> = require('options.RandConditions')

local function printOptions(options)
    local keys <const> = {}
    for k,v in pairs(options) do
        keys[#keys + 1] = k
        Output.write("\t",#keys,") ",v.message,"\n")
    end
    return keys
end

local function takeInput(options)
    local keys <const> = printOptions(options)
    local input <const> = Input.readNumber("n")
    if type(input) == "number" and input > 0 and #keys >= input and options[keys[input]] then
        return options[keys[input]].func
    end
    Input.readLine()
    Output.clearAndPrint("Wat? that wasn't correct, please try again.\n")
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
local function printStats(plinkett)
    Output.clearAndPrint("score: ",plinkett.score,", money: ",plinkett.money,", brain medicine: ",plinkett.medicineCount,
            ", pizza rolls: ",plinkett.pizzaRolls,", Mental state: ",plinkett.mentalState,"\n")
end

local function loopBody(plinkett,rand,options)
    printStats(plinkett)
    local brainMessage <const> = ConditionsCheck:checkConditions(plinkett,rand,options)
    Output.write(brainMessage)
    local message <const> = RandConditions:checkRandConditions(plinkett,rand,options)
    Output.write(message)
    local func <const> = takeInput(options)
    local cont,mssg <const> = func(plinkett,rand,options)
    if mssg then
        Output.writeAndWait(mssg)
    end
    return cont
end

local function gameLoop(plinkett)
    local rand <const> = math.random
    local options <const> = makeOptions()
    local cond = true
    while cond do
        cond = loopBody(plinkett,rand,options)
    end
end

local function printEndMssg(plinkett)
    Output.write(plinkett.deathMssg,"Final stats are:\n")
    Output.write("Score: ",plinkett.score,", money: ",plinkett.money,", total brain medicine taken: ",plinkett.totalBrainMedicine,
            ", Number of pizza rolls eaten: ",plinkett.totalPizzaRolls,", Number of pizza rolls sent to web zone: ",
            plinkett.totalPizzaRollsWeb,", Total number of youtube reviews made: ",plinkett.youtubesMade,"\n")
    Output.write("Number of wives killed: ",plinkett.wivesKilled,", Number of hookers killed: ",plinkett.hookersKilled,
            ", Number of club girls killed: ",plinkett.clubWomenKilled,"\n")
    Output.writeAndWait("Mike and Jay are ", plinkett.mikeJayDead and "thankfully dead and buried." or "unfortunately still alive.","\n")
end

local function main()
    math.randomseed(os.time())
    local plinkett <const> = Character:new()
    gameLoop(plinkett)
    printEndMssg(plinkett)
end

main()
