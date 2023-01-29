
local OptionsTable <const> = require('options.OptionsTable')

local Nadine <const> = {}
Nadine.__index = Nadine

_ENV = Nadine

local function resetOptions(options)
    for k,_ in pairs(options) do
        options[k] = nil
    end
end

function Nadine.fightNadine(plinkett,rand,options)

end

function Nadine.surrenderNadine(plinkett,rand,options)

end

function Nadine.eatPizzaRollsNadine(plinkett,rand,options)

end

function Nadine.nightCourtNadine(plinkett,rand,options)

end


function Nadine.setNadineOptions(options,plinkett)
    resetOptions(options)
    options.FightNadine = OptionsTable.FightNadine
    options.surrenderNadine = OptionsTable.SurrenderNadine
    options.EatPizzaRollsNadine = OptionsTable.EatPizzaRollsNadine
    if plinkett.vcrFixed and plinkett.hasNightCourt then
        options.WatchNightCourtNadine = OptionsTable.NightCourtNadine
    end
end

return Nadine
