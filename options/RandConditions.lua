--file to contain all functions which can generate random events at the start of each round.

local OptionsTable <const> = require('options.OptionsTable')
local Output <const> = require('io.Output')

local RandConditions <const> = {}
RandConditions.__index = RandConditions

_ENV = RandConditions

local function getPoliceMessage(plinkett,rand)
    return "The police are at your door." .. plinkett.policeMessage[rand(#plinkett.policeMessage)]
end

local function checkPolice(plinkett,rand,options)
    --TODO figure out proper value
    if plinkett.policeChance > rand(10) then
        options = {
            EatPizzaRoll = OptionsTable.EatPizzaRoll,
            NightCourt = OptionsTable.NightCourt,
            FightPolice = OptionsTable.FightPolice,
            Surrender = OptionsTable.Surrender
        }
        return false,getPoliceMessage(plinkett,rand)
    end
    return true,"What would you like to do today Mr.Plinkett?\n"
end

local function loseNightCourt(plinkett,rand)
    if plinkett.hasNightCourt then
        if plinkett.mikeJay and rand(10) > 8 then
            plinkett.hasNightCourt = false
            plinkett.nightCourtMssg = "Mike and or Jay lost your Night Court tape.\n"
            return true
        end
        if rand(10) > 8 then
            plinkett.hasNightCourt = false
            plinkett.nightCourtMssg = "Looks like you lost your precious Night Court tape.\n"
            return true
        end
    end
end

local function checkVcr(plinkett,rand)
    if plinkett.mikeJay and not plinkett.vcrFixed and rand(100) > 95 then
        plinkett.vcrFixed = true
        plinkett.adjustMoney(-10000)
        plinkett.adjustBRainValue(50,rand)
        Output.writeAndWait("Against all odds, Mike and jay actually fixed your VCR. It only took 12 years and 10,000 dollars but it was worth it.")
    end
end

function RandConditions:checkRandConditions(plinkett,rand,options)
    local cont, message = checkPolice(plinkett,rand,options)
    if cont then
        loseNightCourt(plinkett,rand)
        checkVcr(plinkett,rand)
    end
    return message
end

return RandConditions
