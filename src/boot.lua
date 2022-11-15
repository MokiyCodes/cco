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
  if not fs.exists '/.cco/setting-dm.txt' then
    local f = fs.open('/.cco/setting-dm.txt', 'w')
    f.write 'basalt-or-lite'
    f.close()
  end
  if not fs.exists '/.cco/frontends/' then
    fs.makeDir '/.cco/frontends'
  end
  local frontend
  local frontendFile = fs.open('/.cco/setting-dm.txt', 'r')
  frontend = frontendFile.readAll()
  frontendFile.close()
  if fs.exists('/.cco/frontends/' .. frontend .. '.lua') then
    local frontendScript = fs.open('/.cco/frontends/' .. frontend .. '.lua', 'r')
    local frontendCode = frontendScript.readAll()
    frontendScript.close()
    ---@diagnostic disable-next-line: deprecated
    local byte, err = (loadstring or load)(frontendCode)
    if type(byte) ~= 'function' then
      error('Compilation Error: ' .. err)
    end
    local rt = byte()
    if type(rt) == 'function' then
      rt = rt()
    end
    return rt
  else
    return require('frontends/' .. frontend)()
  end
end
