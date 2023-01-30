
local OptionsTable <const> = require('options.OptionsTable')
local Helpers <const> = require('auxiliary.Helpers')

local Nadine <const> = {}
Nadine.__index = Nadine

_ENV = Nadine

function Nadine.fightNadine(plinkett,rand,options)

end

function Nadine.surrenderNadine(plinkett,rand,options)

end

function Nadine.eatPizzaRollsNadine(plinkett,rand,options)

end

function Nadine.nightCourtNadine(plinkett,rand,options)

end


function Nadine.setNadineOptions(options,plinkett)
	Helpers.resetOptions(options)
	options.FightNadine = OptionsTable.FightNadine
	options.surrenderNadine = OptionsTable.SurrenderNadine
	options.EatPizzaRollsNadine = OptionsTable.EatPizzaRollsNadine
	if plinkett.vcrFixed and plinkett.hasNightCourt then
		options.WatchNightCourtNadine = OptionsTable.NightCourtNadine
	end
end

return Nadine
