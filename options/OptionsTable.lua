local Option <const> = require('options.Option')
local Dispatcher <const> = require('dispatcher.Dispatcher')

--master list of all options
return {
    CallMikeJay = Option:new("Call Mike And Jay to fix VCR.",Dispatcher.callMikeJay),
    BrainMedicine = Option:new("Take brain medicine.", Dispatcher.brainMedicine),
    YoutubeVideo = Option:new("Make a review on Youtube.",Dispatcher.youtubeVideo),
    KidnapHooker = Option:new("Kidnap a hooker.",Dispatcher.kidnapHooker),
    KidnapClub = Option:new("Kidnap woman from club.",Dispatcher.kidnapClub),
    CocktailWaitress = Option:new("Take a trip to Trump casino.",Dispatcher.cocktailWaitress),
    NightCourt = Option:new("Watch Night Court tape",Dispatcher.nightCourt),
    BuyPizzaRoll = Option:new("Buy some pizza rolls.",Dispatcher.buyPizzaRoll),
    EatPizzaRoll = Option:new("Eat some pizza rolls.",Dispatcher.eatPizzaRoll),
    SocialSecurity = Option:new("Get Social Security check.",Dispatcher.socialSecurity),
    SendPizzaRoll = Option:new("Send pizza rolls to web zone commenters.",Dispatcher.sendPizzaRoll),
    KillHooker = Option:new("Kill hooker.",Dispatcher.killWoman),
    KillWoman = Option:new("Kill woman you kidnapped.",Dispatcher.killWoman),
    KillWife = Option:new("Kill wife.",Dispatcher.killWoman),
    KillMikeJay = Option:new("Kill Mike and Jay.",Dispatcher.killMikeJay),
    FindNightCourt = Option:new("Find your lost Night Court tape.",Dispatcher.findNightCourt),
    FightPolice = Option:new("Fight the police. Refuse to go down without a fight.",Dispatcher.fightPolice),
    Surrender = Option:new("Surrender to the police.",Dispatcher.surrender),
    Quit = Option:new("Quit the game.",Dispatcher.quit)
}
