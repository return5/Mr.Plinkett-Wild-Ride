local io <const> = io
local unpack <const> = table.unpack

local Output <const> = {}
Output.__index = Output

_ENV = Output

function Output.write(...)
    io.write(unpack({...}))
end

return Output
