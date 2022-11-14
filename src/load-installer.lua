local console = require 'console'
-- Load Deps
console.clear()
console.log 'Loading Dependencies...'
local hash = require 'hash'
local chime = require 'misc/chime'
local xor = require 'xor'
console.clear()
-- Do some initial work, more or less instant
-- Get Size
local sizeX, sizeY = term.getSize()
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
require('auth').encryped = xor(pw, uniqueKeys.enc)
for k, v in pairs(uniqueKeys) do
  if k ~= 'pw' and k ~= 'Eenc' then
    uniqueKeys[k] = xor(v, uniqueKeys.Eenc .. pw)
  end
end

sleep(0.2)
console.clear()
console.centerLog 'Performing Initial Boot...'
sleep(0.2)
console.clear()
require 'login'
