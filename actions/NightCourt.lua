
local NightCourt <const> = {find = {}}
NightCourt.__index = NightCourt
_ENV = NightCourt

function NightCourt.watchNightCourt(plinkett,rand)
	if not plinkett.vcrFixed then
		if plinkett.mikeJayDead then
			return true,"You remember that you killed Mike and Jay, so now your VCR will never get fixed. You will never watch your precious Night Court tape ever again. this saddens you.\n",plinkett:adjustBrainValue(-3,rand)
		end
		if plinkett.mikeJay and rand(10) > 6 then
			return true,"You try to watch night court but Mike and Jay remind you that your VCR is broken and that's why you called them to your house. You don't remember any of this.", plinkett:adjustBrainValue(-.5,rand)
		end
		if rand(10) > 6 then
			return true,"Your VCR is broken. Perhaps you should call those two guys to get over here to fix your VCR so you can finally watch Night Court.\n"
		end
	end
	if not plinkett.hasNightCourt then
		if not plinkett.discoveredMissingNightCourt then
			plinkett.discoveredMissingNightCourt = true
			return true,plinkett.nightCourtMssg,plinkett:adjustBrainValue(-3,rand)
		end
		return true,"You sit down to watch Night Court but remember that your tape has been lost. this brings you to despair.\n",plinkett:adjustBrainValue(-2,rand)
	end
	if plinkett.vcrFixed and plinkett.hasNightCourt then
		plinkett.deathMssg = "The VCR is fixed and You can watch your precious Night Court tape. You are at peace with the world,Everything is going to be okay.\n"
		plinkett:adjustScore(200)
		return false,"You sit down in your chair and watch an episode of Night Court. All is good and well with the world.\n",plinkett:adjustBrainValue(100,rand)
	end
	return true,"Your VCR is broken. Perhaps you should call those two guys to get over here to fix your VCR so you can finally watch Night Court.\n"
end

local function findSuccess(plinkett,rand)
	plinkett:adjustScore(20)
	plinkett.hasNightCourt = true
	plinkett.discoveredMissingNightCourt = false
	plinkett.nightCourtMssg = ""
	return true,"You found your precious Night Court tape.You feel like a heavy weight has been taken off your shoulders.\n",plinkett:adjustBrainValue(2,rand)
end

local function findFailure(plinkett,rand)
	plinkett:adjustScore(-10)
	return true,"You failed to find your Night Court tape. You don't know how much longer you can live without Night Court.\n",plinkett:adjustBrainValue(-1,rand)
end

local function findDeath(plinkett)
	plinkett:adjustScore(-100)
	plinkett.deathMssg = "You died searching for your Night Court tape.Shame you dided before ever getting ot watch it.\n"
	return false,"While searching for Night Court your book case fell on top of oyu pinning you down." .. plinkett.mikeJay and "Mike and Jay saw you but couldn't be bothered to help and now you are dead.\n" or
			(not plinkett.mikeJayDead and "Mike and Jay eventually discovered your body when they came over to fix the VCR, took them three days to notice you were dead.\n" or "Nobody ever discovered you. You died and were left shut in the house forever.\n")
end

local function findExtra(plinkett,rand)
	plinkett:adjustScore(35)
	plinkett.hasNightCourt = true
	plinkett.discoveredMissingNightCourt = false
	plinkett.nightCourtMssg = ""
	return true,"You not only found your copy of Night Court but you also found a VHS copy of a Matlock episode.\n",plinkett:adjustBrainValue(4,rand)
end

local function findFailureCrazy(plinkett,rand)
	plinkett:adjustScore(-20)
	return true,"While searching for Night Court in your creepy basement you get distracted talking to the pile of bones in the corner.You never did find the tape.\n",plinkett:adjustBrainValue(-2,rand)
end

NightCourt.find[true] = {
	findSuccess,findSuccess,findSuccess,findSuccess,findFailure,findFailure,findFailure,findFailure,findDeath,findExtra,findExtra,
}

NightCourt.find[false] = {
	findSuccess,findSuccess,findSuccess,findFailure,findFailure,findFailure,findDeath,findExtra,findExtra,findFailureCrazy,findFailureCrazy
}

return NightCourt
