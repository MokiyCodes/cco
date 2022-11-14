local base64 = require 'base64'
local encrypted = '_ENCRYPTME'
if encrypted ~= '_' .. 'ENCRYPTME' then
  encrypted = base64.Decode(encrypted)
end
return { encryped = encrypted }
