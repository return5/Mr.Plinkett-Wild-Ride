local SocialSecurity <const> = {}
SocialSecurity.__index = SocialSecurity
_ENV = SocialSecurity

local function crazyLost(plinkett,rand)
	plinkett:adjustScore(-15)
	return true,"You got confused and lost on the way to the social security office and somehow ended up leading the gay pride parade.\n",plinkett:adjustBrainValue(-1,rand)
end

local function crazyGetMore(plinkett,rand)
	plinkett:adjustScore(15)
	plinkett:adjustMoney(35)
	plinkett.turnsSinceSS = -1
	return true,"In your confused state you told the social security office you were someone else. Luckily they didn't question this and gave you the substantially larger check.\n",plinkett:adjustBrainValue(1,rand)
end

local function crazyDeath(plinkett)
	plinkett:adjustScore(-200)
	plinkett.deathMssg = "You got stabbed to death by a pimp in a dark alley.\n"
	return false,"A pimp for one of the hookers you previously kidnapped recognized you and stabbed you to death in a dark alley. He also stole your social security check.\n"
end

local function lucidGetMore(plinkett,rand)
	plinkett:adjustScore(25)
	plinkett:adjustMoney(25)
	plinkett.turnsSinceSS = -1
	return true,"In your unusually lucid state you remember that you are suppose to get a bigger check than usual today.\n",plinkett:adjustBrainValue(1,rand)
end

local function success(plinkett,rand)
	plinkett:adjustScore(10)
	plinkett:adjustMoney(15)
	plinkett.turnsSinceSS = -1
	return true,"You manage to get to the social security office and get your check then make it safely back home.\n",plinkett:adjustBrainValue(.5,rand)
end

SocialSecurity[true] = {
	success,success,success,success,lucidGetMore
}

SocialSecurity[false] = {
	crazyDeath,crazyGetMore,crazyGetMore,crazyGetMore,crazyLost,crazyLost,crazyLost,success,success,success,success
}

return SocialSecurity
