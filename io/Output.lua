local io <const> = io
local unpack <const> = table.unpack
local Input <const> = require('io.Input')

local Output <const> = {}
Output.__index = Output

_ENV = Output

function Output.write(...)
    io.write(unpack({...}))
end

function Output.clearScrn()
    io.write("\027[H\027[2J\027[3J")
end

function Output.writeAndWait(...)
    Output.write(...)
    Input.readLine()
    Input.readLine()

end

function Output.clearAndPrint(...)
    Output.clearScrn()
    Output.write(...)
end

return Output
