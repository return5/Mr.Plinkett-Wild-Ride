
local Helpers <const> = {}
Helpers.__index = Helpers


function Helpers.setNadineOptions(options,plinkett)
	Helpers.resetOptions(options)
	options.FightNadine = Helpers.optionsTable.FightNadine
	options.surrenderNadine = Helpers.optionsTable.SurrenderNadine
	options.EatPizzaRollsNadine = Helpers.optionsTable.EatPizzaRollsNadine
	if plinkett.vcrFixed and plinkett.hasNightCourt then
		options.WatchNightCourtNadine = Helpers.optionsTable.NightCourtNadine
	end
end

function Helpers.resetOptions(options)
	for k,_ in pairs(options) do
		options[k] = nil
	end
end

function Helpers.setOptions(plinkett,options)
	if not plinkett.mikeJayDead  then
		options.CallMikeJay = Helpers.optionsTable.CallMikeJay
	end
	options.BrainMedicine = Helpers.optionsTable.BrainMedicine
	options.EatPizzaRoll = Helpers.optionsTable.EatPizzaRoll
	options.NightCourt = Helpers.optionsTable.NightCourt
	options.SocialSecurity = Helpers.optionsTable.SocialSecurity
	options.BuyPizzaRoll = Helpers.optionsTable.BuyPizzaRoll
	options.Quit = Helpers.optionsTable.Quit
end

function Helpers.remainAboveZero(val,val2)
	local val3 <const> = val + val2
	if val3 < 0 then
		return 0
	end
	return val3
end

return Helpers
