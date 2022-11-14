local console = require 'console'
-- Load Deps
console.clear()
console.log 'Loading Dependencies...'
local hash = require 'hash'
local chime = require 'misc/chime'
local xor = require 'xor'
console.clear()
-- Play chime, say hello, all that jazz
term.setCursorBlink(false)
console.centerLog 'Welcome!'
chime()
sleep(1)

-- password input
local requestPassword = function()
  return read '.'
end
local pw = ''
while #pw < 1 do
  console.clear()
  print 'First, we\'re gonna need you to set a password.\n\nRemember it; the device will be unsuable without it.\n\nMust be 8 characters or more.\n'
  console.logNoNl 'Password => '
  pw = requestPassword()
end

-- password validation
local success = false
while not success do
  console.clear()
  print 'Now, please repeat that password.\n\nForgot it?\nPress ctrl + t for a few seconds & try again.\n'
  console.logNoNl 'Repeat Password => '
  success = read '.' == pw
end

-- notify user what we're doing
console.clear()
console.centerLog 'Setting up Encryption for you...'

-- unique device keys
local uniqueKeys = require 'uniquekeys'

-- hash password
---@diagnostic disable-next-line: cast-local-type
pw = hash.hmac(hash.sha3_512, uniqueKeys.pw, pw)

-- encrypt keys
local authStoreThing = require 'auth'
local base64 = require 'base64'
local script = thisBundle
authStoreThing.encryped = base64.Encode(xor(pw, uniqueKeys.enc))
local newUniqueKeys = {}
for k, v in pairs(uniqueKeys) do
  if k ~= 'pw' and k ~= 'Eenc' then
    uniqueKeys[k] = xor(v, uniqueKeys.Eenc .. pw)
  end
  newUniqueKeys[k] = base64.Encode(uniqueKeys[k])
  script = string.gsub(script, '!!!' .. k, newUniqueKeys[k])
end
script = string.gsub(script, 'local shouldB64Decode = false', 'local shouldB64Decode = true')

sleep(0.2)
console.clear()
console.log 'Do you wish to install this system-wide (y), or as an application (N)? [y/N]'
local systemWide = string.lower(string.sub(read(), 1, 1)) == 'y'
console.clear()
console.centerLog 'Installing...'
script = string.gsub(script, '_ENCRYPTME', authStoreThing.encryped)
local file = fs.open('/cco.lua', 'w')
file.write(script)
file.close()
if systemWide then
  local file2 = fs.open('/startup.lua', 'w')
  file2.write(script)
  file2.close()
end
sleep(0.4)
console.clear()
if systemWide then
  console.centerLog 'Shutting Down...'
  sleep(2)
  os.shutdown()
else
  console.log 'The OS is available undere the command \'cco\'.'
  sleep(0.5)
  -- console.centerLog 'Performing Initial Boot...'
  -- sleep(0.2)
  -- console.clear()
  -- require 'login'
end
