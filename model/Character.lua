
local setmetatable <const> = setmetatable
local Helpers <const> = require('auxiliary.Helpers')
local BadBrainStateMessages <const> = require('messages.BadBrainState')
local GoodBrainStateMessages <const> = require('messages.GoodBrainState')
local math <const> = math

local Character <const> = {}
Character.__index = Character

_ENV = Character

function Character:changeBrainState(val)
    self.mentalState = Helpers.remainAboveZero(self.mentalState,val)
end

function Character:changeMedicineCount(val)
    self.medicineCount = Helpers.remainAboveZero(self.medicineCount,val)
end

local function adjustBrainValue(x)
    return math.ceil(x + (x * .3))
end

function Character:TakeBrainMedicine(rand)
    if self.medicineCount <= 0 then
        return "You are out of brain medicine."
    end
    self:changeMedicineCount(-1)
    self:improveBrainState(10,rand)
end

function Character:improveBrainState(val,rand)
    self:changeBrainState(-1 * adjustBrainValue(self.mentalState))
    return GoodBrainStateMessages[rand(#GoodBrainStateMessages)]
end

function Character:worsenBrainState(val,rand)
    self:changeBrainState(adjustBrainValue(self.mentalState * val))
    return BadBrainStateMessages[rand(#BadBrainStateMessages)]
end

function Character:adjustBrainValue(val,rand)
    if val < 0 then
        local message <const> = self:worsenBrainState(val,rand)
        if self.mentalState < -10 then
            self.isLucid = false
        end
        return message
    end
    return self:improveBrainState(val,rand)
end

function Character:adjustMoney(val)
    self.money = Helpers.remainAboveZero(self.money,val)
end

function Character:changeScore(val)
    self.score = Helpers.remainAboveZero(self.score,val)
end

function Character:ChangePoliceChance(val)
    self.policeChance = Helpers.remainAboveZero(self.policeChance,val)
end

function Character:new()
    return setmetatable({mentalState = 0,money = 0,medicineCount = 0,isLucid = true,pizzaRolls = 0,
                         hasNightCourt = true,vcrFixed = false,mikeJay = false,deathMssg = "",police = false,hooker = false,
                         wife = false, clubGirl =false,policeChance = 0,score = 0,ss = false,mikeJayDead = false,
                         discoveredMissingNightCourt = false,policeMessage = {"Your neighbors called the cops to do a wellness check on you."}},self)
end

return Character
