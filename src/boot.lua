local console = require 'console'
return function()
  console.clear()
  console.centerLog 'Finalizing...'
  -- provide encryption lib
  local xor = require 'xor'
  local uniqueKeys = require 'uniquekeys'
  _G.ccoEncryption = {
    -- Encrypts a string to securely store it locally
    ['encryptLocal'] = function(data)
      return xor(data, uniqueKeys.enc)
    end,
  }
  _G.ccoEncryption.decryptLocal = _G.ccoEncryption.encryptLocal
  _G._g = _G
  console.clear()
  console.centerLog 'Loading Frontend...'
  if not fs.exists '.cco/setting-dm.txt' then
    local f = fs.open('.cco/setting-dm.txt', 'w')
    f.write 'basalt-or-lite'
    f.close()
  end
  local frontend
  local frontendFile = fs.open '.cco/setting-dm.txt'
  frontend = frontendFile.readAll()
  frontendFile.close()
  require('frontends/' .. frontend)
end
