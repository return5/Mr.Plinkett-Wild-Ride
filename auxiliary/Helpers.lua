local OptionsTable <const> = require('options.OptionsTable')

local Helpers <const> = {}
Helpers.__index = Helpers


function Helpers.resetOptions(options)
	for k,_ in pairs(options) do
		options[k] = nil
	end
end


function Helpers.setOptions(plinkett,options)
	if not plinkett.mikeJayDead  then
		options.CallMikeJay = OptionsTable.CallMikeJay
	end
	options.BrainMedicine = OptionsTable.BrainMedicine
	options.EatPizzaRoll = OptionsTable.EatPizzaRoll
	options.NightCourt = OptionsTable.NightCourt
	options.SocialSecurity = OptionsTable.SocialSecurity
	options.BuyPizzaRoll = OptionsTable.BuyPizzaRoll
	options.Quit = OptionsTable.Quit
end

function Helpers.remainAboveZero(val,val2)
	local val3 <const> = val + val2
	if val3 < 0 then
		return 0
	end
	return val3
end

return Helpers
