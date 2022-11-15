-- unique keys library
-- doesnt work as a standalone
local checkIfIsKey = function(kv)
  return string.sub(kv, 1, 3) ~= '!!!'
end
local keys = {
  --- password hmac key
  ['pw'] = '!!!pw',
  --- encrypted using keys.Eenc..hmac(pass,keys.pw) - For encryption
  ['enc'] = '!!!enc',
  --- key used to encrypt enc | avoid using this if possible
  ['Eenc'] = '!!!Eenc',
  --- password used in installation id calculations
  ['uid'] = '!!!uid',
}
for k, v in pairs(keys) do
  if not checkIfIsKey(v) then
    keys[k] = require 'rstr'(512)
  end
end
local shouldB64Decode = false
if shouldB64Decode then
  for k, v in pairs(keys) do
    keys[k] = require('base64').Decode(v)
  end
end
return keys
