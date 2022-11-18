local console = require 'console'
return function()
  console.clear()
  console.centerLog 'Finalizing...'
  -- provide encryption lib
  local xor = require 'xor'
  local uniqueKeys = require 'uniquekeys'
  --- XOR encryption
  _G.ccoEncryption = {
    -- Encrypts a string to securely store it locally
    ['encryptLocal'] = function(data)
      return xor(data, uniqueKeys.enc)
    end,
    --- Encrypts/Decrypts a string for remote sending
    ['encryptWithKey'] = function(data, key)
      return xor(data, key)
    end,
  }
  _G.ccoEncryption.decryptLocal = _G.ccoEncryption.encryptLocal
  _G.ccoEncryption.decryptWithKey = _G.ccoEncryption.encryptWithKey
  _G.ccoEncryption.xor = _G.ccoEncryption
  _G.libs = _G.libs or {}
  _G.libs.encryption = _G.ccoEncryption
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
    local rt = byte(require 'applications')
    if type(rt) == 'function' then
      rt = rt(require 'applications')
    end
    return rt
  else
    if not shell then
      error 'No shell.\nPlease try again.'
    end
    _G.shell = _G.shell or shell
    return require('frontends/' .. frontend)(require 'applications')
  end
end
