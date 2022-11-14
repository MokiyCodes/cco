-- unique keys library
-- doesnt work as a standalone
local checkIfIsKey = function(kv)
  return string.sub(kv, 1, 3) ~= '!!!'
end
local keys = {
  ['pw'] = '!!!pw', -- password hmac key
  ['enc'] = '!!!enc', -- general encryption key
  ['Eenc'] = '!!!Eenc', -- password used to encrypt enc, concatted with the result of hmac(pass,pw)
}
for k, v in pairs(keys) do
  if not checkIfIsKey(v) then
    keys[k] = require 'rstr'(512)
  end
end
return keys
