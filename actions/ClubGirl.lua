local ClubGirl <const> = {kill = {}}
ClubGirl.__index = ClubGirl

_ENV = ClubGirl

local function crazyKill(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(1)
    plinkett.policeMessage.clubGirlKilled = "The police found the body parts of the girl you vut up.\n"
    plinkett.clubGirl = false
    plinkett:killWoman()
    return true,"You chop her up in a bathtub, remembering to swing the cleaver really hard like the pizza roll told you to.\n",plinkett:adjustBrainValue(-1,rand)
end

local function crazyEscape(plinkett)
    plinkett:adjustScore(-50)
    plinkett:adjustPoliceChance(10)
    plinkett.policeMessage = {clubGirl = "You are arrested for kidnapping the woman outside the club.\n"}
    plinkett.clubGirl = false
    return true,"She convinces you to take her back to the club for pizza rolls. once there she calls security on you.\n"
end

local function lucidEscape(plinkett,rand)
    plinkett:adjustScore(-50)
    plinkett:adjustPoliceChance(10)
    plinkett.policeMessage = {clubGirl = "The girl you kidnapped outside the club called the cops on you.\n"}
    plinkett.clubGirl = false
    return true,"While attempting to throw her into the old freezer, she overpowers you and runs away.",plinkett:adjustBrainValue(-2,rand)
end

local function success(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(1)
    plinkett.clubGirl = false
    plinkett.policeMessage.clubGirlKilled = "The police found the bones left over from the girl you fed tot he cockroaches.\n"
    plinkett:killWoman()
    return true,"After failing to put the puzzle together, you throw the girl into a freezer full of flesh eating cockroaches.\n",plinkett:adjustBrainValue(-1,rand)
end

local function failed(plinkett,rand)
    plinkett:adjustScore(-10)
    return true,"Unfortunately you didn't manage to kill her. perhaps next time.\n",plinkett:adjustBrainValue(-1,rand)
end

ClubGirl.kill[true] = {
   success,success,success,success,failed,failed,failed,lucidEscape,lucidEscape
}

ClubGirl.kill[false] = {
    crazyKill,crazyKill,crazyKill,crazyKill,failed,failed,failed,crazyEscape,crazyEscape
}

local function kidnapSuccess(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(1)
    plinkett.clubGirl = true
    plinkett.policeMessage.clubGirlKidnapped = "Someone reported the clubGirl missing."
    return true,"You find a girl outside a club and throw her in your trunk.  "
end

local function kidnapFail(plinkett,rand)

end

local function kidnapCrazyFail(plinkett,rand)

end

local function kidnapCrazySuccess(plinkett,rand)

end

local function kidnapDeath(plinkett)

end

ClubGirl.kidnap = {
   kidnapSuccess,kidnapCrazySuccess,kidnapCrazyFail,kidnapFail,kidnapDeath
}

return ClubGirl