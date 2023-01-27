 local Helpers <const> = {}
 Helpers.__index = Helpers


 function Helpers.remainAboveZero(val,val2)
     local val3 <const> = val + val2
     if val3 < 0 then
         return 0
     end
     return val3
 end

 return Helpers
