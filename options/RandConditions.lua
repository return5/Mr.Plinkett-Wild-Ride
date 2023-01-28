--file to contain all functions which can generate random events at the start of each round.

local OptionsTable <const> = require('options.OptionsTable')
local Output <const> = require('io.Output')

local RandConditions <const> = {}
RandConditions.__index = RandConditions

_ENV = RandConditions

local function getPoliceMessage(plinkett,rand)
    return "The police are at your door." .. plinkett.policeMessage[rand(#plinkett.policeMessage)]
end

local function printBrainMessage(plinkett,prevState,mssg,mssg2)
    if plinkett:cmpBrainState(prevState) then
        Output.writeAndWait(mssg .. mssg2)
    else
        Output.writeAndWait(mssg)
    end
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
        local mssg <const> = plinkett.adjustBrainValue(50,rand)
        printBrainMessage("Against all odds Mike and Jay actually fixed your VCR. It only took 12 years and 10,000 dollars, but it was worth it.\n",mssg)
    end
    return true
end

local function checkWifeNag(plinkett,rand)
    if plinkett.wife and rand(10) > 6 then
        local prevState <const> = plinkett.mentalState
        local mssg <const> = plinkett:adjustBrainValue(-.7,rand)
        printBrainMessage(plinkett,prevState,"Your wife is nagging you. Your mental state is worsening.\n",mssg)
    end
    return true
end

local function checkHookerNag(plinkett,rand)
    if plinkett.hooker and rand(10) > 6 then
        local prevState <const> = plinkett.mentalState
        local mssg <const> = plinkett:adjustBrainValue(-.7,rand)
        printBrainMessage(plinkett,prevState,"The hooker is pleading with you to let her see her baby. You dont know how much longer you can take this.\n",mssg)
    end
    return true
end

local function checkClubGirl(plinkett,rand)
    if plinkett.clubGirl and rand(10) > 6 then
        local prevState <const> = plinkett.mentalState
        local mssg <const> = plinkett:adjustBrainValue(-.7,rand)
        printBrainMessage(plinkett,prevState,"The kidnapped club girl is crying and pleading that if you let her go she wont tell nobody, it's driving you nuts.\n",mssg)
    end
    return true
end

local function checkYoutube(plinkett,rand)
    if plinkett.youtubesMade > 0 then
        if rand(10) > 7 then
            printBrainMessage(plinkett,"Your youtube videos are getting comments on their webzone. They demand you send them some Pizza Roll\n",plinkett:adjustBrainValue(-1,rand))
            return true
        end
        if rand(10) > 7 then
            plinkett:adjustMoney(15)
            printBrainMessage(plinkett,"Your youtube videos are popular, they have brought in some donations.",plinkett:adjustBrainValue(1,rand))
        end
    end
end

local randCondFuncs <const> = {
    loseNightCourt,checkVcr,checkWifeNag,checkHookerNag,checkClubGirl,checkYoutube
}

function RandConditions:checkRandConditions(plinkett,rand,options)
    local cont, message = checkPolice(plinkett,rand,options)
    if cont then
        for i=1,#randCondFuncs,1 do
            randCondFuncs[i](plinkett,rand)
        end
    end
    return message
end

return RandConditions
