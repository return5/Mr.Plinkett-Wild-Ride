
local Wife <const> = {kill = {},kidnap = {}}
Wife.__index = Wife
_ENV = Wife

local function crazyKillFail(plinkett,rand)
    plinkett:adjustScore(-55)
    plinkett:adjustPoliceChance(10)
    plinkett.policeMessage = {"Your wife called the police after you tried to make her have an accident.\n"}
    return true,"You tired to do what the pizza rolls want you to do, but your wife ran away.\n",plinkett:adjustBrainValue(-5,rand)
end

local function crazyKill(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(4)
    plinkett.wife = false
    plinkett:killWife()
    return true,"You did what the pizza roll told you to do.\n",plinkett:adjustBrainValue(-3,rand)
end

local function successKill(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(2)
    plinkett.wife = false
    plinkett:killWife()
    return true,"Your wife just had an unrelated accident.\n",plinkett:adjustBrainValue(-2,rand)
end

local function lucidFailed(plinkett)
    plinkett:adjustScore(-55)
    plinkett:adjustPoliceChance(10)
    plinkett.policeMessage = {"Your wife called the police to report what you tried to do.\n"}
    return true,"You had a lucid moment and realized what you were trying to do. Your wife calls the police\n"
end

local function failedKill(plinkett,rand)
    plinkett:adjustScore(-10)
    return true,"Your wife unfortunately failed to have an accident.\n",plinkett:adjustBrainValue(-1,rand)
end


local crazyKillMssg <const> = {
    crazyKill,crazyKill,crazyKill,crazyKill,failedKill,failedKill,failedKill,crazyKillFail,crazyKill
}

local lucidKillMssg <const> = {
    successKill,successKill,successKill,successKill,failedKill,failedKill,failedKill,lucidFailed,lucidFailed
}

Wife.kill[true] = lucidKillMssg
Wife.kill[false] = crazyKillMssg
return Wife
