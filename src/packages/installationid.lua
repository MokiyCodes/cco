local uniqueKeys, xor, hash = require 'uniquekeys', require 'xor', require 'hash'
local api = {
  --- calculates & returns the installation id | persists across backups
  ['get'] = function()
    return hash.sha3_512(xor('installationid', uniqueKeys.uid))
  end,
  ['set'] = function()
    error 'Cannot set installation id!'
  end,
}
_G.InstallationID = api
return api
