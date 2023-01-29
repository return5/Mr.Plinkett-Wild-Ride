
local NightCourt <const> = {}
NightCourt.__index = NightCourt

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

return NightCourt
