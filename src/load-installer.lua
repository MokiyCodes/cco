local console = require 'console'
local json = require 'json'
local base64 = require 'base64'
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

local pw
-- ask for new password
local getNewPw = function()
  -- password input
  local requestPassword = function()
    return read '.'
  end
  pw = ''
  while #pw < 1 do
    console.clear()
    print 'First, we\'re gonna need you to set a password.\n\nRemember it; the device will be unsuable without it.\n\nMust be 8 characters or more.\n'
    console.logNoNl 'Password => '
    pw = requestPassword()
    break
  end

  -- password validation
  local success = false
  while not success do
    console.clear()
    print 'Now, please repeat that password.\n\nForgot it?\nPress ctrl + t for a few seconds & try again.\n'
    console.logNoNl 'Repeat Password => '
    success = read '.' == pw
  end
end
-- check for existing auth store
local overwriteUniqueKeys = {}
local overwriteAuthStoreThing
if fs.exists '/.cco/.authbackup.json' then
  console.clear()
  print 'We found a backup authentication store file.\nTypically, this is used to allow any encrypted data to persist when updating.\nWould you like to use it? [Y/n]'
  local rs = string.lower(string.sub(read(), 1, 1))
  if rs ~= 'n' then
    print 'Please input your old password.'
    pw = read '.'
    local f = fs.open('/.cco/.authbackup.json', 'r')
    local content = json.parse(f.readAll())
    f.close()
    local oldUniqueKeys = content.encryptionKeyStore
    for k, v in pairs(oldUniqueKeys) do
      oldUniqueKeys[k] = base64.Decode(v)
    end
    local hpw = hash.hmac(hash.sha3_512, oldUniqueKeys.pw, pw)
    local enc = xor(oldUniqueKeys.enc, oldUniqueKeys.Eenc .. hpw)
    pcall(function()
      content.authStoreThing.encryped = base64.Decode(content.authStoreThing.encryped)
    end)
    if xor(content.authStoreThing.encryped, enc) ~= hpw then
      print('Expected:', hpw)
      print('Decrypt Result:', content.authStoreThing.encryped)
      error 'Decryption Failure. Please run the installer again.'
    else
      print 'Decrypt Test Success! Decrypting...'
      overwriteAuthStoreThing = content.authStoreThing.encryped
      for k, v in pairs(oldUniqueKeys) do
        if k ~= 'Eenc' and k ~= 'pw' then
          oldUniqueKeys[k] = xor(v, oldUniqueKeys.Eenc .. pw)
        end
      end
      overwriteUniqueKeys = oldUniqueKeys
    end
  else
    getNewPw()
  end
else
  getNewPw()
end

-- notify user what we're doing
console.clear()
console.centerLog 'Setting up Encryption for you...'

-- unique device keys
local uniqueKeys = require 'uniquekeys'

-- load old keys if any
for k, v in pairs(overwriteUniqueKeys) do
  uniqueKeys[k] = v
end

-- hash password
---@diagnostic disable-next-line: cast-local-type
pw = hash.hmac(hash.sha3_512, uniqueKeys.pw, pw)

-- encrypt keys
local authStoreThing = require 'auth'
if overwriteAuthStoreThing then
  authStoreThing.encryped = base64.Encode(overwriteAuthStoreThing)
else
  authStoreThing.encryped = base64.Encode(xor(pw, uniqueKeys.enc))
end
local script = thisBundle
for k, v in pairs(uniqueKeys) do
  if k ~= 'pw' and k ~= 'Eenc' then
    uniqueKeys[k] = xor(v, uniqueKeys.Eenc .. pw)
  end
end
local newUniqueKeys = {}
for k, v in pairs(uniqueKeys) do
  newUniqueKeys[k] = base64.Encode(v)
  script = string.gsub(script, '!!!' .. k, newUniqueKeys[k])
end
script = string.gsub(script, 'local shouldB64Decode = false', 'local shouldB64Decode = true')

-- print('calc pw', pw)
-- print('encr pw', require('auth').encryped)
sleep(0.5)
console.clear()
console.log 'Do you wish to install this system-wide (y), or as an application (N)? [y/N]'
local systemWide = fs.exists '/.cco/setup-launchonstartup' or string.lower(string.sub(read(), 1, 1)) == 'y'
console.clear()
console.centerLog 'Installing...'
script = string.gsub(script, '_ENCRYPTME', authStoreThing.encryped)
if not fs.isDir '/.cco' then
  fs.makeDir '/.cco'
end

local file = fs.open('/cco.lua', 'w')
file.write(script)
file.close()
if systemWide then
  local file2 = fs.open('/startup.lua', 'w')
  file2.write 'local file = fs.open(\'/cco.lua\',\'r\');\nlocal byte, err = loadstring([[local isStartup = true;local shell = shell or _G.__shell; _G.__shell = nil;]]..file.readAll(), [[/cco.lua]]);\nif type(byte) ~= \'function\' then\n  print(\'Failed to load:\',err);\n  sleep(1);\n  os.shutdown();\nend;\nfile.close();\n_G.__shell = shell;\nreturn byte()'
  file2.close()
  local file3 = fs.open('/.cco/setup-launchonstartup', 'w')
  file3.write 'ok bro'
  file3.close()
end
sleep(0.4)
console.clear()
console.centerLog 'Backing up encryption keys...'
local backupfile = fs.open('/.cco/.authbackup.json', 'w')
backupfile.write(require('json').stringify {
  ['authStoreThing'] = authStoreThing,
  ['encryptionKeyStore'] = newUniqueKeys,
})
backupfile.close()
sleep(0.4)
console.clear()
if systemWide then
  console.centerLog 'Rebooting...'
  sleep(2)
  os.reboot()
else
  console.log 'The OS is available under the command \'cco\'.'
  sleep(0.5)
  -- console.centerLog 'Performing Initial Boot...'
  -- sleep(0.2)
  -- console.clear()
  -- require 'login'
end
