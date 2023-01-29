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
    plinkett.policeMessage.clubGirlKidnapped = "Someone reported the clubGirl missing.\n"
    return true,"You find a girl outside a club and throw her in your trunk. \n",plinkett:adjustBrainValue(-1,rand)
end

local function kidnapFail(plinkett,rand)
    plinkett:adjustScore(-25)
   return true,"You failed to find a suitable woman to kidnap.\n"
end

local function kidnapCrazyFail(plinkett,rand)
    plinkett:adjustScore(-25)
    plinkett:adjustPoliceChance(2)
    plinkett.policeMessage.clubGirlKidnapped = ""
    return true,"You tried to kidnap a woman outside a club, She saw how crazy you are and yelled something about get away form me you creepy old weird sex pervert.\n.",plinkett:adjustBrainValue(-1,rand)
end

local function kidnapCrazySuccess(plinkett,rand)
    plinkett:adjustScore(50)
    plinkett:adjustPoliceChance(2)
    plinkett.clubGirl = true
    plinkett.policeMessage.clubGirlKidnapped = "The CDC tracked the source of the macarena virus infection back to your house.They are here with the police.\n"
    return true,"You go to the club and infect everyone with the macarena virus.You convince a woman to come home with you to find a cure.\n",plinkett:adjustBrainValue(-2,rand)
end

local function kidnapDeath(plinkett)
    plinkett:adjustScore(-100)
    plinkett.deathMssg("You died while driving to kidnap a woman form the local club.\n")
    return false,"You were driving erratically and thought you saw someone glowing in the dark. You tried to run over them, but turns out it was a street lamp. You crashed your car and died.\n"
end

ClubGirl.kidnap = {
   kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapSuccess,kidnapCrazySuccess,kidnapCrazySuccess,
   kidnapCrazyFail,kidnapCrazyFail,kidnapFail,kidnapFail,kidnapFail,kidnapDeath
}

return ClubGirl