local Youtubes <const> = {}
Youtubes.__index = Youtubes
_ENV = Youtubes

local function returnRandom(plinkett,rand)
    --doing it this way, there is a very small possibility of infinite loop, and a large possibility of a long loop. still small chance though.
    return Youtubes.success[rand(#Youtubes.success)](plinkett,rand)
end

local function success(plinkett,rand)
    plinkett:adjustVideos(1)
    plinkett:adjustChanceToGetMoney(1)
    return true,"You created and then uploaded a video to youtube reviewing a movie. You feel a sense of relief from it.\n",plinkett:adjustBrainValue(1,rand)
end

local function cameraFail(plinkett,rand)
    return true,"You Couldn't figure out how to turn on your Camera so you gave up.\n",plinkett:adjustBrainValue(-1,rand)
end

local function grandKidsFail(plinkett,rand)
    return true,"You started to make the video but got so upset with your grand-kids for messing with your plastic bin that you quit in a rage.\n",plinkett:adjustBrainValue(-2,rand)
end

local function mikeJayFail(plinkett,rand)
    if plinkett.mikeJay then
        return true,"Mike and Jay said your youtube video was keeping them from fixing your VCR so you stopped making it.\n"
    end
    return Youtubes.failed[rand(#Youtubes.failed)](plinkett,rand)
end

local function successHooker(plinkett,rand)
    if plinkett.hooker then
        plinkett:adjustVideos(1)
        plinkett:changePoliceChance(3)
        plinkett:adjustChanceToGetMoney(2)
        return true,"You made a youtube video reviewing a movie you hate.Unfortunately you accidentally included footage of the hooker you kidnapped.\n",plinkett:adjustBrainValue(-1,rand)
    end
    return returnRandom(plinkett,rand)
end

local function clubGirlSuccess(plinkett,rand)
    if plinkett.clubGirl then
        plinkett:adjustVideos(1)
        plinkett:changePoliceChance(3)
        plinkett:adjustChanceToGetMoney(2)
        return true,"You successfully uploaded a youtubes video reviewing a bad movie.You didnt know how to remove the video showing the kidnapped girl in your basement.\n",plinkett:adjustBrainValue(-1,rand)
    end
    return returnRandom(plinkett,rand)
end

local function successWivesKilled(plinkett,rand)
    if plinkett.wivesKilled > 0 then
        plinkett:adjustVideos(1)
        plinkett:changePoliceChance(2)
        plinkett:adjustChanceToGetMoney(2)
        return true,"You make a video review of a bad movie and upload it to youtube. In your state of confusion you mentioned your dead wife in the video. You cant recall if you admitted to killing her or not.\n",plinkett:adjustBrainValue(-1,rand)
    end
    return returnRandom(plinkett,rand)
end

Youtubes.success = {
    success,success,success,successWivesKilled,clubGirlSuccess,successHooker
}

Youtubes.failed = {
    mikeJayFail,cameraFail,grandKidsFail
}

return Youtubes
