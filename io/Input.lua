local read <const> = io.read

local Input <const> = {}
Input.__index = Input

_ENV = Input

function Input.readNumber()
	return read("n")
end

function Input.readString()
	return read("l")
end

function Input.readLine()
	return read("L")
end

return Input
