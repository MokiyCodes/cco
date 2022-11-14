-- random string library
local rchar = function(chars)
  chars = chars or 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-+[]";,./-='
  local rint = math.random(1, #chars)
  return chars:sub(rint, rint)
end
return function(len, chars)
  local str = ''
  for i = 1, len, 1 do
    str = str .. rchar(chars)
  end
  return str
end
