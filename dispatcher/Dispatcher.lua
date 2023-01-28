local CallMikeJayMssg <const> = require('messages.CallMikeJay')

local Dispatcher <const> = {}
Dispatcher.__index = Dispatcher

_ENV = Dispatcher

function Dispatcher.surrender(plinkett,rand,options)

end

function Dispatcher.fightPolice(plinkett,rand,options)

end

function Dispatcher.findNightCourt(plinkett,rand,options)

end

function Dispatcher.killMikeJay(plinkett,rand,options)

end

function Dispatcher.killWoman(plinkett,rand,options)

end

function Dispatcher.killWoman(plinkett,rand,options)

end

function Dispatcher.killWoman(plinkett,rand,options)

end

function Dispatcher.sendPizzaRoll(plinkett,rand,options)

end

function Dispatcher.socialSecurity(plinkett,rand)
    if not plinkett.isLucid and rand(10) > 8 then
        plinkett:adjustScore(-15)
        return true,"You got confused and lost on the way to the social security office and somehow ended up leading the gay pride parade.\n",plinkett:adjustBrainValue(-1,rand)
    end
    if not plinkett.isLucid and rand(10) > 8 then
        plinkett:adjustScore(15)
        plinkett:adjustMoney(35)
    --    plinkett.turnsSinceSS = -1
        return true,"In your confused state you told the social security office you were someone else. Luckily they didn't question this and gave you their substantially larger check.\n",plinkett:adjustBrainValue(1,rand)
    end
    if not plinkett.isLucid and rand(100) > 97 then
        plinkett:adjustScore(-200)
        plinkett.deathMssg = "You got stabbed to death by a pimp in a dark alley.\n"
        return false,"A pimp for one of the hookers you previously kidnapped recognized you and stabbed you to death in a dark alley. He also stole your social security check.\n"
    end
    if plinkett.isLucid and rand(10) > 7 then
        plinkett:adjustScore(25)
        plinkett:adjustMoney(25)
     --   plinkett.turnsSinceSS = -1
        return true,"In your unusually lucid state you remember that you are suppose to get a bigger check than usual today.\n",plinkett:adjustBrainValue(1,rand)
    end
    plinkett:adjustScore(10)
    plinkett:adjustMoney(15)
    --plinkett.turnsSinceSS = -1
    return true,"You manage to get to the social security office and get your check then make it safely back home.\n",plinkett:adjustBrainValue(.5,rand)
end

function Dispatcher.eatPizzaRoll(plinkett,rand)
    if plinkett.pizzaRolls <= 0 then
        plinkett:adjustScore(-5)
        return true,"You want to eat pizza rolls but you don't have any.This is a tragic moment.\n",plinkett:adjustBrainValue(-1,rand)
    end
    if rand(10) > 7 then
        plinkett:adjustScore(-10)
        plinkett:adjustPizzaRolls(-5)
        return true,"You cooked some pizza rolls but accidentally spilled them on yourself and burned yourself pretty bad.\n",plinkett:adjustBrainValue(-2,rand)
    end
    if rand(10) > 7 then
        plinkett:adjustScore(15)
        plinkett:eatPizzaRolls(-5)
        return true,"You opened the bag of pizza rolls and found it contains many extra pizza rolls. this brightens your mood.\n",plinkett:adjustBrainValue(2,rand)
    end
    if rand(100) > 98  then
        plinkett:adjustScore(-200)
        plinkett:eatPizzaRolls(-5)
        plinkett.deathMssg = "You choked to death on a pizza roll.It isn't a glorious way to go, but it isn't unexpected.\n"
        return false,"You were happily eating pizza rolls until you started to choke on one. It's finally the end of Plinkett.\n"
    end
    plinkett:adjustScore(5)
    plinkett:eatPizzaRolls(-5)
    return true,"You cook and eat some pizza rolls.You feel full and mentally are feeling better.\n",plinkett:adjustBrainValue(1,rand)
end

function Dispatcher.buyPizzaRoll(plinkett,rand)
    if not plinkett.isLucid and rand(10) > 4 then
        return true,"You went to the store to buy pizza rolls but somehow ended up in mexico with an unknown infection.\n",plinkett:adjustBrainValue(-2,rand)
    end
    if not plinkett.isLucid and rand(100) > 98 then
        plinkett:adjustScore(-100)
        plinkett.deathMssg = "You got hit by a car trying to buy pizza rolls\n"
        return false,"While going ot the store to buy pizza rolls you saw a dog and tried to pet it but turns out it was actually a speeding car.In your confusion you got hit.\n"
    end
    if plinkett.isLucid and rand(100) > 98 then
        plinkett:adjustScore(-100)
        plinkett.deathMssg = "You died by being thrown off a bridge.\n"
        return false,"While walking to the store you get thrown off a bridge by two mysterious men. One of them might have been amish.\n"
    end
    if plinkett.money >= 5 then
        plinkett:adjustMoney(-5)
        plinkett:adjustScore(10)
        plinkett:adjustPizzaRolls(10)
        return true,"You went to the store and bought some more pizza rolls.You cant wait to get home and eat some.\n",plinkett:adjustBrainValue(1,rand)
    end
    if not plinkett.isLucid then
        return true,"You went to buy pizza rolls but were forced out of the store after yelling at can of beans for an hour.\n",plinkett:adjustBrainValue(-2,rand)
    end
    return true,"You went to the store to buy pizza rolls but they wouldn't give you any since you don't have any money.\n",plinkett:adjustBrainValue(-1,rand)
end

function Dispatcher.nightCourt(plinkett,rand)
    if not plinkett.vcrFixed then
        if plinkett.mikeJayDead then
            return true,"You remember that you killed Mike and Jay, so now your VCR will never get fixed. You will never watch your precious Night Court tape ever again. this saddens you.\n",plinkett:adjustBrainValue(-3,rand)
        end
        if plinkett.mikeJay and rand(10) > 6 then
            return true,"You try to watch night court but Mike and Jay remind you that your VCR is broken and that's why you call them to your house. You don't remember any of this.", plinkett:adjustBrainValue(-.5,rand)
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

function Dispatcher.cocktailWaitress(plinkett,rand,options)

end

function Dispatcher.kidnapClub(plinkett,rand,options)

end

function Dispatcher.kidnapHooker(plinkett,rand,options)

end

function Dispatcher.youtubeVideo(plinkett,rand)
    if rand(10) > 8 then
        return true,"You Couldn't figure out how to turn on your Camera so you gave up.\n",plinkett:adjustBrainValue(-1,rand)
    end
    if rand(10) > 8 then
        return true,"You started to make the video but got so upset with your grand-kids for messing with your plastic bin that you quit in a rage.\n",plinkett:adjustBrainValue(-2,rand)
    end
    if plinkett.mikeJay and rand(10) > 5 then
        return true,"Mike and Jay said your youtube video was keeping them from fixing your VCR so you stopped making it.\n"
    end
    if plinkett.hooker and rand(13) > 9 then
        plinkett:adjustVideos(1)
        plinkett:changePoliceChance(3)
        return true,"You made a youtube video reviewing a movie you hate.Unfortunately you accidentally included footage of the hooker you kidnapped.",plinkett:adjustBrainValue(-1,rand)
    end
    if plinkett.clubGirl and rand(13) > 9 then
        plinkett:adjustVideos(1)
        plinkett:changePoliceChance(3)
        return true,"You successfully uploaded a youtubes video reviewing a bad movie.You didnt know how to remove the video showing the kidnapped girl in your basement.",plinkett:adjustBrainValue(-1,rand)
    end
    plinkett:adjustVideos(1)
    return true,"You created and then uploaded a video to youtube reviewing a movie. You feel a sense of relief from it.",plinkett:adjustBrainValue(1,rand)
end

function Dispatcher.brainMedicine(plinkett,rand)
    return true,plinkett:takeBrainMedicine(rand)
end

function Dispatcher.callMikeJay(plinkett,rand)
    if plinkett.mikeJayDead then
        return true,"You went to call Mike and Jay to fix your VCR but remembered that you killed them.This brings a smile to your face\n", plinkett:adjustBrainValue(1,rand)
    end
    if plinkett.mikeJay then
        return true,"You try to call Mike and Jay but you later realize they are already at your house.This darkens your mood.\n",plinkett:adjustBrainValue(-1,rand)
    end
    local option <const> = CallMikeJayMssg[plinkett.isLucid][rand(#CallMikeJayMssg[plinkett.isLucid])]
    return option.func(plinkett,rand),option.message
end

function Dispatcher.quit(plinkett)
    plinkett.deathMssg = "You quit, you quitter."
    return false,"You quit the game. Life as Plinkett isn't for the faint of heart."
end

return Dispatcher