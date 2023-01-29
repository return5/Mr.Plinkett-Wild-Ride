local Nadine <const> = require('actions.Nadine')

local Hooker <const> = { kill = {},kidnap = {} }
Hooker.__index = Hooker
_ENV = Hooker

local function failed(plinkett)
    plinkett:adjustScore(-10)
    return true,"You try to kill her, but you forgot where you put the key to the basement so you put it off till another day.\n"
end

local function lucidKillFunc(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(1)
    plinkett:killHooker()
    return true,"You get sick of hearing about her baby, so you suffocate her in a crawl space using raid.\n",plinkett:adjustBrainValue(-1,rand)
end

local function lucidEscape(plinkett,rand,options)
    plinkett:adjustScore(-100)
    plinkett:adjustPoliceChance(0)
    plinkett.hooker = false
    Nadine.setNadineOptions(options,plinkett)
    return true,"After promising to watch Revenge Of The Sith with you, she tricks you and runs away.\n",plinkett:adjustBrainValue(-2,rand)
end

local lucidHookerMssg <const> = {
    lucidKillFunc,lucidKillFunc,lucidKillFunc,lucidKillFunc,lucidEscape,failed,failed,failed,failed,failed
}

local function crazyEscape(plinkett,rand,options)
    plinkett:adjustScore(-100)
    plinkett:adjustPoliceChance(0)
    plinkett.nadineRevenge = true
    Nadine.setNadineOptions(options,plinkett)
    return true,"While trying to feed her some delicious pizza rolls she kicks you runs away.\n",plinkett:adjustBrainValue(-2,rand)
end

local function crazyKill(plinkett,rand)
    plinkett:adjustScore(25)
    plinkett:adjustPoliceChance(1)
    plinkett:killHooker()
    return true,"You force her to eat pizza rolls and watch Attack Of The Clones on repeat until she can't take it anymore and kills herself.",plinkett:adjustBrainValue(-2,rand)
end

local crazyHookerMssg = {
    crazyEscape,crazyKill,crazyKill,crazyKill,crazyKill,failed,failed,failed,failed,failed
}

Hooker.kill[true] = lucidHookerMssg
Hooker.kill[false] = crazyHookerMssg
return Hooker