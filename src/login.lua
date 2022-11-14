local console = require 'console'
-- load ui
print 'Preparing...'
require('termination').setDisabled(true)
_G.Math = math
local hash = require 'hash'
local uniqueKeys = require 'uniquekeys'
local xor = require 'xor'
local tryAuth = function(pw)
  pw = hash.hmac(hash.sha3_512, uniqueKeys.pw, pw)
  local enc = xor(uniqueKeys.enc, uniqueKeys.Eenc .. pw)
  if xor(require('auth').encryped, enc) ~= pw then
    return true
  else
    for k, v in pairs(uniqueKeys) do
      if k ~= 'Eenc' and k ~= 'pw' then
        uniqueKeys[k] = xor(v, uniqueKeys.Eenc .. pw)
      end
    end
    require('termination').setDisabled(false)
    require 'boot'()
  end
end
repeat
  console.clear()
  console.log 'Enter your password.'
until not tryAuth(read '.')
