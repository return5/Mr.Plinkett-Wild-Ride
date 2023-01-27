local io <const> = io

local Input <const> = {}
Input.__index = Input

_ENV = Input

function Input.readNumber()
    return io.read("n")
end

function Input.readLine()
    return io.read("L")
end

return Input
