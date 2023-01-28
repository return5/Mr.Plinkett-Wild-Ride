
local setmetatable <const> = setmetatable
local Helpers <const> = require('auxiliary.Helpers')
local BadBrainStateMessages <const> = require('messages.BadBrainState')
local GoodBrainStateMessages <const> = require('messages.GoodBrainState')
local abs <const> = math.abs

local Character <const> = {mentalState = 0,money = 10,medicineCount = 0,isLucid = true,pizzaRolls = 0,
                           hasNightCourt = true,vcrFixed = false,mikeJay = false,deathMssg = "",police = false,hooker = false,
                           wife = false, clubGirl =false,policeChance = 0,score = 0,ss = false,mikeJayDead = false,
                           discoveredMissingNightCourt = false,nightCourtMssg = "",totalPizzaRolls = 0,totalBrainMedicine = 0,
                           policeMessage = {"Your neighbors called the cops to do a wellness check on you."},
                           wivesKilled = 0, hookersKilled = 0, clubWomenKilled = 0,totalPizzaRollsWeb = 0,youtubesMade = 0}
Character.__index = Character

_ENV = Character

function Character:changeBrainState(val)
    self.mentalState = self.mentalState + val
end

function Character:changeMedicineCount(val)
    self.medicineCount = Helpers.remainAboveZero(self.medicineCount,val)
end

function Character:TakeBrainMedicine(rand)
    if self.medicineCount <= 0 then
        return "You are out of brain medicine."
    end
    self:changeMedicineCount(-1)
    self.totalBrainMedicine = self.totalBrainMedicine + 1
    self:improveBrainState(10,rand)
end

function Character:improveBrainState(val,rand)
    self:changeBrainState(val)
    if self.mentalState > -10 then
        self.isLucid = true
    end
    return GoodBrainStateMessages[rand(#GoodBrainStateMessages)]
end

function Character:worsenBrainState(val,rand)
    self:changeBrainState(val)
    if self.mentalState < -10 then
        self.isLucid = false
    end
    return BadBrainStateMessages[rand(#BadBrainStateMessages)]
end

function Character:adjustBrainValue(val,rand)
    if val < 0 then
        return self:worsenBrainState(val,rand)
    end
    return self:improveBrainState(val,rand)
end

function Character:adjustMoney(val)
    self.money = self.money + val
end

function Character:changeScore(val)
    self.score = Helpers.remainAboveZero(self.score,val)
end

function Character:ChangePoliceChance(val)
    self.policeChance = Helpers.remainAboveZero(self.policeChance,val)
end

function Character:adjustScore(val)
    self.score = self.score + val
end

function Character:killWife()
    self.wife = false
    self.wivesKilled = self.wivesKilled + 1
end

function Character:killWoman()
    self.clubGirl = false
    self.clubWomenKilled = self.clubWomenKilled + 1
end

function Character:killHooker()
    self.hooker = false
    self.hookersKilled = self.hookersKilled + 1
end

function Character:cmpBrainState(prevState)
    if (prevState ~= 0 and self.mentalState == 0) or (prevState == 0 and self.mentalState ~= 0)  then
        if abs(self.mentalState - prevState) >= 1 then return true end
        return false
    end
    local top <const> = abs(self.mentalState) > abs(prevState) and prevState or self.mentalState
    local bottom <const> = top == self.mentalState and self.mentalState or prevState
    --TODO adjust this value
    return abs((top/bottom) * 100) > 2
end

function Character:adjustPizzaRolls(val)
    self.pizzaRolls = Helpers.remainAboveZero(self.pizzaRolls,val)
end

function Character:eatPizzaRolls(val)
    local prev <const> = self.pizzaRolls
    self:adjustPizzaRolls(val)
    self.totalPizzaRolls = self.totalPizzaRolls + abs(prev - self.pizzaRolls)
end

function Character:checkPoliceMessage(message)
    for i=1,#self.policeMessage,1 do
        if self.policeMessage[i] == message then return true end
    end
    return false
end

function Character:adjustVideos(val)
    self.youtubesMade = self.youtubesMade + val
end

function Character:changePoliceChance(val)
    self.policeChance = Helpers.remainAboveZero(self.policeChance,val)
end

function Character:new()
    return setmetatable({ },self)
end

return Character
