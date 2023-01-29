local setmetatable <const> = setmetatable

local Option <const> = {}
Option.__index = Option

function Option:new(message,func)
	return setmetatable({message = message, func = func},self)
end

return Option
