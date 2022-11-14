-- Built at Mon Nov 14 2022 13:44:05 GMT+0100 (Central European Standard Time) / Development --
return (function(oldRequire,...) -- put everything in a seperate closure
-- Yielding's Bundler Prefix Script
-- Forked & Stripped by Mokiy
-- Copyright (c) 2022 YieldingExploiter.
-- Copyright (c) 2022 MokiyCodes.
-- MIT License

local args = { ... }
local null = nil -- null is better than nil, change my mind
local modules = {} -- we will assign modules to here later
local require = function(...) -- handle loading modules
  local requested, returned = { ... }, {}
  for _, filepath in pairs(requested) do
    if not modules[filepath] then
      table.insert(returned, oldRequire(filepath) or error('[blb] no such module \'' .. filepath .. '\''))
    else
      local module = modules[filepath]
      if module.isCached then
        table.insert(returned, module.cache)
      else
        local moduleValue = module.load()
        module.cache = moduleValue
        module.isCached = true
        table.insert(returned, module.cache)
      end
    end
  end
  return table.unpack(returned)
end


--> BEGIN Initial Module Definitions <--

modules['auth.lua'] = {};
modules['auth.lua'].load = function()
local __just_filename = 'auth.lua';
local __filename = 'auth.lua';
local __dirname = '';
local __hash = '96323b36e72a59f49468259a2f09b374829301bff3962b92cea634898064cedecbd96860feb71ee0ad1b58f0f4a55592d3cf8d0733f48c2f84ea93d1ed14a50f';
local base64 = require 'base64'
local encrypted = '_ENCRYPTME'
if encrypted ~= '_' .. 'ENCRYPTME' then
  encrypted = base64.Decode(encrypted)
end
return { encryped = encrypted }

end;
modules['auth.lua'].cache = null;
modules['auth.lua'].isCached = false;

----

modules['boot.lua'] = {};
modules['boot.lua'].load = function()
local __just_filename = 'boot.lua';
local __filename = 'boot.lua';
local __dirname = '';
local __hash = 'db96a161a4f64aaa203c41d57b2f13d71688d4c030ac5d28fa3a52901935c8ae06d93ff1e93ff1d249d643e6a2c90da566afa89f813b6ca12db918eb6bf2c7fc';
local console = require 'console'
return function()
  console.clear()
  -- display check
  if not term.isColor or not term.isColor() then
    local monitors = { peripheral.find 'monitor' }
    local monitorsByName = {}
    local hasColour = false
    for _, o in pairs(monitors) do
      local x, y = o.getSize()
      if o.isColour() and not (x < 10 or y < 10) then
        monitorsByName[peripheral.getName(o)] = o
        hasColour = true
      end
    end
    if #monitors == 0 or not hasColour then
      print 'Please connect an advanced monitor (2x2 minimum) or run this on an advanced (golden) computer.\nReturning to shell.'
      return
    end
    local response = ''
    while not monitorsByName[response] do
      console.clear()
      print 'Please input a monitor to use.\nAvailable colour monitors:'
      for name in pairs(monitorsByName) do
        print('-', name)
      end
      print '\nNote: You\'ll still need to perform keyboard input on this device.\n\nSelected Montior:'
      response = read()
    end
    console.clear()
    console.centerLog 'Please continue on the monitor.\nInput text here.'
    term.redirect(monitorsByName[response])
  end
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
  console.centerLog 'Rendering...'
  local basalt = require 'basalt'
  basalt.setTheme {
    BasaltBG = colors.black,
    BasaltText = colors.white,
    FrameBG = colors.black,
    FrameText = colors.lightGray,
    ButtonBG = colors.gray,
    ButtonText = colors.white,
    CheckboxBG = colors.gray,
    CheckboxText = colors.white,
    InputBG = colors.gray,
    InputText = colors.white,
    TextfieldBG = colors.gray,
    TextfieldText = colors.white,
    -- ListBG = colors.gray,
    -- ListText = colors.black,
    -- MenubarBG = colors.gray,
    -- MenubarText = colors.black,
    -- DropdownBG = colors.gray,
    -- DropdownText = colors.black,
    -- RadioBG = colors.gray,
    -- RadioText = colors.black,
    -- SelectionBG = colors.black,
    -- SelectionText = colors.lightGray,
    -- GraphicBG = colors.black,
    -- ImageBG = colors.black,
    -- PaneBG = colors.black,
    ProgramBG = colors.gray,
    -- ProgressbarBG = colors.gray,
    -- ProgressbarText = colors.black,
    -- ProgressbarActiveBG = colors.black,
    -- ScrollbarBG = colors.lightGray,
    -- ScrollbarText = colors.gray,
    -- ScrollbarSymbolColor = colors.black,
    -- SliderBG = false,
    -- SliderText = colors.gray,
    -- SliderSymbolColor = colors.black,
    -- SwitchBG = colors.lightGray,
    -- SwitchText = colors.gray,
    -- SwitchBGSymbol = colors.black,
    -- SwitchInactive = colors.red,
    -- SwitchActive = colors.green,
    -- LabelBG = false,
    LabelText = colors.white,
  }

  local main = basalt.createFrame()

  -- https://basalt.madefor.cc/#/objects/Frame?id=movable-frames-with-a-program-object
  local id = 1
  local processes = {}
  local function makeResizeable(frame, minW, minH, maxW, maxH)
    minW = minW or 4
    minH = minH or 4
    maxW = maxW or 99
    maxH = maxH or 99
    frame
      :addButton()
      :setPosition('parent.w', 'parent.h')
      :setSize(1, 1)
      :setText('/')
      :setForeground(colors.blue)
      :setBackground(colors.black)
      :onDrag(function(self, event, btn, xOffset, yOffset)
        local w, h = frame:getSize()
        local wOff, hOff = w, h
        if (w + xOffset - 1 >= minW) and (w + xOffset - 1 <= maxW) then
          wOff = w + xOffset - 1
        end
        if (h + yOffset - 1 >= minH) and (h + yOffset - 1 <= maxH) then
          hOff = h + yOffset - 1
        end
        frame:setSize(wOff, hOff)
      end)
  end
  local function openProgram(path, title, resizable, x, y, w, h)
    local pId = id
    id = id + 1
    local f = main
      :addFrame()
      :setMovable()
      :setSize(math.min((w or 25) + 1, ({ term.getSize() })[1]), (h or 12))
      :setPosition(x or math.random(2, 12), y or math.random(2, 8))
      :setBackground(colors.red)
    if ({ term.getSize() })[1] == 25 then
      f:setPosition(1, y or math.random(2, 8))
    end

    f:addLabel()
      :setSize('parent.w - 1', 1)
      :setBackground(colors.black)
      :setForeground(colors.lightGray)
      :setText(title or 'New Program')

    f:addProgram():setSize('parent.w - 1', 'parent.h - 1'):setPosition(1, 2):execute(path or '/rom/programs/shell.lua', '')

    f:addButton()
      :setSize(1, 1)
      :setText('X')
      :setBackground(colors.black)
      :setForeground(colors.red)
      :setPosition('parent.w', 1)
      :onClick(function()
        f:remove()
        processes[pId] = nil
      end)
    if resizable then
      makeResizeable(f, w, h)
    end
    processes[pId] = f
    return f
  end
  _G._openProgramAsWindow = openProgram
  local appList = main:addFrame():setScrollable():setSize(8, 'parent.h'):setPosition(1, 1)
  local y = -3
  local addAppButton = function()
    y = y + 4
    return appList:addButton():setPosition(1, y):setSize(8, 3)
  end
  addAppButton():setText('Shell'):onClick(function()
    openProgram('/rom/programs/shell.lua', 'Shell', true)
  end)
  addAppButton():setText('Update'):onClick(function()
    openProgram(
      '/rom/programs/http/wget.lua run https://raw.githubusercontent.com/MokiyCodes/cco/main/install.lua',
      'Updater',
      true
    )
  end)
  addAppButton():setText('Chat'):onClick(function()
    openProgram(function()
      console.log 'Hi!\nPlease enter the name of the room you want to join.'
      local room = read()
      console.clear()
      console.log 'Please enter the username you want to join as.'
      local uname = read()
      shell.run(string.format('/rom/programs/rednet/chat.lua join %s %s', room, uname))
    end, 'Chat', true)
  end)
  addAppButton():setText('Shutdown'):onClick(function()
    os.shutdown()
  end)
  addAppButton():setText('Reboot'):onClick(function()
    os.reboot()
  end)

  basalt.autoUpdate()
end

end;
modules['boot.lua'].cache = null;
modules['boot.lua'].isCached = false;

----

modules['index.lua'] = {};
modules['index.lua'].load = function()
local __just_filename = 'index.lua';
local __filename = 'index.lua';
local __dirname = '';
local __hash = 'e972ce6b551218c0f7392987b27bfdc76b9ab5f68ca1a72bc354e21cc1124462a0b3af2ddf8ee758242fce240a15dafb9f1b07dbcd2213cc6f8aa374e515be09';
local console = require 'console'
_G.console = console
if args[#args - 1] == 'loadprogram' then
  return require('programs/' .. args[#args])
end
if isStartup then
  require('termination').setDisabled(true)
end
if installer and (not term.isColor or not term.isColor()) then
  console.clear()
  print 'Warning: On non-colour displays, only login & libs are available.\nContinue? [Y/n]'
  if string.lower(string.sub(read(), 1, 1)) == 'n' then
    print 'Aborted.'
    return
  end
end
-- init script
require 'polyfills/table.create'
console.clear()
print('Host:', _HOST)
print('Is Installer:', (installer and 'true' or 'false'))
return require(installer and 'load-installer' or 'login')

end;
modules['index.lua'].cache = null;
modules['index.lua'].isCached = false;

----

modules['load-installer.lua'] = {};
modules['load-installer.lua'].load = function()
local __just_filename = 'load-installer.lua';
local __filename = 'load-installer.lua';
local __dirname = '';
local __hash = '4784076eb2c2e96c61924c13ea12bacfe44d72837096a326339f4ce092d39d25de8cb5d84d2ee6724fe95cf800db1877fd3c9e4e403ecc7ffc817e09cd9e73d3';
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
    local hpw = hash.hmac(hash.sha3_512, oldUniqueKeys.pw, pw)
    local enc = xor(oldUniqueKeys.enc, oldUniqueKeys.Eenc .. hpw)
    if xor(base64.Decode(content.authStoreThing.encryped), enc) ~= hpw then
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
  authStoreThing.encryped = overwriteAuthStoreThing
else
  authStoreThing.encryped = base64.Encode(xor(pw, uniqueKeys.enc))
end
local script = thisBundle
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
local systemWide = fs.exists '/.cco/setup-launchonstartup' or string.lower(string.sub(read(), 1, 1)) == 'y'
console.clear()
console.centerLog 'Installing...'
script = string.gsub(script, '_ENCRYPTME', authStoreThing.encryped)
local file = fs.open('/cco.lua', 'w')
file.write('local isStartup = false;' .. script)
file.close()
if not fs.isDir '/.cco' then
  fs.makeDir '/.cco'
end
if systemWide then
  local file2 = fs.open('/startup.lua', 'w')
  file2.write('local isStartup = true;' .. script)
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
  ['encryptionKeyStore'] = uniqueKeys,
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

end;
modules['load-installer.lua'].cache = null;
modules['load-installer.lua'].isCached = false;

----

modules['login.lua'] = {};
modules['login.lua'].load = function()
local __just_filename = 'login.lua';
local __filename = 'login.lua';
local __dirname = '';
local __hash = 'b3a28f2df4c2612850fd9c24072b7402a2f2687d8a9395cc5f421ad2c6361fa50f3669de26028801fc271a29c61db6af01ca307fb70c4e50da62d5e2eb8e770e';
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

end;
modules['login.lua'].cache = null;
modules['login.lua'].isCached = false;

----

modules['misc/chime.lua'] = {};
modules['misc/chime.lua'].load = function()
local __just_filename = 'chime.lua';
local __filename = 'misc/chime.lua';
local __dirname = 'misc';
local __hash = '5cccb2e7b818ee81d9c7d596c00ec7871ab43e5bc512541595d4d896f370762e8c72d58946d9e5d8c52126b4ea2e881348397c7557bec7f087caaa5c88cbeec8';
return function(volume)
  volume = volume or 0.5
  local speaker = peripheral.find 'speaker'
  if speaker then
    speaker.playNote('hat', volume, 1)
    sleep(0.1)
    speaker.playNote('hat', volume, 1)
    sleep(0.1)
    speaker.playNote('hat', volume, 13)
    sleep(0.2)
    speaker.playNote('hat', volume, 8)
  end
end

end;
modules['misc/chime.lua'].cache = null;
modules['misc/chime.lua'].isCached = false;

----

modules['packages/basalt.lua'] = {};
modules['packages/basalt.lua'].load = function()
local __just_filename = 'basalt.lua';
local __filename = 'packages/basalt.lua';
local __dirname = 'packages';
local __hash = 'e0bf671b17a66a8f3d641c23c5c0cf03b8785f5e9a1ff2e3402a0fd2eecba02d37f839ecbdc96138e4f31ea5e4ec80551ed6224b94f25ead07a393c08112cadb';
---@diagnostic disable: deprecated
local project = {}
local packaged = true
local baseRequire = require
local require = function(path)
  for _, v in pairs(project) do
    for name, b in pairs(v) do
      if name == path then
        return b()
      end
    end
  end
  return baseRequire(path)
end
local getProject = function(subDir)
  if subDir ~= nil then
    return project[subDir]
  end
  return project
end
project['objects'] = {}
project['libraries'] = {}
project['default'] = {}
project['objects']['Animation'] = function(...)
  local cda = require('utils').getValueFromXML
  local dda = require 'basaltEvent'
  local __b, a_b, b_b, c_b, d_b, _ab = math.floor, math.sin, math.cos, math.pi, math.sqrt, math.pow
  local aab = function(_dc, adc, bdc)
    return _dc + (adc - _dc) * bdc
  end
  local bab = function(_dc)
    return _dc
  end
  local cab = function(_dc)
    return 1 - _dc
  end
  local dab = function(_dc)
    return _dc * _dc * _dc
  end
  local _bb = function(_dc)
    return cab(dab(cab(_dc)))
  end
  local abb = function(_dc)
    return aab(dab(_dc), _bb(_dc), _dc)
  end
  local bbb = function(_dc)
    return a_b((_dc * c_b) / 2)
  end
  local cbb = function(_dc)
    return cab(b_b((_dc * c_b) / 2))
  end
  local dbb = function(_dc)
    return -(b_b(c_b * x) - 1) / 2
  end
  local _cb = function(_dc)
    local adc = 1.70158
    local bdc = adc + 1
    return bdc * _dc ^ 3 - adc * _dc ^ 2
  end
  local acb = function(_dc)
    return _dc ^ 3
  end
  local bcb = function(_dc)
    local adc = (2 * c_b) / 3
    return

_dc == 0 and 0 or (_dc == 1 and 1 or (-2 ^ (10 * _dc - 10) * a_b((_dc * 10 - 10.75) * adc)))
  end
  local function ccb(_dc)
    return _dc == 0 and 0 or 2 ^ (10 * _dc - 10)
  end
  local function dcb(_dc)
    return _dc == 0 and 0 or 2 ^ (10 * _dc - 10)
  end
  local function _db(_dc)
    local adc = 1.70158
    local bdc = adc * 1.525
    return _dc < 0.5 and ((2 * _dc) ^ 2 * ((bdc + 1) * 2 * _dc - bdc)) / 2
      or ((2 * _dc - 2) ^ 2 * ((bdc + 1) * (_dc * 2 - 2) + bdc) + 2) / 2
  end
  local function adb(_dc)
    return _dc < 0.5 and 4 * _dc ^ 3 or 1 - (-2 * _dc + 2) ^ 3 / 2
  end
  local function bdb(_dc)
    local adc = (2 * c_b) / 4.5
    return _dc == 0 and 0
      or (
        _dc == 1 and 1
        or (
          _dc < 0.5 and -(2 ^ (20 * _dc - 10) * a_b((20 * _dc - 11.125) * adc)) / 2
          or (2 ^ (-20 * _dc + 10) * a_b((20 * _dc - 11.125) * adc)) / 2 + 1
        )
      )
  end
  local function cdb(_dc)
    return _dc == 0 and 0 or (_dc == 1 and 1 or (_dc < 0.5 and 2 ^ (20 * _dc - 10) / 2 or (2 - 2 ^ (-20 * _dc + 10)) / 2))
  end
  local function ddb(_dc)
    return _dc < 0.5 and 2 * _dc ^ 2 or 1 - (-2 * _dc + 2) ^ 2 / 2
  end
  local function __c(_dc)
    return _dc < 0.5 and 8 * _dc ^ 4 or 1 - (-2 * _dc + 2) ^ 4 / 2
  end
  local function a_c(_dc)
    return _dc < 0.5 and 16 * _dc ^ 5 or 1 - (-2 * _dc + 2) ^ 5 / 2
  end
  local function b_c(_dc)
    return _dc ^ 2
  end
  local function c_c(_dc)
    return _dc ^ 4
  end
  local function d_c(_dc)
    return _dc ^ 5
  end
  local function _ac(_dc)
    local adc = 1.70158
    local bdc = adc + 1
    return 1 + bdc * (_dc - 1) ^ 3 + adc * (_dc - 1) ^ 2
  end
  local function aac(_dc)
    return 1 - (1 - _dc) ^ 3
  end
  local function bac(_dc)
    local adc = (2 * c_b) / 3
    return

_dc == 0 and 0 or (_dc == 1 and 1 or (2 ^ (-10 * _dc) * a_b((_dc * 10 - 0.75) * adc) + 1))
  end
  local function cac(_dc)
    return _dc == 1 and 1 or 1 - 2 ^ (-10 * _dc)
  end
  local function dac(_dc)
    return 1 - (1 - _dc) * (1 - _dc)
  end
  local function _bc(_dc)
    return 1 - (1 - _dc) ^ 4
  end
  local function abc(_dc)
    return 1 - (1 - _dc) ^ 5
  end
  local function bbc(_dc)
    return 1 - d_b(1 - _ab(_dc, 2))
  end
  local function cbc(_dc)
    return d_b(1 - _ab(_dc - 1, 2))
  end
  local function dbc(_dc)
    return

_dc < 0.5 and (1 - d_b(1 - _ab(2 * _dc, 2))) / 2 or (d_b(1 - _ab(-2 * _dc + 2, 2)) + 1) / 2
  end
  local function _cc(_dc)
    local adc = 7.5625
    local bdc = 2.75
    if _dc < 1 / bdc then
      return adc * _dc * _dc
    elseif _dc < 2 / bdc then
      local cdc = _dc - 1.5 / bdc
      return adc * cdc * cdc + 0.75
    elseif _dc < 2.5 / bdc then
      local cdc = _dc - 2.25 / bdc
      return adc * cdc * cdc + 0.9375
    else
      local cdc = _dc - 2.625 / bdc
      return adc * cdc * cdc + 0.984375
    end
  end
  local function acc(_dc)
    return 1 - _cc(1 - _dc)
  end
  local function bcc(_dc)
    return x < 0.5 and (1 - _cc(1 - 2 * _dc)) / 2 or (1 + _cc(2 * _dc - 1)) / 2
  end
  local ccc = {
    linear = bab,
    lerp = aab,
    flip = cab,
    easeIn = dab,
    easeInSine = cbb,
    easeInBack = _cb,
    easeInCubic = acb,
    easeInElastic = bcb,
    easeInExpo = dcb,
    easeInQuad = b_c,
    easeInQuart = c_c,
    easeInQuint = d_c,
    easeInCirc = bbc,
    easeInBounce = acc,
    easeOut = _bb,
    easeOutSine = bbb,
    easeOutBack = _ac,
    easeOutCubic = aac,
    easeOutElastic = bac,
    easeOutExpo = cac,
    easeOutQuad = dac,
    easeOutQuart = _bc,
    easeOutQuint = abc,
    easeOutCirc = cbc,
    easeOutBounce = _cc,
    easeInOut = abb,
    easeInOutSine = dbb,
    easeInOutBack = _db,
    easeInOutCubic = adb,
    easeInOutElastic = bdb,
    easeInOutExpo = cdb,
    easeInOutQuad = ddb,
    easeInOutQuart = __c,
    easeInOutQuint = a_c,
    easeInOutCirc = dbc,
    easeInOutBounce = bcc,
  }
  local dcc = {}
  return function(_dc)
    local adc = {}
    local bdc = 'Animation'
    local cdc
    local ddc = {}
    local __d = 0
    local a_d = false
    local b_d = 1
    local c_d = false
    local d_d = dda()
    local _ad = 0
    local aad
    local bad = false
    local cad = false
    local dad = 'easeOut'
    local _bd
    local function abd(_cd)
      for acd, bcd in pairs(_cd) do
        bcd(adc, ddc[b_d].t, b_d)
      end
    end
    local function bbd(_cd)
      if b_d == 1 then
        _cd:animationStartHandler()
      end
      if ddc[b_d] ~= nil then
        abd(ddc[b_d].f)
        __d = ddc[b_d].t
      end
      b_d = b_d + 1
      if ddc[b_d] == nil then
        if c_d then
          b_d = 1
          __d = 0
        else
          _cd:animationDoneHandler()
          return
        end
      end
      if ddc[b_d].t > 0 then
        cdc = os.startTimer(ddc[b_d].t - __d)
      else
        bbd(_cd)
      end
    end
    local function cbd(_cd, acd)
      for n = 1, #ddc do
        if ddc[n].t == _cd then
          table.insert(ddc[n].f, acd)
          return
        end
      end
      for n = 1, #ddc do
        if ddc[n].t > _cd then
          if ddc[n - 1] ~= nil then
            if ddc[n - 1].t < _cd then
              table.insert(ddc, n - 1, { t = _cd, f = { acd } })
              return
            end
          else
            table.insert(ddc, n, { t = _cd, f = { acd } })
            return
          end
        end
      end
      if #ddc <= 0 then
        table.insert(ddc, 1, { t = _cd, f = { acd } })
        return
      elseif ddc[#ddc].t < _cd then
        table.insert(ddc, { t = _cd, f = { acd } })
      end
    end
    local function dbd(_cd, acd, bcd, ccd, dcd, _dd, add, bdd)
      local cdd = _bd
      local ddd, ___a
      local a__a = ''
      if cdd.parent ~= nil then
        a__a = cdd.parent:getName()
      end
      a__a = a__a .. cdd:getName()
      cbd(ccd + 0.05, function()
        if add ~= nil then
          if dcc[add] == nil then
            dcc[add] = {}
          end
          if dcc[add][a__a] ~= nil then
            if dcc[add][a__a] ~= bdd then
              dcc[add][a__a]:cancel()
            end
          end
          dcc[add][a__a] = bdd
        end
        ddd, ___a = dcd(cdd)
      end)
      for n = 0.05, bcd + 0.01, 0.05 do
        cbd(ccd + n, function()
          local b__a = math.floor(ccc.lerp(ddd, _cd, ccc[dad](n / bcd)) + 0.5)
          local c__a = math.floor(ccc.lerp(___a, acd, ccc[dad](n / bcd)) + 0.5)
          _dd(cdd, b__a, c__a)
          if add ~= nil then
            if n >= bcd - 0.01 then
              if dcc[add][a__a] == bdd then
                dcc[add][a__a] = nil
              end
            end
          end
        end)
      end
    end
    adc = {
      name = _dc,
      getType = function(_cd)
        return bdc
      end,
      getBaseFrame = function(_cd)
        if _cd.parent ~= nil then
          return _cd.parent:getBaseFrame()
        end
        return _cd
      end,
      setMode = function(_cd, acd)
        dad = acd
        return _cd
      end,
      addMode = function(_cd, acd, bcd)
        ccc[acd] = bcd
        return _cd
      end,
      generateXMLEventFunction = function(_cd, acd, bcd)
        local ccd = function(dcd)
          if dcd:sub(1, 1) == '#' then
            local _dd = _cd:getBaseFrame():getDeepObject(dcd:sub(2, dcd:len()))
            if (_dd ~= nil) and (_dd.internalObjetCall ~= nil) then
              acd(_cd, function()
                _dd:internalObjetCall()
              end)
            end
          else
            acd(_cd, _cd:getBaseFrame():getVariable(dcd))
          end
        end
        if type(bcd) == 'string' then
          ccd(bcd)
        elseif type(bcd) == 'table' then
          for dcd, _dd in pairs(bcd) do
            ccd(_dd)
          end
        end
        return _cd
      end,
      setValuesByXMLData = function(_cd, acd)
        bad = cda('loop', acd) == true and true or false
        if cda('object', acd) ~= nil then
          local bcd = _cd:getBaseFrame():getDeepObject(cda('object', acd))
          if bcd == nil then
            bcd = _cd:getBaseFrame():getVariable(cda('object', acd))
          end
          if bcd ~= nil then
            _cd:setObject(bcd)
          end
        end
        if acd['move'] ~= nil then
          local bcd = cda('x', acd['move'])
          local ccd = cda('y', acd['move'])
          local dcd = cda('duration', acd['move'])
          local _dd = cda('time', acd['move'])
          _cd:move(bcd, ccd, dcd, _dd)
        end
        if acd['size'] ~= nil then
          local bcd = cda('width', acd['size'])
          local ccd = cda('height', acd['size'])
          local dcd = cda('duration', acd['size'])
          local _dd = cda('time', acd['size'])
          _cd:size(bcd, ccd, dcd, _dd)
        end
        if acd['offset'] ~= nil then
          local bcd = cda('x', acd['offset'])
          local ccd = cda('y', acd['offset'])
          local dcd = cda('duration', acd['offset'])
          local _dd = cda('time', acd['offset'])
          _cd:offset(bcd, ccd, dcd, _dd)
        end
        if acd['textColor'] ~= nil then
          local bcd = cda('duration', acd['textColor'])
          local ccd = cda('time', acd['textColor'])
          local dcd = {}
          local _dd = acd['textColor']['color']
          if _dd ~= nil then
            if _dd.properties ~= nil then
              _dd = { _dd }
            end
            for add, bdd in pairs(_dd) do
              table.insert(dcd, colors[bdd:value()])
            end
          end
          if (bcd ~= nil) and (#dcd > 0) then
            _cd:changeTextColor(bcd, ccd or 0, table.unpack(dcd))
          end
        end
        if acd['background'] ~= nil then
          local bcd = cda('duration', acd['background'])
          local ccd = cda('time', acd['background'])
          local dcd = {}
          local _dd = acd['background']['color']
          if _dd ~= nil then
            if _dd.properties ~= nil then
              _dd = { _dd }
            end
            for add, bdd in pairs(_dd) do
              table.insert(dcd, colors[bdd:value()])
            end
          end
          if (bcd ~= nil) and (#dcd > 0) then
            _cd:changeBackground(bcd, ccd or 0, table.unpack(dcd))
          end
        end
        if acd['text'] ~= nil then
          local bcd = cda('duration', acd['text'])
          local ccd = cda('time', acd['text'])
          local dcd = {}
          local _dd = acd['text']['text']
          if _dd ~= nil then
            if _dd.properties ~= nil then
              _dd = { _dd }
            end
            for add, bdd in pairs(_dd) do
              table.insert(dcd, bdd:value())
            end
          end
          if (bcd ~= nil) and (#dcd > 0) then
            _cd:changeText(bcd, ccd or 0, table.unpack(dcd))
          end
        end
        if cda('onDone', acd) ~= nil then
          _cd:generateXMLEventFunction(_cd.onDone, cda('onDone', acd))
        end
        if cda('onStart', acd) ~= nil then
          _cd:generateXMLEventFunction(_cd.onDone, cda('onStart', acd))
        end
        if cda('autoDestroy', acd) ~= nil then
          if cda('autoDestroy', acd) then
            cad = true
          end
        end
        dad = cda('mode', acd) or dad
        if cda('play', acd) ~= nil then
          if cda('play', acd) then
            _cd:play(bad)
          end
        end
        return _cd
      end,
      getZIndex = function(_cd)
        return 1
      end,
      getName = function(_cd)
        return _cd.name
      end,
      setObject = function(_cd, acd)
        _bd = acd
        return _cd
      end,
      move = function(_cd, acd, bcd, ccd, dcd, _dd)
        _bd = _dd or _bd
        dbd(acd, bcd, ccd, dcd or 0, _bd.getPosition, _bd.setPosition, 'position', _cd)
        return _cd
      end,
      offset = function(_cd, acd, bcd, ccd, dcd, _dd)
        _bd = _dd or _bd
        dbd(acd, bcd, ccd, dcd or 0, _bd.getOffset, _bd.setOffset, 'offset', _cd)
        return _cd
      end,
      size = function(_cd, acd, bcd, ccd, dcd, _dd)
        _bd = _dd or _bd
        dbd(acd, bcd, ccd, dcd or 0, _bd.getSize, _bd.setSize, 'size', _cd)
        return _cd
      end,
      changeText = function(_cd, acd, bcd, ...)
        local ccd = { ... }
        bcd = bcd or 0
        _bd = obj or _bd
        for n = 1, #ccd do
          cbd(bcd + n * (acd / #ccd), function()
            _bd.setText(_bd, ccd[n])
          end)
        end
        return _cd
      end,
      changeBackground = function(_cd, acd, bcd, ...)
        local ccd = { ... }
        bcd = bcd or 0
        _bd = obj or _bd
        for n = 1, #ccd do
          cbd(bcd + n * (acd / #ccd), function()
            _bd.setBackground(_bd, ccd[n])
          end)
        end
        return _cd
      end,
      changeTextColor = function(_cd, acd, bcd, ...)
        local ccd = { ... }
        bcd = bcd or 0
        _bd = obj or _bd
        for n = 1, #ccd do
          cbd(bcd + n * (acd / #ccd), function()
            _bd.setForeground(_bd, ccd[n])
          end)
        end
        return _cd
      end,
      add = function(_cd, acd, bcd)
        aad = acd
        cbd((bcd or _ad) + (ddc[#ddc] ~= nil and ddc[#ddc].t or 0), acd)
        return _cd
      end,
      wait = function(_cd, acd)
        _ad = acd
        return _cd
      end,
      rep = function(_cd, acd)
        if aad ~= nil then
          for n = 1, acd or 1 do
            cbd((wait or _ad) + (ddc[#ddc] ~= nil and ddc[#ddc].t or 0), aad)
          end
        end
        return _cd
      end,
      onDone = function(_cd, acd)
        d_d:registerEvent('animation_done', acd)
        return _cd
      end,
      onStart = function(_cd, acd)
        d_d:registerEvent('animation_start', acd)
        return _cd
      end,
      setAutoDestroy = function(_cd, acd)
        cad = acd ~= nil and acd or true
        return _cd
      end,
      animationDoneHandler = function(_cd)
        d_d:sendEvent('animation_done', _cd)
        _cd.parent:removeEvent('other_event', _cd)
        if cad then
          _cd.parent:removeObject(_cd)
          _cd = nil
        end
      end,
      animationStartHandler = function(_cd)
        d_d:sendEvent('animation_start', _cd)
      end,
      clear = function(_cd)
        ddc = {}
        aad = nil
        _ad = 0
        b_d = 1
        __d = 0
        c_d = false
        return _cd
      end,
      play = function(_cd, acd)
        _cd:cancel()
        a_d = true
        c_d = acd and true or false
        b_d = 1
        __d = 0
        if ddc[b_d] ~= nil then
          if ddc[b_d].t > 0 then
            cdc = os.startTimer(ddc[b_d].t)
          else
            bbd(_cd)
          end
        else
          _cd:animationDoneHandler()
        end
        _cd.parent:addEvent('other_event', _cd)
        return _cd
      end,
      cancel = function(_cd)
        if cdc ~= nil then
          os.cancelTimer(cdc)
          c_d = false
        end
        a_d = false
        _cd.parent:removeEvent('other_event', _cd)
        return _cd
      end,
      internalObjetCall = function(_cd)
        _cd:play(bad)
      end,
      eventHandler = function(_cd, acd, bcd)
        if a_d then
          if (acd == 'timer') and (bcd == cdc) then
            if ddc[b_d] ~= nil then
              bbd(_cd)
            else
              _cd:animationDoneHandler()
            end
          end
        end
      end,
    }
    adc.__index = adc
    return adc
  end
end
project['objects']['Button'] = function(...)
  local _a = require 'Object'
  local aa = require 'utils'
  local ba = aa.getValueFromXML
  local ca = require 'tHex'
  return function(da)
    local _b = _a(da)
    local ab = 'Button'
    local bb = 'center'
    local cb = 'center'
    _b:setZIndex(5)
    _b:setValue 'Button'
    _b.width = 12
    _b.height = 3
    local db = {
      init = function(_c)
        if _b.init(_c) then
          _c.bgColor = _c.parent:getTheme 'ButtonBG'
          _c.fgColor = _c.parent:getTheme 'ButtonText'
        end
      end,
      getType = function(_c)
        return ab
      end,
      setHorizontalAlign = function(_c, ac)
        bb = ac
        _c:updateDraw()
        return _c
      end,
      setVerticalAlign = function(_c, ac)
        cb = ac
        _c:updateDraw()
        return _c
      end,
      setText = function(_c, ac)
        _b:setValue(ac)
        _c:updateDraw()
        return _c
      end,
      setValuesByXMLData = function(_c, ac)
        _b.setValuesByXMLData(_c, ac)
        if ba('text', ac) ~= nil then
          _c:setText(ba('text', ac))
        end
        if ba('horizontalAlign', ac) ~= nil then
          bb = ba('horizontalAlign', ac)
        end
        if ba('verticalAlign', ac) ~= nil then
          cb = ba('verticalAlign', ac)
        end
        return _c
      end,
      draw = function(_c)
        if _b.draw(_c) then
          if _c.parent ~= nil then
            local ac, bc = _c:getAnchorPosition()
            local cc, dc = _c:getSize()
            local _d = aa.getTextVerticalAlign(dc, cb)
            for n = 1, dc do
              if n == _d then
                _c.parent:setText(ac, bc + (n - 1), aa.getTextHorizontalAlign(_c:getValue(), cc, bb))
                _c.parent:setFG(ac, bc + (n - 1), aa.getTextHorizontalAlign(ca[_c.fgColor]:rep(_c:getValue():len()), cc, bb))
              end
            end
          end
        end
      end,
    }
    return setmetatable(db, _b)
  end
end
project['objects']['Checkbox'] = function(...)
  local d = require 'Object'
  local _a = require 'utils'
  local aa = _a.getValueFromXML
  return function(ba)
    local ca = d(ba)
    local da = 'Checkbox'
    ca:setZIndex(5)
    ca:setValue(false)
    ca.width = 1
    ca.height = 1
    local _b = '\42'
    local ab = {
      getType = function(bb)
        return da
      end,
      setSymbol = function(bb, cb)
        _b = cb
        bb:updateDraw()
        return bb
      end,
      mouseHandler = function(bb, cb, db, _c)
        if ca.mouseHandler(bb, cb, db, _c) then
          if cb == 1 then
            if (bb:getValue() ~= true) and (bb:getValue() ~= false) then
              bb:setValue(false)
            else
              bb:setValue(not bb:getValue())
            end
            bb:updateDraw()
            return true
          end
        end
        return false
      end,
      touchHandler = function(bb, cb, db)
        return bb:mouseHandler(1, cb, db)
      end,
      setValuesByXMLData = function(bb, cb)
        ca.setValuesByXMLData(bb, cb)
        if aa('checked', cb) ~= nil then
          if aa('checked', cb) then
            bb:setValue(true)
          else
            bb:setValue(false)
          end
        end
        return bb
      end,
      draw = function(bb)
        if ca.draw(bb) then
          if bb.parent ~= nil then
            local cb, db = bb:getAnchorPosition()
            local _c, ac = bb:getSize()
            local bc = _a.getTextVerticalAlign(ac, 'center')
            if bb.bgColor ~= false then
              bb.parent:drawBackgroundBox(cb, db, _c, ac, bb.bgColor)
            end
            for n = 1, ac do
              if n == bc then
                if bb:getValue() == true then
                  bb.parent:writeText(cb, db + (n - 1), _a.getTextHorizontalAlign(_b, _c, 'center'), bb.bgColor, bb.fgColor)
                else
                  bb.parent:writeText(cb, db + (n - 1), _a.getTextHorizontalAlign(' ', _c, 'center'), bb.bgColor, bb.fgColor)
                end
              end
            end
          end
        end
      end,
      init = function(bb)
        bb.parent:addEvent('mouse_click', bb)
        bb.parent:addEvent('mouse_up', bb)
        if ca.init(bb) then
          bb.bgColor = bb.parent:getTheme 'CheckboxBG'
          bb.fgColor = bb.parent:getTheme 'CheckboxText'
        end
      end,
    }
    return setmetatable(ab, ca)
  end
end
project['objects']['Dropdown'] = function(...)
  local d = require 'Object'
  local _a = require 'utils'
  local aa = require('utils').getValueFromXML
  return function(ba)
    local ca = d(ba)
    local da = 'Dropdown'
    ca.width = 12
    ca.height = 1
    ca:setZIndex(6)
    local _b = {}
    local ab
    local bb
    local cb = true
    local db = 'left'
    local _c = 0
    local ac = 16
    local bc = 6
    local cc = '\16'
    local dc = '\31'
    local _d = false
    local ad = {
      getType = function(bd)
        return da
      end,
      setValuesByXMLData = function(bd, cd)
        ca.setValuesByXMLData(bd, cd)
        if aa('selectionBG', cd) ~= nil then
          ab = colors[aa('selectionBG', cd)]
        end
        if aa('selectionFG', cd) ~= nil then
          bb = colors[aa('selectionFG', cd)]
        end
        if aa('dropdownWidth', cd) ~= nil then
          ac = aa('dropdownWidth', cd)
        end
        if aa('dropdownHeight', cd) ~= nil then
          bc = aa('dropdownHeight', cd)
        end
        if aa('offset', cd) ~= nil then
          _c = aa('offset', cd)
        end
        if cd['item'] ~= nil then
          local dd = cd['item']
          if dd.properties ~= nil then
            dd = { dd }
          end
          for __a, a_a in pairs(dd) do
            bd:addItem(aa('text', a_a), colors[aa('bg', a_a)], colors[aa('fg', a_a)])
          end
        end
      end,
      setOffset = function(bd, cd)
        _c = cd
        bd:updateDraw()
        return bd
      end,
      getOffset = function(bd)
        return _c
      end,
      addItem = function(bd, cd, dd, __a, ...)
        table.insert(_b, { text = cd, bgCol = dd or bd.bgColor, fgCol = __a or bd.fgColor, args = { ... } })
        bd:updateDraw()
        return bd
      end,
      getAll = function(bd)
        return _b
      end,
      removeItem = function(bd, cd)
        table.remove(_b, cd)
        bd:updateDraw()
        return bd
      end,
      getItem = function(bd, cd)
        return _b[cd]
      end,
      getItemIndex = function(bd)
        local cd = bd:getValue()
        for dd, __a in pairs(_b) do
          if __a == cd then
            return dd
          end
        end
      end,
      clear = function(bd)
        _b = {}
        bd:setValue {}
        bd:updateDraw()
        return bd
      end,
      getItemCount = function(bd)
        return #_b
      end,
      editItem = function(bd, cd, dd, __a, a_a, ...)
        table.remove(_b, cd)
        table.insert(_b, cd, { text = dd, bgCol = __a or bd.bgColor, fgCol = a_a or bd.fgColor, args = { ... } })
        bd:updateDraw()
        return bd
      end,
      selectItem = function(bd, cd)
        bd:setValue(_b[cd] or {})
        bd:updateDraw()
        return bd
      end,
      setSelectedItem = function(bd, cd, dd, __a)
        ab = cd or bd.bgColor
        bb = dd or bd.fgColor
        cb = __a
        bd:updateDraw()
        return bd
      end,
      setDropdownSize = function(bd, cd, dd)
        ac, bc = cd, dd
        bd:updateDraw()
        return bd
      end,
      mouseHandler = function(bd, cd, dd, __a)
        if _d then
          local a_a, b_a = bd:getAbsolutePosition(bd:getAnchorPosition())
          if cd == 1 then
            if #_b > 0 then
              for n = 1, bc do
                if _b[n + _c] ~= nil then
                  if (a_a <= dd) and (a_a + ac > dd) and (b_a + n == __a) then
                    bd:setValue(_b[n + _c])
                    bd:updateDraw()
                    local c_a = bd:getEventSystem():sendEvent('mouse_click', bd, 'mouse_click', dir, dd, __a)
                    if c_a == false then
                      return c_a
                    end
                    return true
                  end
                end
              end
            end
          end
        end
        if ca.mouseHandler(bd, cd, dd, __a) then
          _d = not _d
          bd:updateDraw()
          return true
        else
          if _d then
            bd:updateDraw()
            _d = false
          end
          return false
        end
      end,
      mouseUpHandler = function(bd, cd, dd, __a)
        if _d then
          local a_a, b_a = bd:getAbsolutePosition(bd:getAnchorPosition())
          if cd == 1 then
            if #_b > 0 then
              for n = 1, bc do
                if _b[n + _c] ~= nil then
                  if (a_a <= dd) and (a_a + ac > dd) and (b_a + n == __a) then
                    _d = false
                    bd:updateDraw()
                    local c_a = bd:getEventSystem():sendEvent('mouse_up', bd, 'mouse_up', dir, dd, __a)
                    if c_a == false then
                      return c_a
                    end
                    return true
                  end
                end
              end
            end
          end
        end
      end,
      scrollHandler = function(bd, cd, dd, __a)
        if _d and (bd:isFocused()) then
          _c = _c + cd
          if _c < 0 then
            _c = 0
          end
          if cd == 1 then
            if #_b > bc then
              if _c > #_b - bc then
                _c = #_b - bc
              end
            else
              _c = math.min(#_b - 1, 0)
            end
          end
          local a_a = bd:getEventSystem():sendEvent('mouse_scroll', bd, 'mouse_scroll', cd, dd, __a)
          if a_a == false then
            return a_a
          end
          bd:updateDraw()
          return true
        end
      end,
      draw = function(bd)
        if ca.draw(bd) then
          local cd, dd = bd:getAnchorPosition()
          local __a, a_a = bd:getSize()
          if bd.parent ~= nil then
            if bd.bgColor ~= false then
              bd.parent:drawBackgroundBox(cd, dd, __a, a_a, bd.bgColor)
            end
            local b_a = bd:getValue()
            local c_a = _a.getTextHorizontalAlign((b_a ~= nil and b_a.text or ''), __a, db):sub(1, __a - 1)
              .. (_d and dc or cc)
            bd.parent:writeText(cd, dd, c_a, bd.bgColor, bd.fgColor)
            if _d then
              for n = 1, bc do
                if _b[n + _c] ~= nil then
                  if _b[n + _c] == b_a then
                    if cb then
                      bd.parent:writeText(cd, dd + n, _a.getTextHorizontalAlign(_b[n + _c].text, ac, db), ab, bb)
                    else
                      bd.parent:writeText(
                        cd,
                        dd + n,
                        _a.getTextHorizontalAlign(_b[n + _c].text, ac, db),
                        _b[n + _c].bgCol,
                        _b[n + _c].fgCol
                      )
                    end
                  else
                    bd.parent:writeText(
                      cd,
                      dd + n,
                      _a.getTextHorizontalAlign(_b[n + _c].text, ac, db),
                      _b[n + _c].bgCol,
                      _b[n + _c].fgCol
                    )
                  end
                end
              end
            end
          end
        end
      end,
      init = function(bd)
        bd.parent:addEvent('mouse_click', bd)
        bd.parent:addEvent('mouse_up', bd)
        bd.parent:addEvent('mouse_scroll', bd)
        if ca.init(bd) then
          bd.bgColor = bd.parent:getTheme 'DropdownBG'
          bd.fgColor = bd.parent:getTheme 'DropdownText'
          ab = bd.parent:getTheme 'SelectionBG'
          bb = bd.parent:getTheme 'SelectionText'
        end
      end,
    }
    return setmetatable(ad, ca)
  end
end
project['objects']['Image'] = function(...)
  local c = require 'Object'
  local d = require('utils').getValueFromXML
  return function(_a)
    local aa = c(_a)
    local ba = 'Image'
    aa:setZIndex(2)
    local ca
    local da
    local _b = false
    local function ab()
      local cb = {
        [0] = { 8, 4, 3, 6, 5 },
        { 4, 14, 8, 7 },
        { 6, 10, 8, 7 },
        { 9, 11, 8, 0 },
        { 1, 14, 8, 0 },
        { 13, 12, 8, 0 },
        { 2, 10, 8, 0 },
        { 15, 8, 10, 11, 12, 14 },
        { 0, 7, 1, 9, 2, 13 },
        { 3, 11, 8, 7 },
        { 2, 6, 7, 15 },
        { 9, 3, 7, 15 },
        { 13, 5, 7, 15 },
        { 5, 12, 8, 7 },
        { 1, 4, 7, 15 },
        { 7, 10, 11, 12, 14 },
      }
      local db, _c, ac = {}, {}, {}
      for i = 0, 15 do
        _c[2 ^ i] = i
      end
      do
        local cd = '0123456789abcdef'
        for i = 1, 16 do
          db[cd:sub(i, i)] = i - 1
          db[i - 1] = cd:sub(i, i)
          ac[cd:sub(i, i)] = 2 ^ (i - 1)
          ac[2 ^ (i - 1)] = cd:sub(i, i)
          local dd = cb[i - 1]
          for i = 1, #dd do
            dd[i] = 2 ^ dd[i]
          end
        end
      end
      local function bc(cd)
        local dd = cb[_c[cd[#cd][1]]]
        for j = 1, #dd do
          local __a = dd[j]
          for i = 1, #cd - 1 do
            if cd[i][1] == __a then
              return i
            end
          end
        end
        return 1
      end
      local function cc(cd, dd)
        if not dd then
          local a_a = {}
          dd = {}
          for i = 1, 6 do
            local b_a = cd[i]
            local c_a = dd[b_a]
            dd[b_a], a_a[i] = c_a and (c_a + 1) or 1, b_a
          end
          cd = a_a
        end
        local __a = {}
        for a_a, b_a in pairs(dd) do
          __a[#__a + 1] = { a_a, b_a }
        end
        if #__a > 1 then
          while #__a > 2 do
            table.sort(__a, function(aaa, baa)
              return aaa[2] > baa[2]
            end)
            local b_a, c_a = bc(__a), #__a
            local d_a, _aa = __a[c_a][1], __a[b_a][1]
            for i = 1, 6 do
              if cd[i] == d_a then
                cd[i] = _aa
                __a[b_a][2] = __a[b_a][2] + 1
              end
            end
            __a[c_a] = nil
          end
          local a_a = 128
          for i = 1, #cd - 1 do
            if cd[i] ~= cd[6] then
              a_a = a_a + 2 ^ (i - 1)
            end
          end
          return string.char(a_a), ac[__a[1][1] == cd[6] and __a[2][1] or __a[1][1]], ac[cd[6]]
        else
          return '\128', ac[cd[1]], ac[cd[1]]
        end
      end
      local dc, _d, ad, bd = { {}, {}, {} }, 0, #ca + #ca % 3, aa.bgColor or colors.black
      for i = 1, #ca do
        if #ca[i] > _d then
          _d = #ca[i]
        end
      end
      for y = 0, ad - 1, 3 do
        local cd, dd, __a, a_a = {}, {}, {}, 1
        for x = 0, _d - 1, 2 do
          local b_a, c_a = {}, {}
          for yy = 1, 3 do
            for xx = 1, 2 do
              b_a[#b_a + 1] = (ca[y + yy] and ca[y + yy][x + xx]) and (ca[y + yy][x + xx] == 0 and bd or ca[y + yy][x + xx])
                or bd
              c_a[b_a[#b_a]] = c_a[b_a[#b_a]] and (c_a[b_a[#b_a]] + 1) or 1
            end
          end
          cd[a_a], dd[a_a], __a[a_a] = cc(b_a, c_a)
          a_a = a_a + 1
        end
        dc[1][#dc[1] + 1], dc[2][#dc[2] + 1], dc[3][#dc[3] + 1] = table.concat(cd), table.concat(dd), table.concat(__a)
      end
      dc.width, dc.height = #dc[1][1], #dc[1]
      da = dc
    end
    local bb = {
      init = function(cb)
        cb.bgColor = cb.parent:getTheme 'ImageBG'
      end,
      getType = function(cb)
        return ba
      end,
      loadImage = function(cb, db)
        ca = paintutils.loadImage(db)
        _b = false
        cb:updateDraw()
        return cb
      end,
      shrink = function(cb)
        ab()
        _b = true
        cb:updateDraw()
        return cb
      end,
      setValuesByXMLData = function(cb, db)
        aa.setValuesByXMLData(cb, db)
        if d('shrink', db) ~= nil then
          if d('shrink', db) then
            cb:shrink()
          end
        end
        if d('path', db) ~= nil then
          cb:loadImage(d('path', db))
        end
        return cb
      end,
      draw = function(cb)
        if aa.draw(cb) then
          if cb.parent ~= nil then
            if ca ~= nil then
              local db, _c = cb:getAnchorPosition()
              local ac, bc = cb:getSize()
              if _b then
                local cc, dc, _d = da[1], da[2], da[3]
                for i = 1, da.height do
                  local ad = cc[i]
                  if type(ad) == 'string' then
                    cb.parent:setText(db, _c + i - 1, ad)
                    cb.parent:setFG(db, _c + i - 1, dc[i])
                    cb.parent:setBG(db, _c + i - 1, _d[i])
                  elseif type(ad) == 'table' then
                    cb.parent:setText(db, _c + i - 1, ad[2])
                    cb.parent:setFG(db, _c + i - 1, dc[i])
                    cb.parent:setBG(db, _c + i - 1, _d[i])
                  end
                end
              else
                for yPos = 1, math.min(#ca, bc) do
                  local cc = ca[yPos]
                  for xPos = 1, math.min(#cc, ac) do
                    if cc[xPos] > 0 then
                      cb.parent:drawBackgroundBox(db + xPos - 1, _c + yPos - 1, 1, 1, cc[xPos])
                    end
                  end
                end
              end
            end
          end
        end
      end,
    }
    return setmetatable(bb, aa)
  end
end
project['objects']['Input'] = function(...)
  local _a = require 'Object'
  local aa = require 'utils'
  local ba = require 'basaltLogs'
  local ca = aa.getValueFromXML
  return function(da)
    local _b = _a(da)
    local ab = 'Input'
    local bb = 'text'
    local cb = 0
    _b:setZIndex(5)
    _b:setValue ''
    _b.width = 10
    _b.height = 1
    local db = 1
    local _c = 1
    local ac = ''
    local bc
    local cc
    local dc = ac
    local _d = false
    local ad = {
      getType = function(bd)
        return ab
      end,
      setInputType = function(bd, cd)
        if (cd == 'password') or (cd == 'number') or (cd == 'text') then
          bb = cd
        end
        bd:updateDraw()
        return bd
      end,
      setDefaultText = function(bd, cd, dd, __a)
        ac = cd
        bc = __a or bc
        cc = dd or cc
        if bd:isFocused() then
          dc = ''
        else
          dc = ac
        end
        bd:updateDraw()
        return bd
      end,
      getInputType = function(bd)
        return bb
      end,
      setValue = function(bd, cd)
        _b.setValue(bd, tostring(cd))
        if not _d then
          if bd:isFocused() then
            db = tostring(cd):len() + 1
            _c = math.max(1, db - bd:getWidth() + 1)
            local dd, __a = bd:getAnchorPosition()
            bd.parent:setCursor(true, dd + db - _c, __a + math.floor(bd:getHeight() / 2), bd.fgColor)
          end
        end
        bd:updateDraw()
        return bd
      end,
      getValue = function(bd)
        local cd = _b.getValue(bd)
        return bb == 'number' and tonumber(cd) or cd
      end,
      setInputLimit = function(bd, cd)
        cb = tonumber(cd) or cb
        bd:updateDraw()
        return bd
      end,
      getInputLimit = function(bd)
        return cb
      end,
      setValuesByXMLData = function(bd, cd)
        _b.setValuesByXMLData(bd, cd)
        local dd, __a
        if ca('defaultBG', cd) ~= nil then
          dd = ca('defaultBG', cd)
        end
        if ca('defaultFG', cd) ~= nil then
          __a = ca('defaultFG', cd)
        end
        if ca('default', cd) ~= nil then
          bd:setDefaultText(ca('default', cd), __a ~= nil and colors[__a], dd ~= nil and colors[dd])
        end
        if ca('limit', cd) ~= nil then
          bd:setInputLimit(ca('limit', cd))
        end
        if ca('type', cd) ~= nil then
          bd:setInputType(ca('type', cd))
        end
        return bd
      end,
      getFocusHandler = function(bd)
        _b.getFocusHandler(bd)
        if bd.parent ~= nil then
          local cd, dd = bd:getAnchorPosition()
          dc = ''
          if ac ~= '' then
            bd:updateDraw()
          end
          bd.parent:setCursor(true, cd + db - _c, dd + math.max(math.ceil(bd:getHeight() / 2 - 1, 1)), bd.fgColor)
        end
      end,
      loseFocusHandler = function(bd)
        _b.loseFocusHandler(bd)
        if bd.parent ~= nil then
          dc = ac
          if ac ~= '' then
            bd:updateDraw()
          end
          bd.parent:setCursor(false)
        end
      end,
      keyHandler = function(bd, cd)
        if _b.keyHandler(bd, cd) then
          local dd, __a = bd:getSize()
          _d = true
          if cd == keys.backspace then
            local aaa = tostring(_b.getValue())
            if db > 1 then
              bd:setValue(aaa:sub(1, db - 2) .. aaa:sub(db, aaa:len()))
              if db > 1 then
                db = db - 1
              end
              if _c > 1 then
                if db < _c then
                  _c = _c - 1
                end
              end
            end
          end
          if cd == keys.enter then
            if bd.parent ~= nil then
            end
          end
          if cd == keys.right then
            local aaa = tostring(_b.getValue()):len()
            db = db + 1
            if db > aaa then
              db = aaa + 1
            end
            if db < 1 then
              db = 1
            end
            if (db < _c) or (db >= dd + _c) then
              _c = db - dd + 1
            end
            if _c < 1 then
              _c = 1
            end
          end
          if cd == keys.left then
            db = db - 1
            if db >= 1 then
              if (db < _c) or (db >= dd + _c) then
                _c = db
              end
            end
            if db < 1 then
              db = 1
            end
            if _c < 1 then
              _c = 1
            end
          end
          local a_a, b_a = bd:getAnchorPosition()
          local c_a = tostring(_b.getValue())
          local d_a = (db <= c_a:len() and db - 1 or c_a:len()) - (_c - 1)
          local _aa = bd:getX()
          if d_a > _aa + dd - 1 then
            d_a = _aa + dd - 1
          end
          if bd.parent ~= nil then
            bd.parent:setCursor(true, a_a + d_a, b_a + math.max(math.ceil(__a / 2 - 1, 1)), bd.fgColor)
          end
          bd:updateDraw()
          _d = false
          return true
        end
        return false
      end,
      charHandler = function(bd, cd)
        if _b.charHandler(bd, cd) then
          _d = true
          local dd, __a = bd:getSize()
          local a_a = _b.getValue()
          if a_a:len() < cb or cb <= 0 then
            if bb == 'number' then
              local baa = a_a
              if (#a_a == 0 and cd == '-') or (cd == '.') or (tonumber(cd) ~= nil) then
                bd:setValue(a_a:sub(1, db - 1) .. cd .. a_a:sub(db, a_a:len()))
                db = db + 1
              end
              if tonumber(_b.getValue()) == nil then
              end
            else
              bd:setValue(a_a:sub(1, db - 1) .. cd .. a_a:sub(db, a_a:len()))
              db = db + 1
            end
            if db >= dd + _c then
              _c = _c + 1
            end
          end
          local b_a, c_a = bd:getAnchorPosition()
          local d_a = tostring(_b.getValue())
          local _aa = (db <= d_a:len() and db - 1 or d_a:len()) - (_c - 1)
          local aaa = bd:getX()
          if _aa > aaa + dd - 1 then
            _aa = aaa + dd - 1
          end
          if bd.parent ~= nil then
            bd.parent:setCursor(true, b_a + _aa, c_a + math.max(math.ceil(__a / 2 - 1, 1)), bd.fgColor)
          end
          _d = false
          bd:updateDraw()
          return true
        end
        return false
      end,
      mouseHandler = function(bd, cd, dd, __a)
        if _b.mouseHandler(bd, cd, dd, __a) then
          local a_a, b_a = bd:getAnchorPosition()
          local c_a, d_a = bd:getAbsolutePosition(a_a, b_a)
          local _aa, aaa = bd:getSize()
          db = dd - c_a + _c
          local baa = _b.getValue()
          if db > baa:len() then
            db = baa:len() + 1
          end
          if db < _c then
            _c = db - 1
            if _c < 1 then
              _c = 1
            end
          end
          bd.parent:setCursor(true, a_a + db - _c, b_a + math.max(math.ceil(aaa / 2 - 1, 1)), bd.fgColor)
          return true
        end
      end,
      dragHandler = function(bd, cd, dd, __a, a_a, b_a)
        if bd:isFocused() then
          if bd:isCoordsInObject(dd, __a) then
            if _b.dragHandler(bd, cd, dd, __a, a_a, b_a) then
              return true
            end
          end
          bd.parent:removeFocusedObject()
        end
      end,
      eventHandler = function(bd, cd, dd, __a, a_a, b_a)
        if _b.eventHandler(bd, cd, dd, __a, a_a, b_a) then
          if cd == 'paste' then
            if bd:isFocused() then
              local c_a = _b.getValue()
              local d_a, _aa = bd:getSize()
              _d = true
              if bb == 'number' then
                local aba = c_a
                if (dd == '.') or (tonumber(dd) ~= nil) then
                  bd:setValue(c_a:sub(1, db - 1) .. dd .. c_a:sub(db, c_a:len()))
                  db = db + dd:len()
                end
                if tonumber(_b.getValue()) == nil then
                  bd:setValue(aba)
                end
              else
                bd:setValue(c_a:sub(1, db - 1) .. dd .. c_a:sub(db, c_a:len()))
                db = db + dd:len()
              end
              if db >= d_a + _c then
                _c = (db + 1) - d_a
              end
              local aaa, baa = bd:getAnchorPosition()
              local caa = tostring(_b.getValue())
              local daa = (db <= caa:len() and db - 1 or caa:len()) - (_c - 1)
              local _ba = bd:getX()
              if daa > _ba + d_a - 1 then
                daa = _ba + d_a - 1
              end
              if bd.parent ~= nil then
                bd.parent:setCursor(true, aaa + daa, baa + math.max(math.ceil(_aa / 2 - 1, 1)), bd.fgColor)
              end
              bd:updateDraw()
              _d = false
            end
          end
        end
      end,
      draw = function(bd)
        if _b.draw(bd) then
          if bd.parent ~= nil then
            local cd, dd = bd:getAnchorPosition()
            local __a, a_a = bd:getSize()
            local b_a = aa.getTextVerticalAlign(a_a, 'center')
            if bd.bgColor ~= false then
              bd.parent:drawBackgroundBox(cd, dd, __a, a_a, bd.bgColor)
            end
            for n = 1, a_a do
              if n == b_a then
                local c_a = tostring(_b.getValue())
                local d_a = bd.bgColor
                local _aa = bd.fgColor
                local aaa
                if c_a:len() <= 0 then
                  aaa = dc
                  d_a = bc or d_a
                  _aa = cc or _aa
                end
                aaa = dc
                if c_a ~= '' then
                  aaa = c_a
                end
                aaa = aaa:sub(_c, __a + _c - 1)
                local baa = __a - aaa:len()
                if baa < 0 then
                  baa = 0
                end
                if (bb == 'password') and (c_a ~= '') then
                  aaa = string.rep('*', aaa:len())
                end
                aaa = aaa .. string.rep(bd.bgSymbol, baa)
                bd.parent:writeText(cd, dd + (n - 1), aaa, d_a, _aa)
              end
            end
            if bd:isFocused() then
              bd.parent:setCursor(true, cd + db - _c, dd + math.floor(bd:getHeight() / 2), bd.fgColor)
            end
          end
        end
      end,
      init = function(bd)
        if bd.parent ~= nil then
          bd.parent:addEvent('mouse_click', bd)
          bd.parent:addEvent('key', bd)
          bd.parent:addEvent('char', bd)
          bd.parent:addEvent('other_event', bd)
          bd.parent:addEvent('mouse_drag', bd)
        end
        if _b.init(bd) then
          bd.bgColor = bd.parent:getTheme 'InputBG'
          bd.fgColor = bd.parent:getTheme 'InputText'
        end
      end,
    }
    return setmetatable(ad, _b)
  end
end
project['objects']['Label'] = function(...)
  local ba = require 'Object'
  local ca = require 'utils'
  local da = ca.getValueFromXML
  local _b = ca.createText
  local ab = require 'tHex'
  local bb = require 'bigfont'
  return function(cb)
    local db = ba(cb)
    local _c = 'Label'
    db:setZIndex(3)
    local ac = true
    db:setValue 'Label'
    db.width = 5
    local bc = 'left'
    local cc = 'top'
    local dc = 0
    local _d, ad = false, false
    local bd = {
      getType = function(cd)
        return _c
      end,
      setText = function(cd, dd)
        dd = tostring(dd)
        db:setValue(dd)
        if ac then
          if dd:len() + cd:getX() > cd.parent:getWidth() then
            local __a = cd.parent:getWidth() - cd:getX()
            db.setSize(cd, __a, #_b(dd, __a))
          else
            db.setSize(cd, dd:len(), 1)
          end
        end
        cd:updateDraw()
        return cd
      end,
      setBackground = function(cd, dd)
        db.setBackground(cd, dd)
        ad = true
        cd:updateDraw()
        return cd
      end,
      setForeground = function(cd, dd)
        db.setForeground(cd, dd)
        _d = true
        cd:updateDraw()
        return cd
      end,
      setTextAlign = function(cd, dd, __a)
        bc = dd or bc
        cc = __a or cc
        cd:updateDraw()
        return cd
      end,
      setFontSize = function(cd, dd)
        if (dd > 0) and (dd <= 4) then
          dc = dd - 1 or 0
        end
        cd:updateDraw()
        return cd
      end,
      getFontSize = function(cd)
        return dc + 1
      end,
      setValuesByXMLData = function(cd, dd)
        db.setValuesByXMLData(cd, dd)
        if da('text', dd) ~= nil then
          cd:setText(da('text', dd))
        end
        if da('verticalAlign', dd) ~= nil then
          cc = da('verticalAlign', dd)
        end
        if da('horizontalAlign', dd) ~= nil then
          bc = da('horizontalAlign', dd)
        end
        if da('font', dd) ~= nil then
          cd:setFontSize(da('font', dd))
        end
        return cd
      end,
      setSize = function(cd, dd, __a, a_a)
        db.setSize(cd, dd, __a, a_a)
        ac = false
        cd:updateDraw()
        return cd
      end,
      eventHandler = function(cd, dd)
        if dd == 'basalt_resize' then
          if ac then
            local __a = cd:getValue()
            if __a:len() + cd:getX() > cd.parent:getWidth() then
              local a_a = cd.parent:getWidth() - cd:getX()
              db.setSize(cd, a_a, #_b(__a, a_a))
            else
              db.setSize(cd, __a:len(), 1)
            end
          else
          end
        end
      end,
      draw = function(cd)
        if db.draw(cd) then
          if cd.parent ~= nil then
            local dd, __a = cd:getAnchorPosition()
            local a_a, b_a = cd:getSize()
            local c_a = ca.getTextVerticalAlign(b_a, cc)
            if dc == 0 then
              if not ac then
                local d_a = _b(cd:getValue(), cd:getWidth())
                for _aa, aaa in pairs(d_a) do
                  if _aa <= b_a then
                    cd.parent:writeText(dd, __a + _aa - 1, aaa, cd.bgColor, cd.fgColor)
                  end
                end
              else
                if #cd:getValue() + dd > cd.parent:getWidth() then
                  local d_a = _b(cd:getValue(), cd:getWidth())
                  for _aa, aaa in pairs(d_a) do
                    if _aa <= b_a then
                      cd.parent:writeText(dd, __a + _aa - 1, aaa, cd.bgColor, cd.fgColor)
                    end
                  end
                else
                  cd.parent:writeText(dd, __a, cd:getValue(), cd.bgColor, cd.fgColor)
                end
              end
            else
              local d_a = bb(dc, cd:getValue(), cd.fgColor, cd.bgColor or colors.lightGray)
              if ac then
                cd:setSize(#d_a[1][1], #d_a[1] - 1)
              end
              local _aa, aaa = cd.parent:getSize()
              local baa, caa = #d_a[1][1], #d_a[1]
              dd = dd or math.floor((_aa - baa) / 2) + 1
              __a = __a or math.floor((aaa - caa) / 2) + 1
              for i = 1, caa do
                cd.parent:setFG(dd, __a + i - 1, d_a[2][i])
                cd.parent:setBG(dd, __a + i - 1, d_a[3][i])
                cd.parent:setText(dd, __a + i - 1, d_a[1][i])
              end
            end
          end
        end
      end,
      init = function(cd)
        cd.parent:addEvent('other_event', cd)
        if db.init(cd) then
          cd.bgColor = cd.parent:getTheme 'LabelBG'
          cd.fgColor = cd.parent:getTheme 'LabelText'
          if (cd.parent.bgColor == colors.black) and (cd.fgColor == colors.black) then
            cd.fgColor = colors.lightGray
          end
        end
      end,
    }
    return setmetatable(bd, db)
  end
end
project['objects']['List'] = function(...)
  local d = require 'Object'
  local _a = require 'utils'
  local aa = _a.getValueFromXML
  return function(ba)
    local ca = d(ba)
    local da = 'List'
    ca.width = 16
    ca.height = 6
    ca:setZIndex(5)
    local _b = {}
    local ab
    local bb
    local cb = true
    local db = 'left'
    local _c = 0
    local ac = true
    local bc = {
      getType = function(cc)
        return da
      end,
      addItem = function(cc, dc, _d, ad, ...)
        table.insert(_b, { text = dc, bgCol = _d or cc.bgColor, fgCol = ad or cc.fgColor, args = { ... } })
        if #_b == 1 then
          cc:setValue(_b[1])
        end
        cc:updateDraw()
        return cc
      end,
      setOffset = function(cc, dc)
        _c = dc
        cc:updateDraw()
        return cc
      end,
      getOffset = function(cc)
        return _c
      end,
      removeItem = function(cc, dc)
        table.remove(_b, dc)
        cc:updateDraw()
        return cc
      end,
      getItem = function(cc, dc)
        return _b[dc]
      end,
      getAll = function(cc)
        return _b
      end,
      getItemIndex = function(cc)
        local dc = cc:getValue()
        for _d, ad in pairs(_b) do
          if ad == dc then
            return _d
          end
        end
      end,
      clear = function(cc)
        _b = {}
        cc:setValue {}
        cc:updateDraw()
        return cc
      end,
      getItemCount = function(cc)
        return #_b
      end,
      editItem = function(cc, dc, _d, ad, bd, ...)
        table.remove(_b, dc)
        table.insert(_b, dc, { text = _d, bgCol = ad or cc.bgColor, fgCol = bd or cc.fgColor, args = { ... } })
        cc:updateDraw()
        return cc
      end,
      selectItem = function(cc, dc)
        cc:setValue(_b[dc] or {})
        cc:updateDraw()
        return cc
      end,
      setSelectedItem = function(cc, dc, _d, ad)
        ab = dc or cc.bgColor
        bb = _d or cc.fgColor
        cb = ad ~= nil and ad or true
        cc:updateDraw()
        return cc
      end,
      setScrollable = function(cc, dc)
        ac = dc
        if dc == nil then
          ac = true
        end
        cc:updateDraw()
        return cc
      end,
      setValuesByXMLData = function(cc, dc)
        ca.setValuesByXMLData(cc, dc)
        if aa('selectionBG', dc) ~= nil then
          ab = colors[aa('selectionBG', dc)]
        end
        if aa('selectionFG', dc) ~= nil then
          bb = colors[aa('selectionFG', dc)]
        end
        if aa('scrollable', dc) ~= nil then
          if aa('scrollable', dc) then
            cc:setScrollable(true)
          else
            cc:setScrollable(false)
          end
        end
        if aa('offset', dc) ~= nil then
          _c = aa('offset', dc)
        end
        if dc['item'] ~= nil then
          local _d = dc['item']
          if _d.properties ~= nil then
            _d = { _d }
          end
          for ad, bd in pairs(_d) do
            cc:addItem(aa('text', bd), colors[aa('bg', bd)], colors[aa('fg', bd)])
          end
        end
        return cc
      end,
      scrollHandler = function(cc, dc, _d, ad)
        if ca.scrollHandler(cc, dc, _d, ad) then
          if ac then
            local bd, cd = cc:getSize()
            _c = _c + dc
            if _c < 0 then
              _c = 0
            end
            if dc >= 1 then
              if #_b > cd then
                if _c > #_b - cd then
                  _c = #_b - cd
                end
                if _c >= #_b then
                  _c = #_b - 1
                end
              else
                _c = _c - 1
              end
            end
            cc:updateDraw()
          end
          return true
        end
        return false
      end,
      mouseHandler = function(cc, dc, _d, ad)
        if ca.mouseHandler(cc, dc, _d, ad) then
          local bd, cd = cc:getAbsolutePosition(cc:getAnchorPosition())
          local dd, __a = cc:getSize()
          if #_b > 0 then
            for n = 1, __a do
              if _b[n + _c] ~= nil then
                if (bd <= _d) and (bd + dd > _d) and (cd + n - 1 == ad) then
                  cc:setValue(_b[n + _c])
                  cc:updateDraw()
                end
              end
            end
          end
          return true
        end
        return false
      end,
      dragHandler = function(cc, dc, _d, ad)
        return cc:mouseHandler(dc, _d, ad)
      end,
      touchHandler = function(cc, dc, _d)
        return cc:mouseHandler(1, dc, _d)
      end,
      draw = function(cc)
        if ca.draw(cc) then
          if cc.parent ~= nil then
            local dc, _d = cc:getAnchorPosition()
            local ad, bd = cc:getSize()
            if cc.bgColor ~= false then
              cc.parent:drawBackgroundBox(dc, _d, ad, bd, cc.bgColor)
            end
            for n = 1, bd do
              if _b[n + _c] ~= nil then
                if _b[n + _c] == cc:getValue() then
                  if cb then
                    cc.parent:writeText(dc, _d + n - 1, _a.getTextHorizontalAlign(_b[n + _c].text, ad, db), ab, bb)
                  else
                    cc.parent:writeText(
                      dc,
                      _d + n - 1,
                      _a.getTextHorizontalAlign(_b[n + _c].text, ad, db),
                      _b[n + _c].bgCol,
                      _b[n + _c].fgCol
                    )
                  end
                else
                  cc.parent:writeText(
                    dc,
                    _d + n - 1,
                    _a.getTextHorizontalAlign(_b[n + _c].text, ad, db),
                    _b[n + _c].bgCol,
                    _b[n + _c].fgCol
                  )
                end
              end
            end
          end
        end
      end,
      init = function(cc)
        cc.parent:addEvent('mouse_click', cc)
        cc.parent:addEvent('mouse_drag', cc)
        cc.parent:addEvent('mouse_scroll', cc)
        if ca.init(cc) then
          cc.bgColor = cc.parent:getTheme 'ListBG'
          cc.fgColor = cc.parent:getTheme 'ListText'
          ab = cc.parent:getTheme 'SelectionBG'
          bb = cc.parent:getTheme 'SelectionText'
        end
      end,
    }
    return setmetatable(bc, ca)
  end
end
project['objects']['Menubar'] = function(...)
  local _a = require 'Object'
  local aa = require 'utils'
  local ba = aa.getValueFromXML
  local ca = require 'tHex'
  return function(da)
    local _b = _a(da)
    local ab = 'Menubar'
    local bb = {}
    _b.width = 30
    _b.height = 1
    _b:setZIndex(5)
    local cb = {}
    local db
    local _c
    local ac = true
    local bc = 'left'
    local cc = 0
    local dc = 1
    local _d = false
    local function ad()
      local bd = 0
      local cd = 0
      local dd = bb:getWidth()
      for n = 1, #cb do
        if cd + cb[n].text:len() + dc * 2 > dd then
          if cd < dd then
            bd = bd + (cb[n].text:len() + dc * 2 - (dd - cd))
          else
            bd = bd + cb[n].text:len() + dc * 2
          end
        end
        cd = cd + cb[n].text:len() + dc * 2
      end
      return bd
    end
    bb = {
      getType = function(bd)
        return ab
      end,
      addItem = function(bd, cd, dd, __a, ...)
        table.insert(cb, { text = tostring(cd), bgCol = dd or bd.bgColor, fgCol = __a or bd.fgColor, args = { ... } })
        if #cb == 1 then
          bd:setValue(cb[1])
        end
        bd:updateDraw()
        return bd
      end,
      getAll = function(bd)
        return cb
      end,
      getItemIndex = function(bd)
        local cd = bd:getValue()
        for dd, __a in pairs(cb) do
          if __a == cd then
            return dd
          end
        end
      end,
      clear = function(bd)
        cb = {}
        bd:setValue {}
        bd:updateDraw()
        return bd
      end,
      setSpace = function(bd, cd)
        dc = cd or dc
        bd:updateDraw()
        return bd
      end,
      setOffset = function(bd, cd)
        cc = cd or 0
        if cc < 0 then
          cc = 0
        end
        local dd = ad()
        if cc > dd then
          cc = dd
        end
        bd:updateDraw()
        return bd
      end,
      getOffset = function(bd)
        return cc
      end,
      setScrollable = function(bd, cd)
        _d = cd
        if cd == nil then
          _d = true
        end
        return bd
      end,
      setValuesByXMLData = function(bd, cd)
        _b.setValuesByXMLData(bd, cd)
        if ba('selectionBG', cd) ~= nil then
          db = colors[ba('selectionBG', cd)]
        end
        if ba('selectionFG', cd) ~= nil then
          _c = colors[ba('selectionFG', cd)]
        end
        if ba('scrollable', cd) ~= nil then
          if ba('scrollable', cd) then
            bd:setScrollable(true)
          else
            bd:setScrollable(false)
          end
        end
        if ba('offset', cd) ~= nil then
          bd:setOffset(ba('offset', cd))
        end
        if ba('space', cd) ~= nil then
          dc = ba('space', cd)
        end
        if cd['item'] ~= nil then
          local dd = cd['item']
          if dd.properties ~= nil then
            dd = { dd }
          end
          for __a, a_a in pairs(dd) do
            bd:addItem(ba('text', a_a), colors[ba('bg', a_a)], colors[ba('fg', a_a)])
          end
        end
        return bd
      end,
      removeItem = function(bd, cd)
        table.remove(cb, cd)
        bd:updateDraw()
        return bd
      end,
      getItem = function(bd, cd)
        return cb[cd]
      end,
      getItemCount = function(bd)
        return #cb
      end,
      editItem = function(bd, cd, dd, __a, a_a, ...)
        table.remove(cb, cd)
        table.insert(cb, cd, { text = dd, bgCol = __a or bd.bgColor, fgCol = a_a or bd.fgColor, args = { ... } })
        bd:updateDraw()
        return bd
      end,
      selectItem = function(bd, cd)
        bd:setValue(cb[cd] or {})
        bd:updateDraw()
        return bd
      end,
      setSelectedItem = function(bd, cd, dd, __a)
        db = cd or bd.bgColor
        _c = dd or bd.fgColor
        ac = __a
        bd:updateDraw()
        return bd
      end,
      mouseHandler = function(bd, cd, dd, __a)
        if _b.mouseHandler(bd, cd, dd, __a) then
          local a_a, b_a = bd:getAbsolutePosition(bd:getAnchorPosition())
          local c_a, d_a = bd:getSize()
          local _aa = 0
          for n = 1, #cb do
            if cb[n] ~= nil then
              if (a_a + _aa <= dd + cc) and (a_a + _aa + cb[n].text:len() + (dc * 2) > dd + cc) and (b_a == __a) then
                bd:setValue(cb[n])
                bd:getEventSystem():sendEvent(event, bd, event, 0, dd, __a, cb[n])
              end
              _aa = _aa + cb[n].text:len() + dc * 2
            end
          end
          bd:updateDraw()
          return true
        end
        return false
      end,
      scrollHandler = function(bd, cd, dd, __a)
        if _b.scrollHandler(bd, cd, dd, __a) then
          if _d then
            cc = cc + cd
            if cc < 0 then
              cc = 0
            end
            local a_a = ad()
            if cc > a_a then
              cc = a_a
            end
            bd:updateDraw()
          end
          return true
        end
        return false
      end,
      draw = function(bd)
        if _b.draw(bd) then
          if bd.parent ~= nil then
            local cd, dd = bd:getAnchorPosition()
            local __a, a_a = bd:getSize()
            if bd.bgColor ~= false then
              bd.parent:drawBackgroundBox(cd, dd, __a, a_a, bd.bgColor)
            end
            local b_a = ''
            local c_a = ''
            local d_a = ''
            for _aa, aaa in pairs(cb) do
              local baa = (' '):rep(dc) .. aaa.text .. (' '):rep(dc)
              b_a = b_a .. baa
              if aaa == bd:getValue() then
                c_a = c_a .. ca[db or aaa.bgCol or bd.bgColor]:rep(baa:len())
                d_a = d_a .. ca[_c or aaa.FgCol or bd.fgColor]:rep(baa:len())
              else
                c_a = c_a .. ca[aaa.bgCol or bd.bgColor]:rep(baa:len())
                d_a = d_a .. ca[aaa.FgCol or bd.fgColor]:rep(baa:len())
              end
            end
            bd.parent:setText(cd, dd, b_a:sub(cc + 1, __a + cc))
            bd.parent:setBG(cd, dd, c_a:sub(cc + 1, __a + cc))
            bd.parent:setFG(cd, dd, d_a:sub(cc + 1, __a + cc))
          end
        end
      end,
      init = function(bd)
        bd.parent:addEvent('mouse_click', bd)
        bd.parent:addEvent('mouse_scroll', bd)
        if _b.init(bd) then
          bd.bgColor = bd.parent:getTheme 'MenubarBG'
          bd.fgColor = bd.parent:getTheme 'MenubarText'
          db = bd.parent:getTheme 'SelectionBG'
          _c = bd.parent:getTheme 'SelectionText'
        end
      end,
    }
    return setmetatable(bb, _b)
  end
end
project['objects']['Pane'] = function(...)
  local c = require 'Object'
  local d = require 'basaltLogs'
  return function(_a)
    local aa = c(_a)
    local ba = 'Pane'
    local ca = {
      getType = function(da)
        return ba
      end,
      setBackground = function(da, _b, ab, bb)
        aa.setBackground(da, _b, ab, bb)
        return da
      end,
      init = function(da)
        if aa.init(da) then
          da.bgColor = da.parent:getTheme 'PaneBG'
          da.fgColor = da.parent:getTheme 'PaneBG'
        end
      end,
    }
    return setmetatable(ca, aa)
  end
end
project['objects']['Program'] = function(...)
  local aa = require 'Object'
  local ba = require 'tHex'
  local ca = require 'process'
  local da = require('utils').getValueFromXML
  local _b = string.sub
  return function(ab, bb)
    local cb = aa(ab)
    local db = 'Program'
    cb:setZIndex(5)
    local _c
    local ac
    local bc = {}
    local function cc(b_a, c_a, d_a, _aa, aaa)
      local baa, caa = 1, 1
      local daa, _ba = colors.black, colors.white
      local aba = false
      local bba = false
      local cba = {}
      local dba = {}
      local _ca = {}
      local aca = {}
      local bca
      local cca = {}
      for i = 0, 15 do
        local aab = 2 ^ i
        aca[aab] = { bb:getBasaltInstance().getBaseTerm().getPaletteColour(aab) }
      end
      local function dca()
        bca = (' '):rep(d_a)
        for n = 0, 15 do
          local aab = 2 ^ n
          local bab = ba[aab]
          cca[aab] = bab:rep(d_a)
        end
      end
      local function _da()
        dca()
        local aab = bca
        local bab = cca[colors.white]
        local cab = cca[colors.black]
        for n = 1, _aa do
          cba[n] = _b(cba[n] == nil and aab or cba[n] .. aab:sub(1, d_a - cba[n]:len()), 1, d_a)
          _ca[n] = _b(_ca[n] == nil and bab or _ca[n] .. bab:sub(1, d_a - _ca[n]:len()), 1, d_a)
          dba[n] = _b(dba[n] == nil and cab or dba[n] .. cab:sub(1, d_a - dba[n]:len()), 1, d_a)
        end
        cb.updateDraw(cb)
      end
      _da()
      local function ada()
        if baa >= 1 and caa >= 1 and baa <= d_a and caa <= _aa then
        else
        end
      end
      local function bda(aab, bab, cab)
        local dab = baa
        local _bb = dab + #aab - 1
        if caa >= 1 and caa <= _aa then
          if dab <= d_a and _bb >= 1 then
            if dab == 1 and _bb == d_a then
              cba[caa] = aab
              _ca[caa] = bab
              dba[caa] = cab
            else
              local abb, bbb, cbb
              if dab < 1 then
                local _db = 1 - dab + 1
                local adb = d_a - dab + 1
                abb = _b(aab, _db, adb)
                bbb = _b(bab, _db, adb)
                cbb = _b(cab, _db, adb)
              elseif _bb > d_a then
                local _db = d_a - dab + 1
                abb = _b(aab, 1, _db)
                bbb = _b(bab, 1, _db)
                cbb = _b(cab, 1, _db)
              else
                abb = aab
                bbb = bab
                cbb = cab
              end
              local dbb = cba[caa]
              local _cb = _ca[caa]
              local acb = dba[caa]
              local bcb, ccb, dcb
              if dab > 1 then
                local _db = dab - 1
                bcb = _b(dbb, 1, _db) .. abb
                ccb = _b(_cb, 1, _db) .. bbb
                dcb = _b(acb, 1, _db) .. cbb
              else
                bcb = abb
                ccb = bbb
                dcb = cbb
              end
              if _bb < d_a then
                local _db = _bb + 1
                bcb = bcb .. _b(dbb, _db, d_a)
                ccb = ccb .. _b(_cb, _db, d_a)
                dcb = dcb .. _b(acb, _db, d_a)
              end
              cba[caa] = bcb
              _ca[caa] = ccb
              dba[caa] = dcb
            end
            _c:updateDraw()
          end
          baa = _bb + 1
          if bba then
            ada()
          end
        end
      end
      local function cda(aab, bab, cab)
        if cab ~= nil then
          local dab = cba[bab]
          if dab ~= nil then
            cba[bab] = _b(dab:sub(1, aab - 1) .. cab .. dab:sub(aab + (cab:len()), d_a), 1, d_a)
          end
        end
        _c:updateDraw()
      end
      local function dda(aab, bab, cab)
        if cab ~= nil then
          local dab = dba[bab]
          if dab ~= nil then
            dba[bab] = _b(dab:sub(1, aab - 1) .. cab .. dab:sub(aab + (cab:len()), d_a), 1, d_a)
          end
        end
        _c:updateDraw()
      end
      local function __b(aab, bab, cab)
        if cab ~= nil then
          local dab = _ca[bab]
          if dab ~= nil then
            _ca[bab] = _b(dab:sub(1, aab - 1) .. cab .. dab:sub(aab + (cab:len()), d_a), 1, d_a)
          end
        end
        _c:updateDraw()
      end
      local a_b = function(aab)
        if type(aab) ~= 'number' then
          error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
        elseif ba[aab] == nil then
          error('Invalid color (got ' .. aab .. ')', 2)
        end
        _ba = aab
      end
      local b_b = function(aab)
        if type(aab) ~= 'number' then
          error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
        elseif ba[aab] == nil then
          error('Invalid color (got ' .. aab .. ')', 2)
        end
        daa = aab
      end
      local c_b = function(aab, bab, cab, dab)
        if type(aab) ~= 'number' then
          error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
        end
        if ba[aab] == nil then
          error('Invalid color (got ' .. aab .. ')', 2)
        end
        local _bb
        if type(bab) == 'number' and cab == nil and dab == nil then
          _bb = { colours.rgb8(bab) }
          aca[aab] = _bb
        else
          if type(bab) ~= 'number' then
            error('bad argument #2 (expected number, got ' .. type(bab) .. ')', 2)
          end
          if type(cab) ~= 'number' then
            error('bad argument #3 (expected number, got ' .. type(cab) .. ')', 2)
          end
          if type(dab) ~= 'number' then
            error('bad argument #4 (expected number, got ' .. type(dab) .. ')', 2)
          end
          _bb = aca[aab]
          _bb[1] = bab
          _bb[2] = cab
          _bb[3] = dab
        end
      end
      local d_b = function(aab)
        if type(aab) ~= 'number' then
          error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
        end
        if ba[aab] == nil then
          error('Invalid color (got ' .. aab .. ')', 2)
        end
        local bab = aca[aab]
        return bab[1], bab[2], bab[3]
      end
      local _ab = {
        setCursorPos = function(aab, bab)
          if type(aab) ~= 'number' then
            error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
          end
          if type(bab) ~= 'number' then
            error('bad argument #2 (expected number, got ' .. type(bab) .. ')', 2)
          end
          baa = math.floor(aab)
          caa = math.floor(bab)
          if bba then
            ada()
          end
        end,
        getCursorPos = function()
          return baa, caa
        end,
        setCursorBlink = function(aab)
          if type(aab) ~= 'boolean' then
            error('bad argument #1 (expected boolean, got ' .. type(aab) .. ')', 2)
          end
          aba = aab
        end,
        getCursorBlink = function()
          return aba
        end,
        getPaletteColor = d_b,
        getPaletteColour = d_b,
        setBackgroundColor = b_b,
        setBackgroundColour = b_b,
        setTextColor = a_b,
        setTextColour = a_b,
        setPaletteColor = c_b,
        setPaletteColour = c_b,
        getBackgroundColor = function()
          return daa
        end,
        getBackgroundColour = function()
          return daa
        end,
        getSize = function()
          return d_a, _aa
        end,
        getTextColor = function()
          return _ba
        end,
        getTextColour = function()
          return _ba
        end,
        basalt_resize = function(aab, bab)
          d_a, _aa = aab, bab
          _da()
        end,
        basalt_reposition = function(aab, bab)
          b_a, c_a = aab, bab
        end,
        basalt_setVisible = function(aab)
          bba = aab
        end,
        drawBackgroundBox = function(aab, bab, cab, dab, _bb)
          for n = 1, dab do
            dda(aab, bab + (n - 1), ba[_bb]:rep(cab))
          end
        end,
        drawForegroundBox = function(aab, bab, cab, dab, _bb)
          for n = 1, dab do
            __b(aab, bab + (n - 1), ba[_bb]:rep(cab))
          end
        end,
        drawTextBox = function(aab, bab, cab, dab, _bb)
          for n = 1, dab do
            cda(aab, bab + (n - 1), _bb:rep(cab))
          end
        end,
        writeText = function(aab, bab, cab, dab, _bb)
          dab = dab or daa
          _bb = _bb or _ba
          cda(b_a, bab, cab)
          dda(aab, bab, ba[dab]:rep(cab:len()))
          __b(aab, bab, ba[_bb]:rep(cab:len()))
        end,
        basalt_update = function()
          if bb ~= nil then
            for n = 1, _aa do
              bb:setText(b_a, c_a + (n - 1), cba[n])
              bb:setBG(b_a, c_a + (n - 1), dba[n])
              bb:setFG(b_a, c_a + (n - 1), _ca[n])
            end
          end
        end,
        scroll = function(aab)
          if type(aab) ~= 'number' then
            error('bad argument #1 (expected number, got ' .. type(aab) .. ')', 2)
          end
          if aab ~= 0 then
            local bab = bca
            local cab = cca[_ba]
            local dab = cca[daa]
            for newY = 1, _aa do
              local _bb = newY + aab
              if _bb >= 1 and _bb <= _aa then
                cba[newY] = cba[_bb]
                dba[newY] = dba[_bb]
                _ca[newY] = _ca[_bb]
              else
                cba[newY] = bab
                _ca[newY] = cab
                dba[newY] = dab
              end
            end
          end
          if bba then
            ada()
          end
        end,
        isColor = function()
          return bb:getBasaltInstance().getBaseTerm().isColor()
        end,
        isColour = function()
          return bb:getBasaltInstance().getBaseTerm().isColor()
        end,
        write = function(aab)
          aab = tostring(aab)
          if bba then
            bda(aab, ba[_ba]:rep(aab:len()), ba[daa]:rep(aab:len()))
          end
        end,
        clearLine = function()
          if bba then
            cda(1, caa, (' '):rep(d_a))
            dda(1, caa, ba[daa]:rep(d_a))
            __b(1, caa, ba[_ba]:rep(d_a))
          end
          if bba then
            ada()
          end
        end,
        clear = function()
          for n = 1, _aa do
            cda(1, n, (' '):rep(d_a))
            dda(1, n, ba[daa]:rep(d_a))
            __b(1, n, ba[_ba]:rep(d_a))
          end
          if bba then
            ada()
          end
        end,
        blit = function(aab, bab, cab)
          if type(aab) ~= 'string' then
            error('bad argument #1 (expected string, got ' .. type(aab) .. ')', 2)
          end
          if type(bab) ~= 'string' then
            error('bad argument #2 (expected string, got ' .. type(bab) .. ')', 2)
          end
          if type(cab) ~= 'string' then
            error('bad argument #3 (expected string, got ' .. type(cab) .. ')', 2)
          end
          if #bab ~= #aab or #cab ~= #aab then
            error('Arguments must be the same length', 2)
          end
          if bba then
            bda(aab, bab, cab)
          end
        end,
      }
      return _ab
    end
    cb.width = 30
    cb.height = 12
    local dc = cc(1, 1, cb.width, cb.height)
    local _d
    local ad = false
    local bd = {}
    local function cd(b_a)
      local c_a, d_a = dc.getCursorPos()
      local _aa, aaa = b_a:getAnchorPosition()
      local baa, caa = b_a:getSize()
      if _aa + c_a - 1 >= 1 and _aa + c_a - 1 <= _aa + baa - 1 and d_a + aaa - 1 >= 1 and d_a + aaa - 1 <= aaa + caa - 1 then
        b_a.parent:setCursor(b_a:isFocused() and dc.getCursorBlink(), _aa + c_a - 1, d_a + aaa - 1, dc.getTextColor())
      end
    end
    local function dd(b_a, c_a, ...)
      local d_a, _aa = _d:resume(c_a, ...)
      if (d_a == false) and (_aa ~= nil) and (_aa ~= 'Terminated') then
        local aaa = b_a:sendEvent('program_error', _aa)
        if aaa ~= false then
          error('Basalt Program - ' .. _aa)
        end
      end
      if _d:getStatus() == 'dead' then
        b_a:sendEvent 'program_done'
      end
    end
    local function __a(b_a, c_a, d_a, _aa, aaa)
      if _d == nil then
        return false
      end
      if not (_d:isDead()) then
        if not ad then
          local baa, caa = b_a:getAbsolutePosition(b_a:getAnchorPosition(nil, nil, true))
          dd(b_a, c_a, d_a, _aa - baa + 1, aaa - caa + 1)
          cd(b_a)
        end
      end
    end
    local function a_a(b_a, c_a, d_a, _aa)
      if _d == nil then
        return false
      end
      if not (_d:isDead()) then
        if not ad then
          if b_a.draw then
            dd(b_a, c_a, d_a, _aa)
            cd(b_a)
          end
        end
      end
    end
    _c = {
      getType = function(b_a)
        return db
      end,
      show = function(b_a)
        cb.show(b_a)
        dc.setBackgroundColor(b_a.bgColor)
        dc.setTextColor(b_a.fgColor)
        dc.basalt_setVisible(true)
        return b_a
      end,
      hide = function(b_a)
        cb.hide(b_a)
        dc.basalt_setVisible(false)
        return b_a
      end,
      setPosition = function(b_a, c_a, d_a, _aa)
        cb.setPosition(b_a, c_a, d_a, _aa)
        dc.basalt_reposition(b_a:getAnchorPosition())
        return b_a
      end,
      setValuesByXMLData = function(b_a, c_a)
        cb.setValuesByXMLData(b_a, c_a)
        if da('path', c_a) ~= nil then
          ac = da('path', c_a)
        end
        if da('execute', c_a) ~= nil then
          if da('execute', c_a) then
            if ac ~= nil then
              b_a:execute(ac)
            end
          end
        end
      end,
      getBasaltWindow = function()
        return dc
      end,
      getBasaltProcess = function()
        return _d
      end,
      setSize = function(b_a, c_a, d_a, _aa)
        cb.setSize(b_a, c_a, d_a, _aa)
        dc.basalt_resize(b_a:getWidth(), b_a:getHeight())
        return b_a
      end,
      getStatus = function(b_a)
        if _d ~= nil then
          return _d:getStatus()
        end
        return 'inactive'
      end,
      setEnviroment = function(b_a, c_a)
        bc = c_a or {}
        return b_a
      end,
      execute = function(b_a, c_a, ...)
        ac = c_a or ac
        _d = ca:new(ac, dc, bc, ...)
        dc.setBackgroundColor(colors.black)
        dc.setTextColor(colors.white)
        dc.clear()
        dc.setCursorPos(1, 1)
        dc.setBackgroundColor(b_a.bgColor)
        dc.setTextColor(b_a.fgColor)
        dc.basalt_setVisible(true)
        dd(b_a)
        ad = false
        if b_a.parent ~= nil then
          b_a.parent:addEvent('mouse_click', b_a)
          b_a.parent:addEvent('mouse_up', b_a)
          b_a.parent:addEvent('mouse_drag', b_a)
          b_a.parent:addEvent('mouse_scroll', b_a)
          b_a.parent:addEvent('key', b_a)
          b_a.parent:addEvent('key_up', b_a)
          b_a.parent:addEvent('char', b_a)
          b_a.parent:addEvent('other_event', b_a)
        end
        return b_a
      end,
      stop = function(b_a)
        if _d ~= nil then
          if not (_d:isDead()) then
            dd(b_a, 'terminate')
            if _d:isDead() then
              if b_a.parent ~= nil then
                b_a.parent:setCursor(false)
              end
            end
          end
        end
        b_a.parent:removeEvents(b_a)
        return b_a
      end,
      pause = function(b_a, c_a)
        ad = c_a or not ad
        if _d ~= nil then
          if not (_d:isDead()) then
            if not ad then
              b_a:injectEvents(bd)
              bd = {}
            end
          end
        end
        return b_a
      end,
      isPaused = function(b_a)
        return ad
      end,
      injectEvent = function(b_a, c_a, d_a, _aa, aaa, baa, caa)
        if _d ~= nil then
          if not (_d:isDead()) then
            if (ad == false) or caa then
              dd(b_a, c_a, d_a, _aa, aaa, baa)
            else
              table.insert(bd, { event = c_a, args = { d_a, _aa, aaa, baa } })
            end
          end
        end
        return b_a
      end,
      getQueuedEvents = function(b_a)
        return bd
      end,
      updateQueuedEvents = function(b_a, c_a)
        bd = c_a or bd
        return b_a
      end,
      injectEvents = function(b_a, c_a)
        if _d ~= nil then
          if not (_d:isDead()) then
            for d_a, _aa in pairs(c_a) do
              dd(b_a, _aa.event, table.unpack(_aa.args))
            end
          end
        end
        return b_a
      end,
      mouseHandler = function(b_a, c_a, d_a, _aa)
        if cb.mouseHandler(b_a, c_a, d_a, _aa) then
          __a(b_a, 'mouse_click', c_a, d_a, _aa)
          return true
        end
        return false
      end,
      mouseUpHandler = function(b_a, c_a, d_a, _aa)
        if cb.mouseUpHandler(b_a, c_a, d_a, _aa) then
          __a(b_a, 'mouse_up', c_a, d_a, _aa)
          return true
        end
        return false
      end,
      scrollHandler = function(b_a, c_a, d_a, _aa)
        if cb.scrollHandler(b_a, c_a, d_a, _aa) then
          __a(b_a, 'mouse_scroll', c_a, d_a, _aa)
          return true
        end
        return false
      end,
      dragHandler = function(b_a, c_a, d_a, _aa)
        if cb.dragHandler(b_a, c_a, d_a, _aa) then
          __a(b_a, 'mouse_drag', c_a, d_a, _aa)
          return true
        end
        return false
      end,
      keyHandler = function(b_a, c_a, d_a)
        if cb.keyHandler(b_a, c_a, d_a) then
          a_a(b_a, 'key', c_a, d_a)
          return true
        end
        return false
      end,
      keyUpHandler = function(b_a, c_a)
        if cb.keyUpHandler(b_a, c_a) then
          a_a(b_a, 'key_up', c_a)
          return true
        end
        return false
      end,
      charHandler = function(b_a, c_a)
        if cb.charHandler(b_a, c_a) then
          a_a(b_a, 'char', c_a)
          return true
        end
        return false
      end,
      getFocusHandler = function(b_a)
        cb.getFocusHandler(b_a)
        if _d ~= nil then
          if not (_d:isDead()) then
            if not ad then
              if b_a.parent ~= nil then
                local c_a, d_a = dc.getCursorPos()
                local _aa, aaa = b_a:getAnchorPosition()
                local baa, caa = b_a:getSize()
                if
                  _aa + c_a - 1 >= 1
                  and _aa + c_a - 1 <= _aa + baa - 1
                  and d_a + aaa - 1 >= 1
                  and d_a + aaa - 1 <= aaa + caa - 1
                then
                  b_a.parent:setCursor(dc.getCursorBlink(), _aa + c_a - 1, d_a + aaa - 1, dc.getTextColor())
                end
              end
            end
          end
        end
      end,
      loseFocusHandler = function(b_a)
        cb.loseFocusHandler(b_a)
        if _d ~= nil then
          if not (_d:isDead()) then
            if b_a.parent ~= nil then
              b_a.parent:setCursor(false)
            end
          end
        end
      end,
      eventHandler = function(b_a, c_a, d_a, _aa, aaa, baa)
        if cb.eventHandler(b_a, c_a, d_a, _aa, aaa, baa) then
          if _d == nil then
            return
          end
          if c_a == 'dynamicValueEvent' then
            local caa, daa = dc.getSize()
            local _ba, aba = b_a:getSize()
            if (caa ~= _ba) or (daa ~= aba) then
              dc.basalt_resize(_ba, aba)
              if not (_d:isDead()) then
                dd(b_a, 'term_resize')
              end
            end
            dc.basalt_reposition(b_a:getAnchorPosition())
          end
          if not (_d:isDead()) then
            if not ad then
              if c_a ~= 'terminate' then
                dd(b_a, c_a, d_a, _aa, aaa, baa)
              end
              if b_a:isFocused() then
                local caa, daa = b_a:getAnchorPosition()
                local _ba, aba = dc.getCursorPos()
                if b_a.parent ~= nil then
                  local bba, cba = b_a:getSize()
                  if
                    caa + _ba - 1 >= 1
                    and caa + _ba - 1 <= caa + bba - 1
                    and aba + daa - 1 >= 1
                    and aba + daa - 1 <= daa + cba - 1
                  then
                    b_a.parent:setCursor(dc.getCursorBlink(), caa + _ba - 1, aba + daa - 1, dc.getTextColor())
                  end
                end
                if c_a == 'terminate' then
                  dd(b_a, c_a)
                  b_a.parent:setCursor(false)
                  return true
                end
              end
            else
              table.insert(bd, { event = c_a, args = { d_a, _aa, aaa, baa } })
            end
          end
          return false
        end
      end,
      draw = function(b_a)
        if cb.draw(b_a) then
          if b_a.parent ~= nil then
            local c_a, d_a = b_a:getAnchorPosition()
            local _aa, aaa = dc.getCursorPos()
            local baa, caa = b_a:getSize()
            dc.basalt_reposition(c_a, d_a)
            dc.basalt_update()
            if
              c_a + _aa - 1 >= 1
              and c_a + _aa - 1 <= c_a + baa - 1
              and aaa + d_a - 1 >= 1
              and aaa + d_a - 1 <= d_a + caa - 1
            then
              b_a.parent:setCursor(b_a:isFocused() and dc.getCursorBlink(), c_a + _aa - 1, aaa + d_a - 1, dc.getTextColor())
            end
          end
        end
      end,
      onError = function(b_a, ...)
        for c_a, d_a in pairs(table.pack(...)) do
          if type(d_a) == 'function' then
            b_a:registerEvent('program_error', d_a)
          end
        end
        if b_a.parent ~= nil then
          b_a.parent:addEvent('other_event', b_a)
        end
        return b_a
      end,
      onDone = function(b_a, ...)
        for c_a, d_a in pairs(table.pack(...)) do
          if type(d_a) == 'function' then
            b_a:registerEvent('program_done', d_a)
          end
        end
        if b_a.parent ~= nil then
          b_a.parent:addEvent('other_event', b_a)
        end
        return b_a
      end,
      init = function(b_a)
        if cb.init(b_a) then
          pcall(function()
            elf.bgColor = b_a.parent:getTheme 'ProgramBG'
          end)
        end
      end,
    }
    return setmetatable(_c, cb)
  end
end
project['objects']['Progressbar'] = function(...)
  local c = require 'Object'
  local d = require('utils').getValueFromXML
  return function(_a)
    local aa = c(_a)
    local ba = 'Progressbar'
    local ca = 0
    aa:setZIndex(5)
    aa:setValue(false)
    aa.width = 25
    aa.height = 1
    local da
    local _b = ''
    local ab = colors.white
    local bb = ''
    local cb = 0
    local db = {
      init = function(_c)
        if aa.init(_c) then
          _c.bgColor = _c.parent:getTheme 'ProgressbarBG'
          _c.fgColor = _c.parent:getTheme 'ProgressbarText'
          da = _c.parent:getTheme 'ProgressbarActiveBG'
        end
      end,
      getType = function(_c)
        return ba
      end,
      setValuesByXMLData = function(_c, ac)
        aa.setValuesByXMLData(_c, ac)
        if d('direction', ac) ~= nil then
          cb = d('direction', ac)
        end
        if d('progressColor', ac) ~= nil then
          da = colors[d('progressColor', ac)]
        end
        if d('progressSymbol', ac) ~= nil then
          _b = d('progressSymbol', ac)
        end
        if d('backgroundSymbol', ac) ~= nil then
          bb = d('backgroundSymbol', ac)
        end
        if d('progressSymbolColor', ac) ~= nil then
          ab = colors[d('progressSymbolColor', ac)]
        end
        if d('onDone', ac) ~= nil then
          _c:generateXMLEventFunction(_c.onProgressDone, d('onDone', ac))
        end
        return _c
      end,
      setDirection = function(_c, ac)
        cb = ac
        _c:updateDraw()
        return _c
      end,
      setProgressBar = function(_c, ac, bc, cc)
        da = ac or da
        _b = bc or _b
        ab = cc or ab
        _c:updateDraw()
        return _c
      end,
      setBackgroundSymbol = function(_c, ac)
        bb = ac:sub(1, 1)
        _c:updateDraw()
        return _c
      end,
      setProgress = function(_c, ac)
        if (ac >= 0) and (ac <= 100) and (ca ~= ac) then
          ca = ac
          _c:setValue(ca)
          if ca == 100 then
            _c:progressDoneHandler()
          end
        end
        _c:updateDraw()
        return _c
      end,
      getProgress = function(_c)
        return ca
      end,
      onProgressDone = function(_c, ac)
        _c:registerEvent('progress_done', ac)
        return _c
      end,
      progressDoneHandler = function(_c)
        _c:sendEvent('progress_done', _c)
      end,
      draw = function(_c)
        if aa.draw(_c) then
          if _c.parent ~= nil then
            local ac, bc = _c:getAnchorPosition()
            local cc, dc = _c:getSize()
            if _c.bgColor ~= false then
              _c.parent:drawBackgroundBox(ac, bc, cc, dc, _c.bgColor)
            end
            if bb ~= '' then
              _c.parent:drawTextBox(ac, bc, cc, dc, bb)
            end
            if _c.fgColor ~= false then
              _c.parent:drawForegroundBox(ac, bc, cc, dc, _c.fgColor)
            end
            if cb == 1 then
              _c.parent:drawBackgroundBox(ac, bc, cc, dc / 100 * ca, da)
              _c.parent:drawForegroundBox(ac, bc, cc, dc / 100 * ca, ab)
              _c.parent:drawTextBox(ac, bc, cc, dc / 100 * ca, _b)
            elseif cb == 2 then
              _c.parent:drawBackgroundBox(ac, bc + math.ceil(dc - dc / 100 * ca), cc, dc / 100 * ca, da)
              _c.parent:drawForegroundBox(ac, bc + math.ceil(dc - dc / 100 * ca), cc, dc / 100 * ca, ab)
              _c.parent:drawTextBox(ac, bc + math.ceil(dc - dc / 100 * ca), cc, dc / 100 * ca, _b)
            elseif cb == 3 then
              _c.parent:drawBackgroundBox(ac + math.ceil(cc - cc / 100 * ca), bc, cc / 100 * ca, dc, da)
              _c.parent:drawForegroundBox(ac + math.ceil(cc - cc / 100 * ca), bc, cc / 100 * ca, dc, ab)
              _c.parent:drawTextBox(ac + math.ceil(cc - cc / 100 * ca), bc, cc / 100 * ca, dc, _b)
            else
              _c.parent:drawBackgroundBox(ac, bc, cc / 100 * ca, dc, da)
              _c.parent:drawForegroundBox(ac, bc, cc / 100 * ca, dc, ab)
              _c.parent:drawTextBox(ac, bc, cc / 100 * ca, dc, _b)
            end
          end
        end
      end,
    }
    return setmetatable(db, aa)
  end
end
project['objects']['Radio'] = function(...)
  local d = require 'Object'
  local _a = require 'utils'
  local aa = _a.getValueFromXML
  return function(ba)
    local ca = d(ba)
    local da = 'Radio'
    ca.width = 8
    ca:setZIndex(5)
    local _b = {}
    local ab
    local bb
    local cb
    local db
    local _c
    local ac
    local bc = true
    local cc = '\7'
    local dc = 'left'
    local _d = {
      getType = function(ad)
        return da
      end,
      setValuesByXMLData = function(ad, bd)
        ca.setValuesByXMLData(ad, bd)
        if aa('selectionBG', bd) ~= nil then
          ab = colors[aa('selectionBG', bd)]
        end
        if aa('selectionFG', bd) ~= nil then
          bb = colors[aa('selectionFG', bd)]
        end
        if aa('boxBG', bd) ~= nil then
          cb = colors[aa('boxBG', bd)]
        end
        if aa('inactiveBoxBG', bd) ~= nil then
          _c = colors[aa('inactiveBoxBG', bd)]
        end
        if aa('inactiveBoxFG', bd) ~= nil then
          ac = colors[aa('inactiveBoxFG', bd)]
        end
        if aa('boxFG', bd) ~= nil then
          db = colors[aa('boxFG', bd)]
        end
        if aa('symbol', bd) ~= nil then
          cc = aa('symbol', bd)
        end
        if bd['item'] ~= nil then
          local cd = bd['item']
          if cd.properties ~= nil then
            cd = { cd }
          end
          for dd, __a in pairs(cd) do
            ad:addItem(aa('text', __a), aa('x', __a), aa('y', __a), colors[aa('bg', __a)], colors[aa('fg', __a)])
          end
        end
        return ad
      end,
      addItem = function(ad, bd, cd, dd, __a, a_a, ...)
        table.insert(
          _b,
          { x = cd or 1, y = dd or 1, text = bd, bgCol = __a or ad.bgColor, fgCol = a_a or ad.fgColor, args = { ... } }
        )
        if #_b == 1 then
          ad:setValue(_b[1])
        end
        ad:updateDraw()
        return ad
      end,
      getAll = function(ad)
        return _b
      end,
      removeItem = function(ad, bd)
        table.remove(_b, bd)
        ad:updateDraw()
        return ad
      end,
      getItem = function(ad, bd)
        return _b[bd]
      end,
      getItemIndex = function(ad)
        local bd = ad:getValue()
        for cd, dd in pairs(_b) do
          if dd == bd then
            return cd
          end
        end
      end,
      clear = function(ad)
        _b = {}
        ad:setValue {}
        ad:updateDraw()
        return ad
      end,
      getItemCount = function(ad)
        return #_b
      end,
      editItem = function(ad, bd, cd, dd, __a, a_a, b_a, ...)
        table.remove(_b, bd)
        table.insert(
          _b,
          bd,
          { x = dd or 1, y = __a or 1, text = cd, bgCol = a_a or ad.bgColor, fgCol = b_a or ad.fgColor, args = { ... } }
        )
        ad:updateDraw()
        return ad
      end,
      selectItem = function(ad, bd)
        ad:setValue(_b[bd] or {})
        ad:updateDraw()
        return ad
      end,
      setActiveSymbol = function(ad, bd)
        cc = bd:sub(1, 1)
        ad:updateDraw()
        return ad
      end,
      setSelectedItem = function(ad, bd, cd, dd, __a, a_a)
        ab = bd or ab
        bb = cd or bb
        cb = dd or cb
        db = __a or db
        bc = a_a ~= nil and a_a or true
        ad:updateDraw()
        return ad
      end,
      mouseHandler = function(ad, bd, cd, dd)
        if #_b > 0 then
          local __a, a_a = ad:getAbsolutePosition(ad:getAnchorPosition())
          for b_a, c_a in pairs(_b) do
            if (__a + c_a.x - 1 <= cd) and (__a + c_a.x - 1 + c_a.text:len() + 1 >= cd) and (a_a + c_a.y - 1 == dd) then
              ad:setValue(c_a)
              local d_a = ad:getEventSystem():sendEvent('mouse_click', ad, 'mouse_click', bd, cd, dd)
              if d_a == false then
                return d_a
              end
              if ad.parent ~= nil then
                ad.parent:setFocusedObject(ad)
              end
              ad:updateDraw()
              return true
            end
          end
        end
        return false
      end,
      draw = function(ad)
        if ad.parent ~= nil then
          local bd, cd = ad:getAnchorPosition()
          for dd, __a in pairs(_b) do
            if __a == ad:getValue() then
              if dc == 'left' then
                ad.parent:writeText(__a.x + bd - 1, __a.y + cd - 1, cc, cb, db)
                ad.parent:writeText(__a.x + 2 + bd - 1, __a.y + cd - 1, __a.text, ab, bb)
              end
            else
              ad.parent:drawBackgroundBox(__a.x + bd - 1, __a.y + cd - 1, 1, 1, _c or ad.bgColor)
              ad.parent:writeText(__a.x + 2 + bd - 1, __a.y + cd - 1, __a.text, __a.bgCol, __a.fgCol)
            end
          end
          return true
        end
      end,
      init = function(ad)
        ad.parent:addEvent('mouse_click', ad)
        if ca.init(ad) then
          ad.bgColor = ad.parent:getTheme 'MenubarBG'
          ad.fgColor = ad.parent:getTheme 'MenubarFG'
          ab = ad.parent:getTheme 'SelectionBG'
          bb = ad.parent:getTheme 'SelectionText'
          cb = ad.parent:getTheme 'MenubarBG'
          db = ad.parent:getTheme 'MenubarText'
        end
      end,
    }
    return setmetatable(_d, ca)
  end
end
project['objects']['Scrollbar'] = function(...)
  local c = require 'Object'
  local d = require('utils').getValueFromXML
  return function(_a)
    local aa = c(_a)
    local ba = 'Scrollbar'
    aa.width = 1
    aa.height = 8
    aa:setValue(1)
    aa:setZIndex(2)
    local ca = 'vertical'
    local da = ' '
    local _b
    local ab = '\127'
    local bb = aa.height
    local cb = 1
    local db = 1
    local function _c(bc, cc, dc, _d)
      local ad, bd = bc:getAbsolutePosition(bc:getAnchorPosition())
      local cd, dd = bc:getSize()
      if ca == 'horizontal' then
        for _index = 0, cd do
          if (ad + _index == dc) and (bd <= _d) and (bd + dd > _d) then
            cb = math.min(_index + 1, cd - (db - 1))
            bc:setValue(bb / cd * cb)
            bc:updateDraw()
          end
        end
      end
      if ca == 'vertical' then
        for _index = 0, dd do
          if (bd + _index == _d) and (ad <= dc) and (ad + cd > dc) then
            cb = math.min(_index + 1, dd - (db - 1))
            bc:setValue(bb / dd * cb)
            bc:updateDraw()
          end
        end
      end
    end
    local ac = {
      getType = function(bc)
        return ba
      end,
      setSymbol = function(bc, cc)
        da = cc:sub(1, 1)
        bc:updateDraw()
        return bc
      end,
      setValuesByXMLData = function(bc, cc)
        aa.setValuesByXMLData(bc, cc)
        if d('maxValue', cc) ~= nil then
          bb = d('maxValue', cc)
        end
        if d('backgroundSymbol', cc) ~= nil then
          ab = d('backgroundSymbol', cc):sub(1, 1)
        end
        if d('symbol', cc) ~= nil then
          da = d('symbol', cc):sub(1, 1)
        end
        if d('barType', cc) ~= nil then
          ca = d('barType', cc):lower()
        end
        if d('symbolSize', cc) ~= nil then
          bc:setSymbolSize(d('symbolSize', cc))
        end
        if d('symbolColor', cc) ~= nil then
          _b = colors[d('symbolColor', cc)]
        end
        if d('index', cc) ~= nil then
          bc:setIndex(d('index', cc))
        end
      end,
      setIndex = function(bc, cc)
        cb = cc
        if cb < 1 then
          cb = 1
        end
        local dc, _d = bc:getSize()
        cb = math.min(cb, (ca == 'vertical' and _d or dc) - (db - 1))
        bc:setValue(bb / (ca == 'vertical' and _d or dc) * cb)
        bc:updateDraw()
        return bc
      end,
      getIndex = function(bc)
        return cb
      end,
      setSymbolSize = function(bc, cc)
        db = tonumber(cc) or 1
        local dc, _d = bc:getSize()
        if ca == 'vertical' then
          bc:setValue(cb - 1 * (bb / (_d - (db - 1))) - (bb / (_d - (db - 1))))
        elseif ca == 'horizontal' then
          bc:setValue(cb - 1 * (bb / (dc - (db - 1))) - (bb / (dc - (db - 1))))
        end
        bc:updateDraw()
        return bc
      end,
      setMaxValue = function(bc, cc)
        bb = cc
        bc:updateDraw()
        return bc
      end,
      setBackgroundSymbol = function(bc, cc)
        ab = string.sub(cc, 1, 1)
        bc:updateDraw()
        return bc
      end,
      setSymbolColor = function(bc, cc)
        _b = cc
        bc:updateDraw()
        return bc
      end,
      setBarType = function(bc, cc)
        ca = cc:lower()
        bc:updateDraw()
        return bc
      end,
      mouseHandler = function(bc, cc, dc, _d)
        if aa.mouseHandler(bc, cc, dc, _d) then
          _c(bc, cc, dc, _d)
          return true
        end
        return false
      end,
      dragHandler = function(bc, cc, dc, _d)
        if aa.dragHandler(bc, cc, dc, _d) then
          _c(bc, cc, dc, _d)
          return true
        end
        return false
      end,
      scrollHandler = function(bc, cc, dc, _d)
        if aa.scrollHandler(bc, cc, dc, _d) then
          local ad, bd = bc:getSize()
          cb = cb + cc
          if cb < 1 then
            cb = 1
          end
          cb = math.min(cb, (ca == 'vertical' and bd or ad) - (db - 1))
          bc:setValue(bb / (ca == 'vertical' and bd or ad) * cb)
          bc:updateDraw()
        end
      end,
      draw = function(bc)
        if aa.draw(bc) then
          if bc.parent ~= nil then
            local cc, dc = bc:getAnchorPosition()
            local _d, ad = bc:getSize()
            if ca == 'horizontal' then
              bc.parent:writeText(cc, dc, ab:rep(cb - 1), bc.bgColor, bc.fgColor)
              bc.parent:writeText(cc + cb - 1, dc, da:rep(db), _b, _b)
              bc.parent:writeText(cc + cb + db - 1, dc, ab:rep(_d - (cb + db - 1)), bc.bgColor, bc.fgColor)
            end
            if ca == 'vertical' then
              for n = 0, ad - 1 do
                if cb == n + 1 then
                  for curIndexOffset = 0, math.min(db - 1, ad) do
                    bc.parent:writeText(cc, dc + n + curIndexOffset, da, _b, _b)
                  end
                else
                  if (n + 1 < cb) or (n + 1 > cb - 1 + db) then
                    bc.parent:writeText(cc, dc + n, ab, bc.bgColor, bc.fgColor)
                  end
                end
              end
            end
          end
        end
      end,
      init = function(bc)
        bc.parent:addEvent('mouse_click', bc)
        bc.parent:addEvent('mouse_drag', bc)
        bc.parent:addEvent('mouse_scroll', bc)
        if aa.init(bc) then
          bc.bgColor = bc.parent:getTheme 'ScrollbarBG'
          bc.fgColor = bc.parent:getTheme 'ScrollbarText'
          _b = bc.parent:getTheme 'ScrollbarSymbolColor'
        end
      end,
    }
    return setmetatable(ac, aa)
  end
end
project['objects']['Slider'] = function(...)
  local d = require 'Object'
  local _a = require 'basaltLogs'
  local aa = require('utils').getValueFromXML
  return function(ba)
    local ca = d(ba)
    local da = 'Slider'
    ca.width = 8
    ca.height = 1
    ca:setValue(1)
    local _b = 'horizontal'
    local ab = ' '
    local bb
    local cb = '\140'
    local db = ca.width
    local _c = 1
    local ac = 1
    local function bc(dc, _d, ad, bd)
      local cd, dd = dc:getAbsolutePosition(dc:getAnchorPosition())
      local __a, a_a = dc:getSize()
      if _b == 'horizontal' then
        for _index = 0, __a do
          if (cd + _index == ad) and (dd <= bd) and (dd + a_a > bd) then
            _c = math.min(_index + 1, __a - (ac - 1))
            dc:setValue(db / __a * _c)
            dc:updateDraw()
          end
        end
      end
      if _b == 'vertical' then
        for _index = 0, a_a do
          if (dd + _index == bd) and (cd <= ad) and (cd + __a > ad) then
            _c = math.min(_index + 1, a_a - (ac - 1))
            dc:setValue(db / a_a * _c)
            dc:updateDraw()
          end
        end
      end
    end
    local cc = {
      getType = function(dc)
        return da
      end,
      setSymbol = function(dc, _d)
        ab = _d:sub(1, 1)
        dc:updateDraw()
        return dc
      end,
      setValuesByXMLData = function(dc, _d)
        ca.setValuesByXMLData(dc, _d)
        if aa('maxValue', _d) ~= nil then
          db = aa('maxValue', _d)
        end
        if aa('backgroundSymbol', _d) ~= nil then
          cb = aa('backgroundSymbol', _d):sub(1, 1)
        end
        if aa('barType', _d) ~= nil then
          _b = aa('barType', _d):lower()
        end
        if aa('symbol', _d) ~= nil then
          ab = aa('symbol', _d):sub(1, 1)
        end
        if aa('symbolSize', _d) ~= nil then
          dc:setSymbolSize(aa('symbolSize', _d))
        end
        if aa('symbolColor', _d) ~= nil then
          bb = colors[aa('symbolColor', _d)]
        end
        if aa('index', _d) ~= nil then
          dc:setIndex(aa('index', _d))
        end
      end,
      setIndex = function(dc, _d)
        _c = _d
        if _c < 1 then
          _c = 1
        end
        local ad, bd = dc:getSize()
        _c = math.min(_c, (_b == 'vertical' and bd or ad) - (ac - 1))
        dc:setValue(db / (_b == 'vertical' and bd or ad) * _c)
        dc:updateDraw()
        return dc
      end,
      getIndex = function(dc)
        return _c
      end,
      setSymbolSize = function(dc, _d)
        ac = tonumber(_d) or 1
        if _b == 'vertical' then
          dc:setValue(_c - 1 * (db / (h - (ac - 1))) - (db / (h - (ac - 1))))
        elseif _b == 'horizontal' then
          dc:setValue(_c - 1 * (db / (w - (ac - 1))) - (db / (w - (ac - 1))))
        end
        dc:updateDraw()
        return dc
      end,
      setMaxValue = function(dc, _d)
        db = _d
        return dc
      end,
      setBackgroundSymbol = function(dc, _d)
        cb = string.sub(_d, 1, 1)
        dc:updateDraw()
        return dc
      end,
      setSymbolColor = function(dc, _d)
        bb = _d
        dc:updateDraw()
        return dc
      end,
      setBarType = function(dc, _d)
        _b = _d:lower()
        dc:updateDraw()
        return dc
      end,
      mouseHandler = function(dc, _d, ad, bd)
        if ca.mouseHandler(dc, _d, ad, bd) then
          bc(dc, _d, ad, bd)
          return true
        end
        return false
      end,
      dragHandler = function(dc, _d, ad, bd)
        if ca.dragHandler(dc, _d, ad, bd) then
          bc(dc, _d, ad, bd)
          return true
        end
        return false
      end,
      scrollHandler = function(dc, _d, ad, bd)
        if ca.scrollHandler(dc, _d, ad, bd) then
          local cd, dd = dc:getSize()
          _c = _c + _d
          if _c < 1 then
            _c = 1
          end
          _c = math.min(_c, (_b == 'vertical' and dd or cd) - (ac - 1))
          dc:setValue(db / (_b == 'vertical' and dd or cd) * _c)
          dc:updateDraw()
          return true
        end
        return false
      end,
      draw = function(dc)
        if ca.draw(dc) then
          if dc.parent ~= nil then
            local _d, ad = dc:getAnchorPosition()
            local bd, cd = dc:getSize()
            if _b == 'horizontal' then
              dc.parent:writeText(_d, ad, cb:rep(_c - 1), dc.bgColor, dc.fgColor)
              dc.parent:writeText(_d + _c - 1, ad, ab:rep(ac), bb, bb)
              dc.parent:writeText(_d + _c + ac - 1, ad, cb:rep(bd - (_c + ac - 1)), dc.bgColor, dc.fgColor)
            end
            if _b == 'vertical' then
              for n = 0, cd - 1 do
                if _c == n + 1 then
                  for curIndexOffset = 0, math.min(ac - 1, cd) do
                    dc.parent:writeText(_d, ad + n + curIndexOffset, ab, bb, bb)
                  end
                else
                  if (n + 1 < _c) or (n + 1 > _c - 1 + ac) then
                    dc.parent:writeText(_d, ad + n, cb, dc.bgColor, dc.fgColor)
                  end
                end
              end
            end
          end
        end
      end,
      init = function(dc)
        dc.parent:addEvent('mouse_click', dc)
        dc.parent:addEvent('mouse_drag', dc)
        dc.parent:addEvent('mouse_scroll', dc)
        if ca.init(dc) then
          dc.bgColor = dc.parent:getTheme 'SliderBG'
          dc.fgColor = dc.parent:getTheme 'SliderText'
          bb = dc.parent:getTheme 'SliderSymbolColor'
        end
      end,
    }
    return setmetatable(cc, ca)
  end
end
project['objects']['Switch'] = function(...)
  local c = require 'Object'
  local d = require('utils').getValueFromXML
  return function(_a)
    local aa = c(_a)
    local ba = 'Switch'
    aa.width = 2
    aa.height = 1
    aa.bgColor = colors.lightGray
    aa.fgColor = colors.gray
    aa:setValue(false)
    aa:setZIndex(5)
    local ca = colors.black
    local da = colors.red
    local _b = colors.green
    local ab = {
      getType = function(bb)
        return ba
      end,
      setSymbolColor = function(bb, cb)
        ca = cb
        bb:updateDraw()
        return bb
      end,
      setActiveBackground = function(bb, cb)
        _b = cb
        bb:updateDraw()
        return bb
      end,
      setInactiveBackground = function(bb, cb)
        da = cb
        bb:updateDraw()
        return bb
      end,
      setValuesByXMLData = function(bb, cb)
        aa.setValuesByXMLData(bb, cb)
        if d('inactiveBG', cb) ~= nil then
          da = colors[d('inactiveBG', cb)]
        end
        if d('activeBG', cb) ~= nil then
          _b = colors[d('activeBG', cb)]
        end
        if d('symbolColor', cb) ~= nil then
          ca = colors[d('symbolColor', cb)]
        end
      end,
      mouseHandler = function(bb, cb, db, _c)
        if aa.mouseHandler(bb, cb, db, _c) then
          local ac, bc = bb:getAbsolutePosition(bb:getAnchorPosition())
          bb:setValue(not bb:getValue())
          bb:updateDraw()
          return true
        end
      end,
      draw = function(bb)
        if aa.draw(bb) then
          if bb.parent ~= nil then
            local cb, db = bb:getAnchorPosition()
            local _c, ac = bb:getSize()
            bb.parent:drawBackgroundBox(cb, db, _c, ac, bb.bgColor)
            if bb:getValue() then
              bb.parent:drawBackgroundBox(cb, db, 1, ac, _b)
              bb.parent:drawBackgroundBox(cb + 1, db, 1, ac, ca)
            else
              bb.parent:drawBackgroundBox(cb, db, 1, ac, ca)
              bb.parent:drawBackgroundBox(cb + 1, db, 1, ac, da)
            end
          end
        end
      end,
      init = function(bb)
        bb.parent:addEvent('mouse_click', bb)
        if aa.init(bb) then
          bb.bgColor = bb.parent:getTheme 'SwitchBG'
          bb.fgColor = bb.parent:getTheme 'SwitchText'
          ca = bb.parent:getTheme 'SwitchBGSymbol'
          da = bb.parent:getTheme 'SwitchInactive'
          _b = bb.parent:getTheme 'SwitchActive'
        end
      end,
    }
    return setmetatable(ab, aa)
  end
end
project['objects']['Textfield'] = function(...)
  local aa = require 'Object'
  local ba = require 'tHex'
  local ca = require 'basaltLogs'
  local da = require('utils').getValueFromXML
  local _b = string.rep
  return function(ab)
    local bb = aa(ab)
    local cb = 'Textfield'
    local db, _c, ac, bc = 1, 1, 1, 1
    local cc = { '' }
    local dc = { '' }
    local _d = { '' }
    local ad = {}
    local bd = {}
    bb.width = 30
    bb.height = 12
    bb:setZIndex(5)
    local function cd(b_a, c_a)
      local d_a = {}
      if b_a:len() > 0 then
        for _aa in string.gmatch(b_a, c_a) do
          local aaa, baa = string.find(b_a, _aa)
          if (aaa ~= nil) and (baa ~= nil) then
            table.insert(d_a, aaa)
            table.insert(d_a, baa)
            local caa = string.sub(b_a, 1, (aaa - 1))
            local daa = string.sub(b_a, baa + 1, b_a:len())
            b_a = caa .. (':'):rep(_aa:len()) .. daa
          end
        end
      end
      return d_a
    end
    local function dd(b_a, c_a)
      c_a = c_a or bc
      local d_a = ba[b_a.fgColor]:rep(_d[c_a]:len())
      local _aa = ba[b_a.bgColor]:rep(dc[c_a]:len())
      for aaa, baa in pairs(bd) do
        local caa = cd(cc[c_a], baa[1])
        if #caa > 0 then
          for x = 1, #caa / 2 do
            local daa = x * 2 - 1
            if baa[2] ~= nil then
              d_a = d_a:sub(1, caa[daa] - 1)
                .. ba[baa[2]]:rep(caa[daa + 1] - (caa[daa] - 1))
                .. d_a:sub(caa[daa + 1] + 1, d_a:len())
            end
            if baa[3] ~= nil then
              _aa = _aa:sub(1, caa[daa] - 1)
                .. ba[baa[3]]:rep(caa[daa + 1] - (caa[daa] - 1))
                .. _aa:sub(caa[daa + 1] + 1, _aa:len())
            end
          end
        end
      end
      for aaa, baa in pairs(ad) do
        for caa, daa in pairs(baa) do
          local _ba = cd(cc[c_a], daa)
          if #_ba > 0 then
            for x = 1, #_ba / 2 do
              local aba = x * 2 - 1
              d_a = d_a:sub(1, _ba[aba] - 1)
                .. ba[aaa]:rep(_ba[aba + 1] - (_ba[aba] - 1))
                .. d_a:sub(_ba[aba + 1] + 1, d_a:len())
            end
          end
        end
      end
      _d[c_a] = d_a
      dc[c_a] = _aa
      b_a:updateDraw()
    end
    local function __a(b_a)
      for n = 1, #cc do
        dd(b_a, n)
      end
    end
    local a_a = {
      getType = function(b_a)
        return cb
      end,
      setBackground = function(b_a, c_a)
        bb.setBackground(b_a, c_a)
        __a(b_a)
        return b_a
      end,
      setForeground = function(b_a, c_a)
        bb.setForeground(b_a, c_a)
        __a(b_a)
        return b_a
      end,
      setValuesByXMLData = function(b_a, c_a)
        bb.setValuesByXMLData(b_a, c_a)
        if c_a['lines'] ~= nil then
          local d_a = c_a['lines']['line']
          if d_a.properties ~= nil then
            d_a = { d_a }
          end
          for _aa, aaa in pairs(d_a) do
            b_a:addLine(aaa:value())
          end
        end
        if c_a['keywords'] ~= nil then
          for d_a, _aa in pairs(c_a['keywords']) do
            if colors[d_a] ~= nil then
              local aaa = _aa
              if aaa.properties ~= nil then
                aaa = { aaa }
              end
              local baa = {}
              for caa, daa in pairs(aaa) do
                local _ba = daa['keyword']
                if daa['keyword'].properties ~= nil then
                  _ba = { daa['keyword'] }
                end
                for aba, bba in pairs(_ba) do
                  table.insert(baa, bba:value())
                end
              end
              b_a:addKeywords(colors[d_a], baa)
            end
          end
        end
        if c_a['rules'] ~= nil then
          if c_a['rules']['rule'] ~= nil then
            local d_a = c_a['rules']['rule']
            if c_a['rules']['rule'].properties ~= nil then
              d_a = { c_a['rules']['rule'] }
            end
            for _aa, aaa in pairs(d_a) do
              if da('pattern', aaa) ~= nil then
                b_a:addRule(da('pattern', aaa), colors[da('fg', aaa)], colors[da('bg', aaa)])
              end
            end
          end
        end
      end,
      getLines = function(b_a)
        return cc
      end,
      getLine = function(b_a, c_a)
        return cc[c_a]
      end,
      editLine = function(b_a, c_a, d_a)
        cc[c_a] = d_a or cc[c_a]
        dd(b_a, c_a)
        b_a:updateDraw()
        return b_a
      end,
      clear = function(b_a)
        cc = { '' }
        dc = { '' }
        _d = { '' }
        db, _c, ac, bc = 1, 1, 1, 1
        b_a:updateDraw()
        return b_a
      end,
      addLine = function(b_a, c_a, d_a)
        if c_a ~= nil then
          if (#cc == 1) and (cc[1] == '') then
            cc[1] = c_a
            dc[1] = ba[b_a.bgColor]:rep(c_a:len())
            _d[1] = ba[b_a.fgColor]:rep(c_a:len())
            dd(b_a, 1)
            return b_a
          end
          if d_a ~= nil then
            table.insert(cc, d_a, c_a)
            table.insert(dc, d_a, ba[b_a.bgColor]:rep(c_a:len()))
            table.insert(_d, d_a, ba[b_a.fgColor]:rep(c_a:len()))
          else
            table.insert(cc, c_a)
            table.insert(dc, ba[b_a.bgColor]:rep(c_a:len()))
            table.insert(_d, ba[b_a.fgColor]:rep(c_a:len()))
          end
        end
        dd(b_a, d_a or #cc)
        b_a:updateDraw()
        return b_a
      end,
      addKeywords = function(b_a, c_a, d_a)
        if ad[c_a] == nil then
          ad[c_a] = {}
        end
        for _aa, aaa in pairs(d_a) do
          table.insert(ad[c_a], aaa)
        end
        b_a:updateDraw()
        return b_a
      end,
      addRule = function(b_a, c_a, d_a, _aa)
        table.insert(bd, { c_a, d_a, _aa })
        b_a:updateDraw()
        return b_a
      end,
      editRule = function(b_a, c_a, d_a, _aa)
        for aaa, baa in pairs(bd) do
          if baa[1] == c_a then
            bd[aaa][2] = d_a
            bd[aaa][3] = _aa
          end
        end
        b_a:updateDraw()
        return b_a
      end,
      removeRule = function(b_a, c_a)
        for d_a, _aa in pairs(bd) do
          if _aa[1] == c_a then
            table.remove(bd, d_a)
          end
        end
        b_a:updateDraw()
        return b_a
      end,
      setKeywords = function(b_a, c_a, d_a)
        ad[c_a] = d_a
        b_a:updateDraw()
        return b_a
      end,
      removeLine = function(b_a, c_a)
        table.remove(cc, c_a or #cc)
        if #cc <= 0 then
          table.insert(cc, '')
        end
        b_a:updateDraw()
        return b_a
      end,
      getTextCursor = function(b_a)
        return ac, bc
      end,
      getFocusHandler = function(b_a)
        bb.getFocusHandler(b_a)
        if b_a.parent ~= nil then
          local c_a, d_a = b_a:getAnchorPosition()
          if b_a.parent ~= nil then
            b_a.parent:setCursor(true, c_a + ac - _c, d_a + bc - db, b_a.fgColor)
          end
        end
      end,
      loseFocusHandler = function(b_a)
        bb.loseFocusHandler(b_a)
        if b_a.parent ~= nil then
          b_a.parent:setCursor(false)
        end
      end,
      keyHandler = function(b_a, c_a)
        if bb.keyHandler(b_a, event, c_a) then
          local d_a, _aa = b_a:getAnchorPosition()
          local aaa, baa = b_a:getSize()
          if c_a == keys.backspace then
            if cc[bc] == '' then
              if bc > 1 then
                table.remove(cc, bc)
                table.remove(_d, bc)
                table.remove(dc, bc)
                ac = cc[bc - 1]:len() + 1
                _c = ac - aaa + 1
                if _c < 1 then
                  _c = 1
                end
                bc = bc - 1
              end
            elseif ac <= 1 then
              if bc > 1 then
                ac = cc[bc - 1]:len() + 1
                _c = ac - aaa + 1
                if _c < 1 then
                  _c = 1
                end
                cc[bc - 1] = cc[bc - 1] .. cc[bc]
                _d[bc - 1] = _d[bc - 1] .. _d[bc]
                dc[bc - 1] = dc[bc - 1] .. dc[bc]
                table.remove(cc, bc)
                table.remove(_d, bc)
                table.remove(dc, bc)
                bc = bc - 1
              end
            else
              cc[bc] = cc[bc]:sub(1, ac - 2) .. cc[bc]:sub(ac, cc[bc]:len())
              _d[bc] = _d[bc]:sub(1, ac - 2) .. _d[bc]:sub(ac, _d[bc]:len())
              dc[bc] = dc[bc]:sub(1, ac - 2) .. dc[bc]:sub(ac, dc[bc]:len())
              if ac > 1 then
                ac = ac - 1
              end
              if _c > 1 then
                if ac < _c then
                  _c = _c - 1
                end
              end
            end
            if bc < db then
              db = db - 1
            end
            dd(b_a)
            b_a:setValue ''
          end
          if c_a == keys.delete then
            if ac > cc[bc]:len() then
              if cc[bc + 1] ~= nil then
                cc[bc] = cc[bc] .. cc[bc + 1]
                table.remove(cc, bc + 1)
                table.remove(dc, bc + 1)
                table.remove(_d, bc + 1)
              end
            else
              cc[bc] = cc[bc]:sub(1, ac - 1) .. cc[bc]:sub(ac + 1, cc[bc]:len())
              _d[bc] = _d[bc]:sub(1, ac - 1) .. _d[bc]:sub(ac + 1, _d[bc]:len())
              dc[bc] = dc[bc]:sub(1, ac - 1) .. dc[bc]:sub(ac + 1, dc[bc]:len())
            end
            dd(b_a)
          end
          if c_a == keys.enter then
            table.insert(cc, bc + 1, cc[bc]:sub(ac, cc[bc]:len()))
            table.insert(_d, bc + 1, _d[bc]:sub(ac, _d[bc]:len()))
            table.insert(dc, bc + 1, dc[bc]:sub(ac, dc[bc]:len()))
            cc[bc] = cc[bc]:sub(1, ac - 1)
            _d[bc] = _d[bc]:sub(1, ac - 1)
            dc[bc] = dc[bc]:sub(1, ac - 1)
            bc = bc + 1
            ac = 1
            _c = 1
            if bc - db >= baa then
              db = db + 1
            end
            b_a:setValue ''
          end
          if c_a == keys.up then
            if bc > 1 then
              bc = bc - 1
              if ac > cc[bc]:len() + 1 then
                ac = cc[bc]:len() + 1
              end
              if _c > 1 then
                if ac < _c then
                  _c = ac - aaa + 1
                  if _c < 1 then
                    _c = 1
                  end
                end
              end
              if db > 1 then
                if bc < db then
                  db = db - 1
                end
              end
            end
          end
          if c_a == keys.down then
            if bc < #cc then
              bc = bc + 1
              if ac > cc[bc]:len() + 1 then
                ac = cc[bc]:len() + 1
              end
              if _c > 1 then
                if ac < _c then
                  _c = ac - aaa + 1
                  if _c < 1 then
                    _c = 1
                  end
                end
              end
              if bc >= db + baa then
                db = db + 1
              end
            end
          end
          if c_a == keys.right then
            ac = ac + 1
            if bc < #cc then
              if ac > cc[bc]:len() + 1 then
                ac = 1
                bc = bc + 1
              end
            elseif ac > cc[bc]:len() then
              ac = cc[bc]:len() + 1
            end
            if ac < 1 then
              ac = 1
            end
            if (ac < _c) or (ac >= aaa + _c) then
              _c = ac - aaa + 1
            end
            if _c < 1 then
              _c = 1
            end
          end
          if c_a == keys.left then
            ac = ac - 1
            if ac >= 1 then
              if (ac < _c) or (ac >= aaa + _c) then
                _c = ac
              end
            end
            if bc > 1 then
              if ac < 1 then
                bc = bc - 1
                ac = cc[bc]:len() + 1
                _c = ac - aaa + 1
              end
            end
            if ac < 1 then
              ac = 1
            end
            if _c < 1 then
              _c = 1
            end
          end
          local caa = (ac <= cc[bc]:len() and ac - 1 or cc[bc]:len()) - (_c - 1)
          if caa > b_a.x + aaa - 1 then
            caa = b_a.x + aaa - 1
          end
          local daa = (bc - db < baa and bc - db or bc - db - 1)
          if caa < 1 then
            caa = 0
          end
          b_a.parent:setCursor(true, d_a + caa, _aa + daa, b_a.fgColor)
          b_a:updateDraw()
          return true
        end
      end,
      charHandler = function(b_a, c_a)
        if bb.charHandler(b_a, c_a) then
          local d_a, _aa = b_a:getAnchorPosition()
          local aaa, baa = b_a:getSize()
          cc[bc] = cc[bc]:sub(1, ac - 1) .. c_a .. cc[bc]:sub(ac, cc[bc]:len())
          _d[bc] = _d[bc]:sub(1, ac - 1) .. ba[b_a.fgColor] .. _d[bc]:sub(ac, _d[bc]:len())
          dc[bc] = dc[bc]:sub(1, ac - 1) .. ba[b_a.bgColor] .. dc[bc]:sub(ac, dc[bc]:len())
          ac = ac + 1
          if ac >= aaa + _c then
            _c = _c + 1
          end
          dd(b_a)
          b_a:setValue ''
          local caa = (ac <= cc[bc]:len() and ac - 1 or cc[bc]:len()) - (_c - 1)
          if caa > b_a.x + aaa - 1 then
            caa = b_a.x + aaa - 1
          end
          local daa = (bc - db < baa and bc - db or bc - db - 1)
          if caa < 1 then
            caa = 0
          end
          b_a.parent:setCursor(true, d_a + caa, _aa + daa, b_a.fgColor)
          b_a:updateDraw()
          return true
        end
      end,
      dragHandler = function(b_a, c_a, d_a, _aa)
        if bb.dragHandler(b_a, c_a, d_a, _aa) then
          local aaa, baa = b_a:getAbsolutePosition(b_a:getAnchorPosition())
          local caa, daa = b_a:getAnchorPosition()
          local _ba, aba = b_a:getSize()
          if cc[_aa - baa + db] ~= nil then
            if (caa + _ba > caa + d_a - (aaa + 1) + _c) and (caa < caa + d_a - aaa + _c) then
              ac = d_a - aaa + _c
              bc = _aa - baa + db
              if ac > cc[bc]:len() then
                ac = cc[bc]:len() + 1
              end
              if ac < _c then
                _c = ac - 1
                if _c < 1 then
                  _c = 1
                end
              end
              if b_a.parent ~= nil then
                b_a.parent:setCursor(true, caa + ac - _c, daa + bc - db, b_a.fgColor)
              end
              b_a:updateDraw()
            end
          end
          return true
        end
      end,
      scrollHandler = function(b_a, c_a, d_a, _aa)
        if bb.scrollHandler(b_a, c_a, d_a, _aa) then
          local aaa, baa = b_a:getAbsolutePosition(b_a:getAnchorPosition())
          local caa, daa = b_a:getAnchorPosition()
          local _ba, aba = b_a:getSize()
          db = db + c_a
          if db > #cc - (aba - 1) then
            db = #cc - (aba - 1)
          end
          if db < 1 then
            db = 1
          end
          if b_a.parent ~= nil then
            if

              (aaa + ac - _c >= aaa and aaa + ac - _c < aaa + _ba) and (baa + bc - db >= baa and baa + bc - db < baa + aba)
            then
              b_a.parent:setCursor(true, caa + ac - _c, daa + bc - db, b_a.fgColor)
            else
              b_a.parent:setCursor(false)
            end
          end
          b_a:updateDraw()
          return true
        end
      end,
      mouseHandler = function(b_a, c_a, d_a, _aa)
        if bb.mouseHandler(b_a, c_a, d_a, _aa) then
          local aaa, baa = b_a:getAbsolutePosition(b_a:getAnchorPosition())
          local caa, daa = b_a:getAnchorPosition()
          if cc[_aa - baa + db] ~= nil then
            ac = d_a - aaa + _c
            bc = _aa - baa + db
            if ac > cc[bc]:len() then
              ac = cc[bc]:len() + 1
            end
            if ac < _c then
              _c = ac - 1
              if _c < 1 then
                _c = 1
              end
            end
          end
          if b_a.parent ~= nil then
            b_a.parent:setCursor(true, caa + ac - _c, daa + bc - db, b_a.fgColor)
          end
          return true
        end
      end,
      eventHandler = function(b_a, c_a, d_a, _aa, aaa, baa)
        if bb.eventHandler(b_a, c_a, d_a, _aa, aaa, baa) then
          if c_a == 'paste' then
            if b_a:isFocused() then
              local caa, daa = b_a:getSize()
              cc[bc] = cc[bc]:sub(1, ac - 1) .. d_a .. cc[bc]:sub(ac, cc[bc]:len())
              _d[bc] = _d[bc]:sub(1, ac - 1) .. ba[b_a.fgColor]:rep(d_a:len()) .. _d[bc]:sub(ac, _d[bc]:len())
              dc[bc] = dc[bc]:sub(1, ac - 1) .. ba[b_a.bgColor]:rep(d_a:len()) .. dc[bc]:sub(ac, dc[bc]:len())
              ac = ac + d_a:len()
              if ac >= caa + _c then
                _c = (ac + 1) - caa
              end
              local _ba, aba = b_a:getAnchorPosition()
              b_a.parent:setCursor(true, _ba + ac - _c, aba + bc - db, b_a.fgColor)
              dd(b_a)
              b_a:updateDraw()
            end
          end
        end
      end,
      draw = function(b_a)
        if bb.draw(b_a) then
          if b_a.parent ~= nil then
            local c_a, d_a = b_a:getAnchorPosition()
            local _aa, aaa = b_a:getSize()
            for n = 1, aaa do
              local baa = ''
              local caa = ''
              local daa = ''
              if cc[n + db - 1] ~= nil then
                baa = cc[n + db - 1]
                daa = _d[n + db - 1]
                caa = dc[n + db - 1]
              end
              baa = baa:sub(_c, _aa + _c - 1)
              caa = caa:sub(_c, _aa + _c - 1)
              daa = daa:sub(_c, _aa + _c - 1)
              local _ba = _aa - baa:len()
              if _ba < 0 then
                _ba = 0
              end
              baa = baa .. _b(b_a.bgSymbol, _ba)
              caa = caa .. _b(ba[b_a.bgColor], _ba)
              daa = daa .. _b(ba[b_a.fgColor], _ba)
              b_a.parent:setText(c_a, d_a + n - 1, baa)
              b_a.parent:setBG(c_a, d_a + n - 1, caa)
              b_a.parent:setFG(c_a, d_a + n - 1, daa)
            end
            if b_a:isFocused() then
              local baa, caa = b_a:getAnchorPosition()
              b_a.parent:setCursor(true, baa + ac - _c, caa + bc - db, b_a.fgColor)
            end
          end
        end
      end,
      init = function(b_a)
        b_a.parent:addEvent('mouse_click', b_a)
        b_a.parent:addEvent('mouse_scroll', b_a)
        b_a.parent:addEvent('mouse_drag', b_a)
        b_a.parent:addEvent('key', b_a)
        b_a.parent:addEvent('char', b_a)
        b_a.parent:addEvent('other_event', b_a)
        if bb.init(b_a) then
          b_a.bgColor = b_a.parent:getTheme 'TextfieldBG'
          b_a.fgColor = b_a.parent:getTheme 'TextfieldText'
        end
      end,
    }
    return setmetatable(a_a, bb)
  end
end
project['objects']['Thread'] = function(...)
  local b = require('utils').getValueFromXML
  return function(c)
    local d
    local _a = 'Thread'
    local aa
    local ba
    local ca = false
    local da = function(_b, ab)
      if ab:sub(1, 1) == '#' then
        local bb = _b:getBaseFrame():getDeepObject(ab:sub(2, ab:len()))
        if (bb ~= nil) and (bb.internalObjetCall ~= nil) then
          return function()
            bb:internalObjetCall()
          end
        end
      else
        return _b:getBaseFrame():getVariable(ab)
      end
      return _b
    end
    d = {
      name = c,
      getType = function(_b)
        return _a
      end,
      getZIndex = function(_b)
        return 1
      end,
      getName = function(_b)
        return _b.name
      end,
      getBaseFrame = function(_b)
        if _b.parent ~= nil then
          return _b.parent:getBaseFrame()
        end
        return _b
      end,
      setValuesByXMLData = function(_b, ab)
        local bb
        if b('thread', ab) ~= nil then
          bb = da(_b, b('thread', ab))
        end
        if b('start', ab) ~= nil then
          if (b('start', ab)) and (bb ~= nil) then
            _b:start(bb)
          end
        end
        return _b
      end,
      start = function(_b, ab)
        if ab == nil then
          error 'Function provided to thread is nil'
        end
        aa = ab
        ba = coroutine.create(aa)
        ca = true
        local bb, cb = coroutine.resume(ba)
        if not bb then
          if cb ~= 'Terminated' then
            error('Thread Error Occurred - ' .. cb)
          end
        end
        _b.parent:addEvent('other_event', _b)
        return _b
      end,
      getStatus = function(_b, ab)
        if ba ~= nil then
          return coroutine.status(ba)
        end
        return nil
      end,
      stop = function(_b, ab)
        ca = false
        _b.parent:removeEvent('other_event', _b)
        return _b
      end,
      eventHandler = function(_b, ab, bb, cb, db)
        if ca then
          if coroutine.status(ba) ~= 'dead' then
            local _c, ac = coroutine.resume(ba, ab, bb, cb, db)
            if not _c then
              if ac ~= 'Terminated' then
                error('Thread Error Occurred - ' .. ac)
              end
            end
          else
            ca = false
          end
        end
      end,
    }
    d.__index = d
    return d
  end
end
project['objects']['Timer'] = function(...)
  local c = require 'basaltEvent'
  local d = require('utils').getValueFromXML
  return function(_a)
    local aa = 'Timer'
    local ba = 0
    local ca = 0
    local da = 0
    local _b
    local ab = c()
    local bb = false
    local cb = function(_c, ac, bc)
      local cc = function(dc)
        if dc:sub(1, 1) == '#' then
          local _d = _c:getBaseFrame():getDeepObject(dc:sub(2, dc:len()))
          if (_d ~= nil) and (_d.internalObjetCall ~= nil) then
            ac(_c, function()
              _d:internalObjetCall()
            end)
          end
        else
          ac(_c, _c:getBaseFrame():getVariable(dc))
        end
      end
      if type(bc) == 'string' then
        cc(bc)
      elseif type(bc) == 'table' then
        for dc, _d in pairs(bc) do
          cc(_d)
        end
      end
      return _c
    end
    local db = {
      name = _a,
      getType = function(_c)
        return aa
      end,
      setValuesByXMLData = function(_c, ac)
        if d('time', ac) ~= nil then
          ba = d('time', ac)
        end
        if d('repeat', ac) ~= nil then
          ca = d('repeat', ac)
        end
        if d('start', ac) ~= nil then
          if d('start', ac) then
            _c:start()
          end
        end
        if d('onCall', ac) ~= nil then
          cb(_c, _c.onCall, d('onCall', ac))
        end
        return _c
      end,
      getBaseFrame = function(_c)
        if _c.parent ~= nil then
          return _c.parent:getBaseFrame()
        end
        return _c
      end,
      getZIndex = function(_c)
        return 1
      end,
      getName = function(_c)
        return _c.name
      end,
      setTime = function(_c, ac, bc)
        ba = ac or 0
        ca = bc or 1
        return _c
      end,
      start = function(_c)
        if bb then
          os.cancelTimer(_b)
        end
        da = ca
        _b = os.startTimer(ba)
        bb = true
        _c.parent:addEvent('other_event', _c)
        return _c
      end,
      isActive = function(_c)
        return bb
      end,
      cancel = function(_c)
        if _b ~= nil then
          os.cancelTimer(_b)
        end
        bb = false
        _c.parent:removeEvent('other_event', _c)
        return _c
      end,
      onCall = function(_c, ac)
        ab:registerEvent('timed_event', ac)
        return _c
      end,
      eventHandler = function(_c, ac, bc)
        if ac == 'timer' and bc == _b and bb then
          ab:sendEvent('timed_event', _c)
          if da >= 1 then
            da = da - 1
            if da >= 1 then
              _b = os.startTimer(ba)
            end
          elseif da == -1 then
            _b = os.startTimer(ba)
          end
        end
      end,
    }
    db.__index = db
    return db
  end
end
project['libraries']['basaltDraw'] = function(...)
  local d = require 'tHex'
  local _a, aa = string.sub, string.rep
  return function(ba)
    local ca = ba or term.current()
    local da
    local _b, ab = ca.getSize()
    local bb = {}
    local cb = {}
    local db = {}
    local _c = {}
    local ac = {}
    local bc = {}
    local cc
    local dc = {}
    local function _d()
      cc = aa(' ', _b)
      for n = 0, 15 do
        local a_a = 2 ^ n
        local b_a = d[a_a]
        dc[a_a] = aa(b_a, _b)
      end
    end
    _d()
    local function ad()
      _d()
      local a_a = cc
      local b_a = dc[colors.white]
      local c_a = dc[colors.black]
      for currentY = 1, ab do
        bb[currentY] = _a(bb[currentY] == nil and a_a or bb[currentY] .. a_a:sub(1, _b - bb[currentY]:len()), 1, _b)
        db[currentY] = _a(db[currentY] == nil and b_a or db[currentY] .. b_a:sub(1, _b - db[currentY]:len()), 1, _b)
        cb[currentY] = _a(cb[currentY] == nil and c_a or cb[currentY] .. c_a:sub(1, _b - cb[currentY]:len()), 1, _b)
      end
    end
    ad()
    local function bd(a_a, b_a, c_a)
      if (b_a >= 1) and (b_a <= ab) then
        if (a_a + c_a:len() > 0) and (a_a <= _b) then
          local d_a = bb[b_a]
          local _aa
          local aaa = a_a + #c_a - 1
          if a_a < 1 then
            local baa = 1 - a_a + 1
            local caa = _b - a_a + 1
            c_a = _a(c_a, baa, caa)
          elseif aaa > _b then
            local baa = _b - a_a + 1
            c_a = _a(c_a, 1, baa)
          end
          if a_a > 1 then
            local baa = a_a - 1
            _aa = _a(d_a, 1, baa) .. c_a
          else
            _aa = c_a
          end
          if aaa < _b then
            _aa = _aa .. _a(d_a, aaa + 1, _b)
          end
          bb[b_a] = _aa
        end
      end
    end
    local function cd(a_a, b_a, c_a)
      if (b_a >= 1) and (b_a <= ab) then
        if (a_a + c_a:len() > 0) and (a_a <= _b) then
          local d_a = cb[b_a]
          local _aa
          local aaa = a_a + #c_a - 1
          if a_a < 1 then
            c_a = _a(c_a, 1 - a_a + 1, _b - a_a + 1)
          elseif aaa > _b then
            c_a = _a(c_a, 1, _b - a_a + 1)
          end
          if a_a > 1 then
            _aa = _a(d_a, 1, a_a - 1) .. c_a
          else
            _aa = c_a
          end
          if aaa < _b then
            _aa = _aa .. _a(d_a, aaa + 1, _b)
          end
          cb[b_a] = _aa
        end
      end
    end
    local function dd(a_a, b_a, c_a)
      if (b_a >= 1) and (b_a <= ab) then
        if (a_a + c_a:len() > 0) and (a_a <= _b) then
          local d_a = db[b_a]
          local _aa
          local aaa = a_a + #c_a - 1
          if a_a < 1 then
            local baa = 1 - a_a + 1
            local caa = _b - a_a + 1
            c_a = _a(c_a, baa, caa)
          elseif aaa > _b then
            local baa = _b - a_a + 1
            c_a = _a(c_a, 1, baa)
          end
          if a_a > 1 then
            local baa = a_a - 1
            _aa = _a(d_a, 1, baa) .. c_a
          else
            _aa = c_a
          end
          if aaa < _b then
            _aa = _aa .. _a(d_a, aaa + 1, _b)
          end
          db[b_a] = _aa
        end
      end
    end
    local __a = {
      setSize = function(a_a, b_a)
        _b, ab = a_a, b_a
        ad()
      end,
      setMirror = function(a_a)
        da = a_a
      end,
      setBG = function(a_a, b_a, c_a)
        cd(a_a, b_a, c_a)
      end,
      setText = function(a_a, b_a, c_a)
        bd(a_a, b_a, c_a)
      end,
      setFG = function(a_a, b_a, c_a)
        dd(a_a, b_a, c_a)
      end,
      drawBackgroundBox = function(a_a, b_a, c_a, d_a, _aa)
        for n = 1, d_a do
          cd(a_a, b_a + (n - 1), aa(d[_aa], c_a))
        end
      end,
      drawForegroundBox = function(a_a, b_a, c_a, d_a, _aa)
        for n = 1, d_a do
          dd(a_a, b_a + (n - 1), aa(d[_aa], c_a))
        end
      end,
      drawTextBox = function(a_a, b_a, c_a, d_a, _aa)
        for n = 1, d_a do
          bd(a_a, b_a + (n - 1), aa(_aa, c_a))
        end
      end,
      writeText = function(a_a, b_a, c_a, d_a, _aa)
        if c_a ~= nil then
          bd(a_a, b_a, c_a)
          if (d_a ~= nil) and (d_a ~= false) then
            cd(a_a, b_a, aa(d[d_a], c_a:len()))
          end
          if (_aa ~= nil) and (_aa ~= false) then
            dd(a_a, b_a, aa(d[_aa], c_a:len()))
          end
        end
      end,
      update = function()
        local a_a, b_a = ca.getCursorPos()
        local c_a = false
        if ca.getCursorBlink ~= nil then
          c_a = ca.getCursorBlink()
        end
        ca.setCursorBlink(false)
        if da ~= nil then
          da.setCursorBlink(false)
        end
        for n = 1, ab do
          ca.setCursorPos(1, n)
          ca.blit(bb[n], db[n], cb[n])
          if da ~= nil then
            da.setCursorPos(1, n)
            da.blit(bb[n], db[n], cb[n])
          end
        end
        ca.setBackgroundColor(colors.black)
        ca.setCursorBlink(c_a)
        ca.setCursorPos(a_a, b_a)
        if da ~= nil then
          da.setBackgroundColor(colors.black)
          da.setCursorBlink(c_a)
          da.setCursorPos(a_a, b_a)
        end
      end,
      setTerm = function(a_a)
        ca = a_a
      end,
    }
    return __a
  end
end
project['libraries']['basaltEvent'] = function(...)
  return function()
    local a = {}
    local b = {}
    local c = {
      registerEvent = function(d, _a, aa)
        if a[_a] == nil then
          a[_a] = {}
          b[_a] = 1
        end
        a[_a][b[_a]] = aa
        b[_a] = b[_a] + 1
        return b[_a] - 1
      end,
      removeEvent = function(d, _a, aa)
        a[_a][aa[_a]] = nil
      end,
      sendEvent = function(d, _a, ...)
        local aa
        if a[_a] ~= nil then
          for ba, ca in pairs(a[_a]) do
            local da = ca(...)
            if da == false then
              aa = da
            end
          end
        end
        return aa
      end,
    }
    c.__index = c
    return c
  end
end
project['libraries']['basaltLogs'] = function(...)
  local _a = ''
  local aa = 'basaltLog.txt'
  local ba = 'Debug'
  fs.delete(_a ~= '' and _a .. '/' .. aa or aa)
  local ca = {
    __call = function(da, _b, ab)
      if _b == nil then
        return
      end
      local bb = _a ~= '' and _a .. '/' .. aa or aa
      local cb = fs.open(bb, fs.exists(bb) and 'a' or 'w')
      cb.writeLine('[Basalt][' .. (ab and ab or ba) .. ']: ' .. tostring(_b))
      cb.close()
    end,
  }
  return setmetatable({}, ca)
end
project['libraries']['basaltMon'] = function(...)
  local aa = {
    [colors.white] = '0',
    [colors.orange] = '1',
    [colors.magenta] = '2',
    [colors.lightBlue] = '3',
    [colors.yellow] = '4',
    [colors.lime] = '5',
    [colors.pink] = '6',
    [colors.gray] = '7',
    [colors.lightGray] = '8',
    [colors.cyan] = '9',
    [colors.purple] = 'a',
    [colors.blue] = 'b',
    [colors.brown] = 'c',
    [colors.green] = 'd',
    [colors.red] = 'e',
    [colors.black] = 'f',
  }
  local ba, ca, da, _b = type, string.len, string.rep, string.sub
  return function(ab)
    local bb = {}
    for _aa, aaa in pairs(ab) do
      bb[_aa] = {}
      for baa, caa in pairs(aaa) do
        local daa = peripheral.wrap(caa)
        if daa == nil then
          error('Unable to find monitor ' .. caa)
        end
        bb[_aa][baa] = daa
        bb[_aa][baa].name = caa
      end
    end
    local cb, db, _c, ac, bc, cc, dc, _d = 1, 1, 1, 1, 0, 0, 0, 0
    local ad, bd = false, 1
    local cd, dd = colors.white, colors.black
    local function __a()
      local _aa, aaa = 0, 0
      for baa, caa in pairs(bb) do
        local daa, _ba = 0, 0
        for aba, bba in pairs(caa) do
          local cba, dba = bba.getSize()
          daa = daa + cba
          _ba = dba > _ba and dba or _ba
        end
        _aa = _aa > daa and _aa or daa
        aaa = aaa + _ba
      end
      dc, _d = _aa, aaa
    end
    __a()
    local function a_a()
      local _aa = 0
      local aaa, baa = 0, 0
      for caa, daa in pairs(bb) do
        local _ba = 0
        local aba = 0
        for bba, cba in pairs(daa) do
          local dba, _ca = cba.getSize()
          if (cb - _ba >= 1) and (cb - _ba <= dba) then
            aaa = bba
          end
          cba.setCursorPos(cb - _ba, db - _aa)
          _ba = _ba + dba
          if aba < _ca then
            aba = _ca
          end
        end
        if (db - _aa >= 1) and (db - _aa <= aba) then
          baa = caa
        end
        _aa = _aa + aba
      end
      _c, ac = aaa, baa
    end
    a_a()
    local function b_a(_aa, ...)
      local aaa = { ... }
      return function()
        for baa, caa in pairs(bb) do
          for daa, _ba in pairs(caa) do
            _ba[_aa](table.unpack(aaa))
          end
        end
      end
    end
    local function c_a()
      b_a('setCursorBlink', false)()
      if not ad then
        return
      end
      if bb[ac] == nil then
        return
      end
      local _aa = bb[ac][_c]
      if _aa == nil then
        return
      end
      _aa.setCursorBlink(ad)
    end
    local function d_a(_aa, aaa, baa)
      if bb[ac] == nil then
        return
      end
      local caa = bb[ac][_c]
      if caa == nil then
        return
      end
      caa.blit(_aa, aaa, baa)
      local daa, _ba = caa.getSize()
      if ca(_aa) + cb > daa then
        local aba = bb[ac][_c + 1]
        if aba ~= nil then
          aba.blit(_aa, aaa, baa)
          _c = _c + 1
          cb = cb + ca(_aa)
        end
      end
      a_a()
    end
    return {
      clear = b_a 'clear',
      setCursorBlink = function(_aa)
        ad = _aa
        c_a()
      end,
      getCursorBlink = function()
        return ad
      end,
      getCursorPos = function()
        return cb, db
      end,
      setCursorPos = function(_aa, aaa)
        cb, db = _aa, aaa
        a_a()
        c_a()
      end,
      setTextScale = function(_aa)
        b_a('setTextScale', _aa)()
        __a()
        a_a()
        bd = _aa
      end,
      getTextScale = function()
        return bd
      end,
      blit = function(_aa, aaa, baa)
        d_a(_aa, aaa, baa)
      end,
      write = function(_aa)
        _aa = tostring(_aa)
        local aaa = ca(_aa)
        d_a(_aa, da(aa[cd], aaa), da(aa[dd], aaa))
      end,
      getSize = function()
        return dc, _d
      end,
      setBackgroundColor = function(_aa)
        b_a('setBackgroundColor', _aa)()
        dd = _aa
      end,
      setTextColor = function(_aa)
        b_a('setTextColor', _aa)()
        cd = _aa
      end,
      calculateClick = function(_aa, aaa, baa)
        local caa = 0
        for daa, _ba in pairs(bb) do
          local aba = 0
          local bba = 0
          for cba, dba in pairs(_ba) do
            local _ca, aca = dba.getSize()
            if dba.name == _aa then
              return aaa + aba, baa + caa
            end
            aba = aba + _ca
            if aca > bba then
              bba = aca
            end
          end
          caa = caa + bba
        end
        return aaa, baa
      end,
    }
  end
end
project['libraries']['bigfont'] = function(...)
  local ba = require 'tHex'
  local ca = {
    {
      '\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147',
      '\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132',
      '\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131',
      '\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132',
      '\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32',
      '\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32',
      '\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129',
      '\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32',
      '\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32',
      '\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148',
      '\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32',
      '\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32',
      '\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148',
      '\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149',
      '\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32',
      '\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32',
      '\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32',
      '\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132',
      '\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32',
      '\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149',
      '\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32',
      '\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148',
      '\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32',
      '\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32',
      '\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32',
      '\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32',
      '\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32',
      '\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32',
      '\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32',
      '\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32',
      '\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129',
      '\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32',
      '\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32',
      '\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32',
      '\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148',
      '\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32',
      '\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32',
      '\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32',
      '\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32',
      '\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132',
      '\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149',
      '\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32',
      '\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32',
      '\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32',
      '\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32',
      '\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144',
      '\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149',
      '\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129',
    },
    {
      '000110000110110000110010101000000010000000100101',
      '000000110110000000000010101000000010000000100101',
      '000000000000000000000000000000000000000000000000',
      '100010110100000010000110110000010100000100000110',
      '000000110000000010110110000110000000000000110000',
      '000000000000000000000000000000000000000000000000',
      '000000110110000010000000100000100000000000000010',
      '000000000110110100010000000010000000000000000100',
      '000000000000000000000000000000000000000000000000',
      '010000000000100110000000000000000000000110010000',
      '000000000000000000000000000010000000010110000000',
      '000000000000000000000000000000000000000000000000',
      '011110110000000100100010110000000100000000000000',
      '000000000000000000000000000000000000000000000000',
      '000000000000000000000000000000000000000000000000',
      '110000110110000000000000000000010100100010000000',
      '000010000000000000110110000000000100010010000000',
      '000000000000000000000000000000000000000000000000',
      '010110010110100110110110010000000100000110110110',
      '000000000000000000000110000000000110000000000000',
      '000000000000000000000000000000000000000000000000',
      '010100010110110000000000000000110000000010000000',
      '110110000000000000110000110110100000000010000000',
      '000000000000000000000000000000000000000000000000',
      '000100011111000100011111000100011111000100011111',
      '000000000000100100100100011011011011111111111111',
      '000000000000000000000000000000000000000000000000',
      '000100011111000100011111000100011111000100011111',
      '000000000000100100100100011011011011111111111111',
      '100100100100100100100100100100100100100100100100',
      '000000110100110110000010000011110000000000011000',
      '000000000100000000000010000011000110000000001000',
      '000000000000000000000000000000000000000000000000',
      '010000100100000000000000000100000000010010110000',
      '000000000000000000000000000000110110110110110000',
      '000000000000000000000000000000000000000000000000',
      '110110110110110110000000110110110110110110110110',
      '000000000000000000000110000000000000000000000000',
      '000000000000000000000000000000000000000000000000',
      '000000000000110110000110010000000000000000010010',
      '000010000000000000000000000000000000000000000000',
      '000000000000000000000000000000000000000000000000',
      '110110110110110110110000110110110110000000000000',
      '000000000000000000000110000000000000000000000000',
      '000000000000000000000000000000000000000000000000',
      '110110110110110110110000110000000000000000010000',
      '000000000000000000000000100000000000000110000110',
      '000000000000000000000000000000000000000000000000',
    },
  }
  local da = {}
  local _b = {}
  do
    local cb = 0
    local db = #ca[1]
    local _c = #ca[1][1]
    for i = 1, db, 3 do
      for j = 1, _c, 3 do
        local ac = string.char(cb)
        local bc = {}
        bc[1] = ca[1][i]:sub(j, j + 2)
        bc[2] = ca[1][i + 1]:sub(j, j + 2)
        bc[3] = ca[1][i + 2]:sub(j, j + 2)
        local cc = {}
        cc[1] = ca[2][i]:sub(j, j + 2)
        cc[2] = ca[2][i + 1]:sub(j, j + 2)
        cc[3] = ca[2][i + 2]:sub(j, j + 2)
        _b[ac] = { bc, cc }
        cb = cb + 1
      end
    end
    da[1] = _b
  end
  local function ab(cb, db)
    local _c = { ['0'] = '1', ['1'] = '0' }
    if cb <= #da then
      return true
    end
    for f = #da + 1, cb do
      local ac = {}
      local bc = da[f - 1]
      for char = 0, 255 do
        local cc = string.char(char)
        local dc = {}
        local _d = {}
        local ad = bc[cc][1]
        local bd = bc[cc][2]
        for i = 1, #ad do
          local cd, dd, __a, a_a, b_a, c_a = {}, {}, {}, {}, {}, {}
          for j = 1, #ad[1] do
            local d_a = _b[ad[i]:sub(j, j)][1]
            table.insert(cd, d_a[1])
            table.insert(dd, d_a[2])
            table.insert(__a, d_a[3])
            local _aa = _b[ad[i]:sub(j, j)][2]
            if bd[i]:sub(j, j) == '1' then
              table.insert(a_a, (_aa[1]:gsub('[01]', _c)))
              table.insert(b_a, (_aa[2]:gsub('[01]', _c)))
              table.insert(c_a, (_aa[3]:gsub('[01]', _c)))
            else
              table.insert(a_a, _aa[1])
              table.insert(b_a, _aa[2])
              table.insert(c_a, _aa[3])
            end
          end
          table.insert(dc, table.concat(cd))
          table.insert(dc, table.concat(dd))
          table.insert(dc, table.concat(__a))
          table.insert(_d, table.concat(a_a))
          table.insert(_d, table.concat(b_a))
          table.insert(_d, table.concat(c_a))
        end
        ac[cc] = { dc, _d }
        if db then
          db = 'Font' .. f .. 'Yeld' .. char
          os.queueEvent(db)
          os.pullEvent(db)
        end
      end
      da[f] = ac
    end
    return true
  end
  local function bb(cb, db, _c, ac, bc)
    if not type(db) == 'string' then
      error('Not a String', 3)
    end
    local cc = type(_c) == 'string' and _c:sub(1, 1) or ba[_c] or error('Wrong Front Color', 3)
    local dc = type(ac) == 'string' and ac:sub(1, 1) or ba[ac] or error('Wrong Back Color', 3)
    if da[cb] == nil then
      ab(3, false)
    end
    local _d = da[cb] or error('Wrong font size selected', 3)
    if db == '' then
      return { { '' }, { '' }, { '' } }
    end
    local ad = {}
    for c_a in db:gmatch '.' do
      table.insert(ad, c_a)
    end
    local bd = {}
    local cd = #_d[ad[1]][1]
    for nLine = 1, cd do
      local c_a = {}
      for i = 1, #ad do
        c_a[i] = _d[ad[i]] and _d[ad[i]][1][nLine] or ''
      end
      bd[nLine] = table.concat(c_a)
    end
    local dd = {}
    local __a = {}
    local a_a = { ['0'] = cc, ['1'] = dc }
    local b_a = { ['0'] = dc, ['1'] = cc }
    for nLine = 1, cd do
      local c_a = {}
      local d_a = {}
      for i = 1, #ad do
        local _aa = _d[ad[i]] and _d[ad[i]][2][nLine] or ''
        c_a[i] = _aa:gsub('[01]', bc and { ['0'] = _c:sub(i, i), ['1'] = ac:sub(i, i) } or a_a)
        d_a[i] = _aa:gsub('[01]', bc and { ['0'] = ac:sub(i, i), ['1'] = _c:sub(i, i) } or b_a)
      end
      dd[nLine] = table.concat(c_a)
      __a[nLine] = table.concat(d_a)
    end
    return { bd, dd, __a }
  end
  return bb
end
project['libraries']['layout'] = function(...)
  local function c(_a)
    local aa = {}
    aa.___value = nil
    aa.___name = _a
    aa.___children = {}
    aa.___props = {}
    function aa:value()
      return self.___value
    end
    function aa:setValue(ba)
      self.___value = ba
    end
    function aa:name()
      return self.___name
    end
    function aa:setName(ba)
      self.___name = ba
    end
    function aa:children()
      return self.___children
    end
    function aa:numChildren()
      return #self.___children
    end
    function aa:addChild(ba)
      if self[ba:name()] ~= nil then
        if type(self[ba:name()].name) == 'function' then
          local ca = {}
          table.insert(ca, self[ba:name()])
          self[ba:name()] = ca
        end
        table.insert(self[ba:name()], ba)
      else
        self[ba:name()] = ba
      end
      table.insert(self.___children, ba)
    end
    function aa:properties()
      return self.___props
    end
    function aa:numProperties()
      return #self.___props
    end
    function aa:addProperty(ba, ca)
      local da = '@' .. ba
      if self[da] ~= nil then
        if type(self[da]) == 'string' then
          local _b = {}
          table.insert(_b, self[da])
          self[da] = _b
        end
        table.insert(self[da], ca)
      else
        self[da] = ca
      end
      table.insert(self.___props, { name = ba, value = self[ba] })
    end
    return aa
  end
  local d = {}
  function d:ToXmlString(_a)
    _a = string.gsub(_a, '&', '&amp;')
    _a = string.gsub(_a, '<', '&lt;')
    _a = string.gsub(_a, '>', '&gt;')
    _a = string.gsub(_a, '"', '&quot;')
    _a = string.gsub(_a, '([^%w%&%;%p%\t% ])', function(aa)
      return string.format('&#x%X;', string.byte(aa))
    end)
    return _a
  end
  function d:FromXmlString(_a)
    _a = string.gsub(_a, '&#x([%x]+)%;', function(aa)
      return string.char(tonumber(aa, 16))
    end)
    _a = string.gsub(_a, '&#([0-9]+)%;', function(aa)
      return string.char(tonumber(aa, 10))
    end)
    _a = string.gsub(_a, '&quot;', '"')
    _a = string.gsub(_a, '&apos;', '\'')
    _a = string.gsub(_a, '&gt;', '>')
    _a = string.gsub(_a, '&lt;', '<')
    _a = string.gsub(_a, '&amp;', '&')
    return _a
  end
  function d:ParseArgs(_a, aa)
    string.gsub(aa, '(%w+)=(["\'])(.-)%2', function(ba, ca, da)
      _a:addProperty(ba, self:FromXmlString(da))
    end)
  end
  function d:ParseXmlText(_a)
    local aa = {}
    local ba = c()
    table.insert(aa, ba)
    local ca, da, _b, ab, bb
    local cb, db = 1, 1
    while true do
      ca, db, da, _b, ab, bb = string.find(_a, '<(%/?)([%w_:]+)(.-)(%/?)>', cb)
      if not ca then
        break
      end
      local ac = string.sub(_a, cb, ca - 1)
      if not string.find(ac, '^%s*$') then
        local bc = (ba:value() or '') .. self:FromXmlString(ac)
        aa[#aa]:setValue(bc)
      end
      if bb == '/' then
        local bc = c(_b)
        self:ParseArgs(bc, ab)
        ba:addChild(bc)
      elseif da == '' then
        local bc = c(_b)
        self:ParseArgs(bc, ab)
        table.insert(aa, bc)
        ba = bc
      else
        local bc = table.remove(aa)
        ba = aa[#aa]
        if #aa < 1 then
          error('XmlParser: nothing to close with ' .. _b)
        end
        if bc:name() ~= _b then
          error('XmlParser: trying to close ' .. bc.name .. ' with ' .. _b)
        end
        ba:addChild(bc)
      end
      cb = db + 1
    end
    local _c = string.sub(_a, cb)
    if #aa > 1 then
      error('XmlParser: unclosed ' .. aa[#aa]:name())
    end
    return ba
  end
  function d:loadFile(_a, aa)
    if not aa then
      aa = system.ResourceDirectory
    end
    local ba = system.pathForFile(_a, aa)
    local ca, da = io.open(ba, 'r')
    if ca and not da then
      local _b = ca:read '*a'
      io.close(ca)
      return self:ParseXmlText(_b), nil
    else
      print(da)
      return nil
    end
  end
  return d
end
project['libraries']['module'] = function(...)
  return function(a)
    local b, c = pcall(require, a)
    return b and c or nil
  end
end
project['libraries']['process'] = function(...)
  local d = {}
  local _a = {}
  local aa = 0
  function _a:new(ba, ca, ...)
    local da = { ... }
    local _b = setmetatable({ path = ba }, { __index = self })
    _b.window = ca
    _b.processId = aa
    if type(ba) == 'string' then
      _b.coroutine = coroutine.create(function()
        shell.run(ba)
      end)
    elseif type(ba) == 'function' then
      _b.coroutine = coroutine.create(function()
        ba(table.unpack(da))
      end)
    else
      return
    end
    d[aa] = _b
    aa = aa + 1
    return _b
  end
  function _a:resume(ba, ...)
    term.redirect(self.window)
    if self.filter ~= nil then
      if ba ~= self.filter then
        return
      end
      self.filter = nil
    end
    local ca, da = coroutine.resume(self.coroutine, ba, ...)
    if ca then
      self.filter = da
    else
      error(da)
    end
  end
  function _a:isDead()
    if self.coroutine ~= nil then
      if coroutine.status(self.coroutine) == 'dead' then
        table.remove(d, self.processId)
        return true
      end
    else
      return true
    end
    return false
  end
  function _a:getStatus()
    if self.coroutine ~= nil then
      return coroutine.status(self.coroutine)
    end
    return nil
  end
  function _a:start()
    coroutine.resume(self.coroutine)
  end
  return _a
end
project['libraries']['tHex'] = function(...)
  return {
    [colors.white] = '0',
    [colors.orange] = '1',
    [colors.magenta] = '2',
    [colors.lightBlue] = '3',
    [colors.yellow] = '4',
    [colors.lime] = '5',
    [colors.pink] = '6',
    [colors.gray] = '7',
    [colors.lightGray] = '8',
    [colors.cyan] = '9',
    [colors.purple] = 'a',
    [colors.blue] = 'b',
    [colors.brown] = 'c',
    [colors.green] = 'd',
    [colors.red] = 'e',
    [colors.black] = 'f',
  }
end
project['libraries']['utils'] = function(...)
  local b = function(c, d)
    if d == nil then
      d = '%s'
    end
    local _a = {}
    for aa in string.gmatch(c, '([^' .. d .. ']+)') do
      table.insert(_a, aa)
    end
    return _a
  end
  return {
    getTextHorizontalAlign = function(c, d, _a, aa)
      c = string.sub(c, 1, d)
      local ba = d - string.len(c)
      if _a == 'right' then
        c = string.rep(aa or ' ', ba) .. c
      elseif _a == 'center' then
        c = string.rep(aa or ' ', math.floor(ba / 2)) .. c .. string.rep(aa or ' ', math.floor(ba / 2))
        c = c .. (string.len(c) < d and (aa or ' ') or '')
      else
        c = c .. string.rep(aa or ' ', ba)
      end
      return c
    end,
    getTextVerticalAlign = function(c, d)
      local _a = 0
      if d == 'center' then
        _a = math.ceil(c / 2)
        if _a < 1 then
          _a = 1
        end
      end
      if d == 'bottom' then
        _a = c
      end
      if _a < 1 then
        _a = 1
      end
      return _a
    end,
    rpairs = function(c)
      return function(d, _a)
        _a = _a - 1
        if _a ~= 0 then
          return _a, d[_a]
        end
      end,
        c,
        #c + 1
    end,
    tableCount = function(c)
      local d = 0
      if c ~= nil then
        for _a, aa in pairs(c) do
          d = d + 1
        end
      end
      return d
    end,
    splitString = b,
    createText = function(c, d)
      local _a = b(c, '\n')
      local aa = {}
      for ba, ca in pairs(_a) do
        local da = ''
        local _b = b(ca, ' ')
        for ab, bb in pairs(_b) do
          if #da + #bb <= d then
            da = da == '' and bb or da .. ' ' .. bb
            if ab == #_b then
              table.insert(aa, da)
            end
          else
            table.insert(aa, da)
            da = bb:sub(1, d)
            if ab == #_b then
              table.insert(aa, da)
            end
          end
        end
      end
      return aa
    end,
    getValueFromXML = function(c, d)
      local _a
      if type(d) ~= 'table' then
        return
      end
      if d[c] ~= nil then
        if type(d[c]) == 'table' then
          if d[c].value ~= nil then
            _a = d[c]:value()
          end
        end
      end
      if _a == nil then
        _a = d['@' .. c]
      end
      if _a == 'true' then
        _a = true
      elseif _a == 'false' then
        _a = false
      elseif tonumber(_a) ~= nil then
        _a = tonumber(_a)
      end
      return _a
    end,
    numberFromString = function(c)
      return load('return ' .. c)()
    end,
    uuid = function()
      local c = math.random
      local function d()
        local _a = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
        return string.gsub(_a, '[xy]', function(aa)
          local ba = (aa == 'x') and c(0, 0xf) or c(8, 0xb)
          return string.format('%x', ba)
        end)
      end
      return d()
    end,
  }
end
project['default']['Frame'] = function(...)
  local _c = require 'module'
  local ac = require 'Object'
  local bc = require 'loadObjects'
  local cc = require 'basaltDraw'
  local dc = require 'utils'
  local _d = _c 'layout'
  local ad = _c 'basaltMon'
  local bd = dc.uuid
  local cd = dc.rpairs
  local dd = dc.getValueFromXML
  local __a = dc.tableCount
  local a_a, b_a, c_a = string.sub, math.min, math.max
  return function(d_a, _aa, aaa, baa)
    local caa = ac(d_a)
    local daa = 'Frame'
    local _ba = {}
    local aba = {}
    local bba = {}
    local cba = {}
    local dba = {}
    local _ca = {}
    local aca = {}
    local bca = {}
    local cca = 0
    local dca = aaa or term.current()
    local _da = ''
    local ada = false
    local bda = false
    local cda = false
    local dda = 0
    local __b = 0
    local a_b = false
    local b_b = 0
    local c_b = false
    local d_b = false
    local _ab = ''
    local aab = false
    local bab = false
    local cab
    local dab
    local _bb = true
    local abb = true
    local bbb = false
    local cbb = {}
    caa:setZIndex(10)
    local dbb = cc(dca)
    local _cb = false
    local acb = 1
    local bcb = 1
    local ccb = colors.white
    local dcb, _db = 0, 0
    local adb = {}
    local function bdb(dbc, _cc)
      if _cc ~= nil then
        _cc:setValuesByXMLData(dbc)
      end
    end
    local function cdb(dbc, _cc, acc)
      if dbc ~= nil then
        if dbc.properties ~= nil then
          dbc = { dbc }
        end
        for bcc, ccc in pairs(dbc) do
          local dcc = _cc(acc, ccc['@id'] or bd())
          table.insert(adb, dcc)
          bdb(ccc, dcc)
        end
      end
    end
    local function ddb(dbc)
      for _cc, acc in pairs(_ba) do
        for bcc, ccc in pairs(acc) do
          if ccc:getName() == dbc then
            return ccc
          end
        end
      end
    end
    local function __c(dbc)
      local _cc = ddb(dbc)
      if _cc ~= nil then
        return _cc
      end
      for acc, bcc in pairs(_ba) do
        for ccc, dcc in pairs(bcc) do
          if dcc:getType() == 'Frame' then
            local _dc = dcc:getDeepObject(dbc)
            if _dc ~= nil then
              return _dc
            end
          end
        end
      end
    end
    local function a_c(dbc)
      local _cc = dbc:getZIndex()
      if ddb(dbc.name) ~= nil then
        return nil
      end
      if _ba[_cc] == nil then
        for x = 1, #aba + 1 do
          if aba[x] ~= nil then
            if _cc == aba[x] then
              break
            end
            if _cc > aba[x] then
              table.insert(aba, x, _cc)
              break
            end
          else
            table.insert(aba, _cc)
          end
        end
        if #aba <= 0 then
          table.insert(aba, _cc)
        end
        _ba[_cc] = {}
      end
      dbc.parent = bba
      if dbc.init ~= nil then
        dbc:init()
      end
      table.insert(_ba[_cc], dbc)
      return dbc
    end
    local function b_c(dbc, _cc)
      for acc, bcc in pairs(cba) do
        for ccc, dcc in pairs(bcc) do
          for _dc, adc in pairs(dcc) do
            if adc == _cc then
              table.remove(cba[acc][ccc], _dc)
              if dbc.parent ~= nil then
                if __a(cba[acc]) <= 0 then
                  dbc.parent:removeEvent(acc, dbc)
                end
              end
            end
          end
        end
      end
    end
    local function c_c(dbc, _cc)
      for acc, bcc in pairs(_ba) do
        for ccc, dcc in pairs(bcc) do
          if type(_cc) == 'string' then
            if dcc:getName() == _cc then
              table.remove(_ba[acc], ccc)
              b_c(bba, dcc)
              dbc:updateDraw()
              return true
            end
          else
            if dcc == _cc then
              table.remove(_ba[acc], ccc)
              b_c(bba, dcc)
              dbc:updateDraw()
              return true
            end
          end
        end
      end
      return false
    end
    local function d_c(dbc, _cc, acc)
      for bcc, ccc in pairs(cba[_cc]) do
        for dcc, _dc in pairs(ccc) do
          if _dc:getName() == acc then
            return _dc
          end
        end
      end
    end
    local function _ac(dbc, _cc, acc)
      local bcc = acc:getZIndex()
      if cba[_cc] == nil then
        cba[_cc] = {}
      end
      if dba[_cc] == nil then
        dba[_cc] = {}
      end
      if d_c(dbc, _cc, acc.name) ~= nil then
        return nil
      end
      if dbc.parent ~= nil then
        dbc.parent:addEvent(_cc, dbc)
      end
      cbb[_cc] = true
      if cba[_cc][bcc] == nil then
        for x = 1, #dba[_cc] + 1 do
          if dba[_cc][x] ~= nil then
            if bcc == dba[_cc][x] then
              break
            end
            if bcc > dba[_cc][x] then
              table.insert(dba[_cc], x, bcc)
              break
            end
          else
            table.insert(dba[_cc], bcc)
          end
        end
        if #dba[_cc] <= 0 then
          table.insert(dba[_cc], bcc)
        end
        cba[_cc][bcc] = {}
      end
      table.insert(cba[_cc][bcc], acc)
      return acc
    end
    local function aac(dbc, _cc, acc)
      if cba[_cc] ~= nil then
        for bcc, ccc in pairs(cba[_cc]) do
          for dcc, _dc in pairs(ccc) do
            if _dc == acc then
              table.remove(cba[_cc][bcc], dcc)
              if #cba[_cc][bcc] <= 0 then
                cba[_cc][bcc] = nil
                if dbc.parent ~= nil then
                  if __a(cba[_cc]) <= 0 then
                    cbb[_cc] = false
                    dbc.parent:removeEvent(_cc, dbc)
                  end
                end
              end
              return true
            end
          end
        end
      end
      return false
    end
    local function bac(dbc)
      local _cc, acc = pcall(load('return ' .. dbc))
      if not _cc then
        error(dbc .. ' is not a valid dynamic code')
      end
      return load('return ' .. dbc)()
    end
    local function cac(dbc, _cc, acc)
      for bcc, ccc in pairs(bca) do
        if (ccc[2] == acc) and (ccc[4] == _cc) then
          return ccc
        end
      end
      cca = cca + 1
      bca[cca] = { 0, acc, {}, _cc, cca }
      return bca[cca]
    end
    local function dac(dbc, _cc)
      local acc = {}
      local bcc = {}
      for ccc in _cc:gmatch '%a+%.x' do
        local dcc = ccc:gsub('%.x', '')
        if (dcc ~= 'self') and (dcc ~= 'parent') then
          table.insert(acc, dcc)
        end
      end
      for ccc in _cc:gmatch '%w+%.y' do
        local dcc = ccc:gsub('%.y', '')
        if (dcc ~= 'self') and (dcc ~= 'parent') then
          table.insert(acc, dcc)
        end
      end
      for ccc in _cc:gmatch '%a+%.w' do
        local dcc = ccc:gsub('%.w', '')
        if (dcc ~= 'self') and (dcc ~= 'parent') then
          table.insert(acc, dcc)
        end
      end
      for ccc in _cc:gmatch '%a+%.h' do
        local dcc = ccc:gsub('%.h', '')
        if (dcc ~= 'self') and (dcc ~= 'parent') then
          table.insert(acc, dcc)
        end
      end
      for ccc, dcc in pairs(acc) do
        bcc[dcc] = ddb(dcc)
        if bcc[dcc] == nil then
          error('Dynamic Values - unable to find object ' .. dcc)
        end
      end
      bcc['self'] = dbc
      bcc['parent'] = dbc:getParent()
      return bcc
    end
    local function _bc(dbc, _cc)
      local acc = dbc
      for bcc in dbc:gmatch '%w+%.x' do
        acc = acc:gsub(bcc, _cc[bcc:gsub('%.x', '')]:getX())
      end
      for bcc in dbc:gmatch '%w+%.y' do
        acc = acc:gsub(bcc, _cc[bcc:gsub('%.y', '')]:getY())
      end
      for bcc in dbc:gmatch '%w+%.w' do
        acc = acc:gsub(bcc, _cc[bcc:gsub('%.w', '')]:getWidth())
      end
      for bcc in dbc:gmatch '%w+%.h' do
        acc = acc:gsub(bcc, _cc[bcc:gsub('%.h', '')]:getHeight())
      end
      return acc
    end
    local function abc(dbc)
      if #bca > 0 then
        for n = 1, cca do
          if bca[n] ~= nil then
            local _cc
            if #bca[n][3] <= 0 then
              bca[n][3] = dac(bca[n][4], bca[n][2])
            end
            _cc = _bc(bca[n][2], bca[n][3])
            bca[n][1] = bac(_cc)
            if bca[n][4]:getType() == 'Frame' then
              bca[n][4]:recalculateDynamicValues()
            end
          end
        end
        for _cc, acc in pairs(aba) do
          if _ba[acc] ~= nil then
            for bcc, ccc in pairs(_ba[acc]) do
              if ccc.eventHandler ~= nil then
                ccc:eventHandler('dynamicValueEvent', dbc)
              end
            end
          end
        end
      end
    end
    local function bbc(dbc)
      return bca[dbc][1]
    end
    local function cbc(dbc)
      for _cc, acc in pairs(_ba) do
        for bcc, ccc in pairs(acc) do
          if (ccc.getHeight ~= nil) and (ccc.getY ~= nil) then
            local dcc, _dc = ccc:getHeight(), ccc:getY()
            if dcc + _dc - dbc:getHeight() > b_b then
              b_b = c_a(dcc + _dc - dbc:getHeight(), 0)
            end
          end
        end
      end
    end
    bba = {
      barActive = false,
      barBackground = colors.gray,
      barTextcolor = colors.black,
      barText = 'New Frame',
      barTextAlign = 'left',
      addEvent = _ac,
      removeEvent = aac,
      removeEvents = b_c,
      getEvent = d_c,
      newDynamicValue = cac,
      recalculateDynamicValues = abc,
      getDynamicValue = bbc,
      getType = function(dbc)
        return daa
      end,
      setFocusedObject = function(dbc, _cc)
        if dab ~= _cc then
          if dab ~= nil then
            dab:loseFocusHandler()
          end
          if _cc ~= nil then
            _cc:getFocusHandler()
          end
          dab = _cc
        end
        return dbc
      end,
      getVariable = function(dbc, _cc)
        return baa.getVariable(_cc)
      end,
      setSize = function(dbc, _cc, acc, bcc)
        caa.setSize(dbc, _cc, acc, bcc)
        if dbc.parent == nil then
          dbb = cc(dca)
        end
        for ccc, dcc in pairs(aba) do
          if _ba[dcc] ~= nil then
            for _dc, adc in pairs(_ba[dcc]) do
              if adc.eventHandler ~= nil then
                adc:eventHandler('basalt_resize', adc, dbc)
              end
            end
          end
        end
        dbc:recalculateDynamicValues()
        _bb = false
        return dbc
      end,
      setTheme = function(dbc, _cc, acc)
        if type(_cc) == 'table' then
          aca = _cc
        elseif type(_cc) == 'string' then
          aca[_cc] = acc
        end
        dbc:updateDraw()
        return dbc
      end,
      getTheme = function(dbc, _cc)
        return aca[_cc] or (dbc.parent ~= nil and dbc.parent:getTheme(_cc) or baa.getTheme(_cc))
      end,
      setPosition = function(dbc, _cc, acc, bcc)
        caa.setPosition(dbc, _cc, acc, bcc)
        for ccc, dcc in pairs(aba) do
          if _ba[dcc] ~= nil then
            for _dc, adc in pairs(_ba[dcc]) do
              if adc.eventHandler ~= nil then
                adc:eventHandler('basalt_reposition', adc, dbc)
              end
            end
          end
        end
        dbc:recalculateDynamicValues()
        return dbc
      end,
      getBasaltInstance = function(dbc)
        return baa
      end,
      setOffset = function(dbc, _cc, acc)
        dcb = _cc ~= nil and math.floor(_cc < 0 and math.abs(_cc) or -_cc) or dcb
        _db = acc ~= nil and math.floor(acc < 0 and math.abs(acc) or -acc) or _db
        dbc:updateDraw()
        return dbc
      end,
      getOffsetInternal = function(dbc)
        return dcb, _db
      end,
      getOffset = function(dbc)
        return dcb < 0 and math.abs(dcb) or -dcb, _db < 0 and math.abs(_db) or -_db
      end,
      removeFocusedObject = function(dbc)
        if dab ~= nil then
          dab:loseFocusHandler()
        end
        dab = nil
        return dbc
      end,
      getFocusedObject = function(dbc)
        return dab
      end,
      setCursor = function(dbc, _cc, acc, bcc, ccc)
        if dbc.parent ~= nil then
          local dcc, _dc = dbc:getAnchorPosition()
          dbc.parent:setCursor(_cc or false, (acc or 0) + dcc - 1, (bcc or 0) + _dc - 1, ccc or ccb)
        else
          local dcc, _dc = dbc:getAbsolutePosition(dbc:getAnchorPosition(dbc:getX(), dbc:getY(), true))
          _cb = _cc or false
          if acc ~= nil then
            acb = dcc + acc - 1
          end
          if bcc ~= nil then
            bcb = _dc + bcc - 1
          end
          ccb = ccc or ccb
          if _cb then
            dca.setTextColor(ccb)
            dca.setCursorPos(acb, bcb)
            dca.setCursorBlink(_cb)
          else
            dca.setCursorBlink(false)
          end
        end
        return dbc
      end,
      setMovable = function(dbc, _cc)
        if dbc.parent ~= nil then
          aab = _cc or not aab
          dbc.parent:addEvent('mouse_click', dbc)
          cbb['mouse_click'] = true
          dbc.parent:addEvent('mouse_up', dbc)
          cbb['mouse_up'] = true
          dbc.parent:addEvent('mouse_drag', dbc)
          cbb['mouse_drag'] = true
        end
        return dbc
      end,
      setScrollable = function(dbc, _cc)
        a_b = (_cc or _cc == nil) and true or false
        if dbc.parent ~= nil then
          dbc.parent:addEvent('mouse_scroll', dbc)
        end
        cbb['mouse_scroll'] = true
        return dbc
      end,
      setScrollAmount = function(dbc, _cc)
        b_b = _cc or b_b
        abb = false
        return dbc
      end,
      getScrollAmount = function(dbc)
        return abb and cbc(dbc) or b_b
      end,
      show = function(dbc)
        caa.show(dbc)
        if dbc.parent == nil then
          baa.setActiveFrame(dbc)
          if ada and not bda then
            baa.setMonitorFrame(_da, dbc)
          elseif bda then
            baa.setMonitorFrame(dbc:getName(), dbc, _da)
          else
            baa.setMainFrame(dbc)
          end
        end
        return dbc
      end,
      hide = function(dbc)
        caa.hide(dbc)
        if dbc.parent == nil then
          if activeFrame == dbc then
            activeFrame = nil
          end
          if ada and not bda then
            if baa.getMonitorFrame(_da) == dbc then
              baa.setActiveFrame(nil)
            end
          elseif bda then
            if baa.getMonitorFrame(dbc:getName()) == dbc then
              baa.setActiveFrame(nil)
            end
          else
            if baa.getMainFrame() == dbc then
              baa.setMainFrame(nil)
            end
          end
        end
        return dbc
      end,
      addLayout = function(dbc, _cc)
        if _cc ~= nil then
          if fs.exists(_cc) then
            local acc = fs.open(_cc, 'r')
            local bcc = _d:ParseXmlText(acc.readAll())
            acc.close()
            adb = {}
            dbc:setValuesByXMLData(bcc)
          end
        end
        return dbc
      end,
      getLastLayout = function(dbc)
        return adb
      end,
      addLayoutFromString = function(dbc, _cc)
        if _cc ~= nil then
          local acc = _d:ParseXmlText(_cc)
          dbc:setValuesByXMLData(acc)
        end
        return dbc
      end,
      setValuesByXMLData = function(dbc, _cc)
        caa.setValuesByXMLData(dbc, _cc)
        if dd('movable', _cc) ~= nil then
          if dd('movable', _cc) then
            dbc:setMovable(true)
          end
        end
        if dd('scrollable', _cc) ~= nil then
          if dd('scrollable', _cc) then
            dbc:setScrollable(true)
          end
        end
        if dd('monitor', _cc) ~= nil then
          dbc:setMonitor(dd('monitor', _cc)):show()
        end
        if dd('mirror', _cc) ~= nil then
          dbc:setMirror(dd('mirror', _cc))
        end
        if dd('bar', _cc) ~= nil then
          if dd('bar', _cc) then
            dbc:showBar(true)
          else
            dbc:showBar(false)
          end
        end
        if dd('barText', _cc) ~= nil then
          dbc.barText = dd('barText', _cc)
        end
        if dd('barBG', _cc) ~= nil then
          dbc.barBackground = colors[dd('barBG', _cc)]
        end
        if dd('barFG', _cc) ~= nil then
          dbc.barTextcolor = colors[dd('barFG', _cc)]
        end
        if dd('barAlign', _cc) ~= nil then
          dbc.barTextAlign = dd('barAlign', _cc)
        end
        if dd('layout', _cc) ~= nil then
          dbc:addLayout(dd('layout', _cc))
        end
        if dd('xOffset', _cc) ~= nil then
          dbc:setOffset(dd('xOffset', _cc), _db)
        end
        if dd('yOffset', _cc) ~= nil then
          dbc:setOffset(_db, dd('yOffset', _cc))
        end
        if dd('scrollAmount', _cc) ~= nil then
          dbc:setScrollAmount(dd('scrollAmount', _cc))
        end
        local acc = _cc:children()
        for bcc, ccc in pairs(acc) do
          if ccc.___name ~= 'animation' then
            local dcc = ccc.___name:gsub('^%l', string.upper)
            if bc[dcc] ~= nil then
              cdb(ccc, dbc['add' .. dcc], dbc)
            end
          end
        end
        cdb(_cc['frame'], dbc.addFrame, dbc)
        cdb(_cc['animation'], dbc.addAnimation, dbc)
        return dbc
      end,
      showBar = function(dbc, _cc)
        dbc.barActive = _cc or not dbc.barActive
        dbc:updateDraw()
        return dbc
      end,
      setBar = function(dbc, _cc, acc, bcc)
        dbc.barText = _cc or ''
        dbc.barBackground = acc or dbc.barBackground
        dbc.barTextcolor = bcc or dbc.barTextcolor
        dbc:updateDraw()
        return dbc
      end,
      setBarTextAlign = function(dbc, _cc)
        dbc.barTextAlign = _cc or 'left'
        dbc:updateDraw()
        return dbc
      end,
      setMirror = function(dbc, _cc)
        if dbc.parent ~= nil then
          error 'Frame has to be a base frame in order to attach a mirror.'
        end
        _ab = _cc
        if mirror ~= nil then
          dbb.setMirror(mirror)
        end
        c_b = true
        return dbc
      end,
      removeMirror = function(dbc)
        mirror = nil
        c_b = false
        dbb.setMirror(nil)
        return dbc
      end,
      setMonitorScale = function(dbc, _cc)
        if ada then
          dca.setTextScale(_cc)
        end
        return dbc
      end,
      setMonitor = function(dbc, _cc, acc)
        if (_cc ~= nil) and (_cc ~= false) then
          if type(_cc) == 'string' then
            if peripheral.getType(_cc) == 'monitor' then
              dca = peripheral.wrap(_cc)
              cda = true
            end
            if dbc.parent ~= nil then
              dbc.parent:removeObject(dbc)
            end
            ada = true
            baa.setMonitorFrame(_cc, dbc)
          elseif type(_cc) == 'table' then
            dca = ad(_cc)
            cda = true
            ada = true
            bda = true
            baa.setMonitorFrame(dbc:getName(), dbc, true)
          end
        else
          dca = parentTerminal
          ada = false
          bda = false
          if type(_da) == 'string' then
            if baa.getMonitorFrame(_da) == dbc then
              baa.setMonitorFrame(_da, nil)
            end
          else
            if baa.getMonitorFrame(dbc:getName()) == dbc then
              baa.setMonitorFrame(dbc:getName(), nil)
            end
          end
        end
        if acc ~= nil then
          dca.setTextScale(acc)
        end
        dbb = cc(dca)
        dbc:setSize(dca.getSize())
        _bb = true
        _da = _cc or nil
        dbc:updateDraw()
        return dbc
      end,
      loseFocusHandler = function(dbc)
        caa.loseFocusHandler(dbc)
        if dab ~= nil then
          dab:loseFocusHandler()
          dab = nil
        end
      end,
      getFocusHandler = function(dbc)
        caa.getFocusHandler(dbc)
        if dbc.parent ~= nil then
          if aab then
            dbc.parent:removeEvents(dbc)
            dbc.parent:removeObject(dbc)
            dbc.parent:addObject(dbc)
            for _cc, acc in pairs(cbb) do
              if acc then
                dbc.parent:addEvent(_cc, dbc)
              end
            end
            dbc:updateDraw()
          end
        end
        if dab ~= nil then
          dab:getFocusHandler()
        end
      end,
      eventHandler = function(dbc, _cc, ...)
        caa.eventHandler(dbc, _cc, ...)
        if cba['other_event'] ~= nil then
          for acc, bcc in ipairs(dba['other_event']) do
            if cba['other_event'][bcc] ~= nil then
              for ccc, dcc in cd(cba['other_event'][bcc]) do
                if dcc.eventHandler ~= nil then
                  if dcc:eventHandler(_cc, ...) then
                    return true
                  end
                end
              end
            end
          end
        end
        if _bb and not ada then
          if dbc.parent == nil then
            if _cc == 'term_resize' then
              dbc:setSize(dca.getSize())
              _bb = true
            end
          end
        end
        if ada then
          if _bb then
            if _cc == 'monitor_resize' then
              if type(_da) == 'string' then
                dbc:setSize(dca.getSize())
              elseif type(_da) == 'table' then
                for acc, bcc in pairs(_da) do
                  for ccc, dcc in pairs(bcc) do
                    if p1 == dcc then
                      dbc:setSize(dca.getSize())
                    end
                  end
                end
              end
              _bb = true
              dbc:updateDraw()
            end
          end
          if (_cc == 'peripheral') and (p1 == _da) then
            if peripheral.getType(_da) == 'monitor' then
              cda = true
              dca = peripheral.wrap(_da)
              dbb = cc(dca)
              dbc:updateDraw()
            end
          end
          if (_cc == 'peripheral_detach') and (p1 == _da) then
            cda = false
          end
        end
        if c_b then
          if peripheral.getType(_ab) == 'monitor' then
            d_b = true
            dbb.setMirror(peripheral.wrap(_ab))
          end
          if (_cc == 'peripheral_detach') and (p1 == _ab) then
            cda = false
          end
          if (_cc == 'monitor_touch') and (_ab == p1) then
            dbc:mouseHandler(1, p2, p3, true)
          end
        end
        if (_cc == 'terminate') and (dbc.parent == nil) then
          baa.stop()
        end
      end,
      mouseHandler = function(dbc, _cc, acc, bcc, ccc, dcc)
        if bda then
          if dca.calculateClick ~= nil then
            acc, bcc = dca.calculateClick(dcc, acc, bcc)
          end
        end
        if caa.mouseHandler(dbc, _cc, acc, bcc) then
          if cba['mouse_click'] ~= nil then
            dbc:setCursor(false)
            for _dc, adc in ipairs(dba['mouse_click']) do
              if cba['mouse_click'][adc] ~= nil then
                for bdc, cdc in cd(cba['mouse_click'][adc]) do
                  if cdc.mouseHandler ~= nil then
                    if cdc:mouseHandler(_cc, acc, bcc) then
                      return true
                    end
                  end
                end
              end
            end
          end
          if aab then
            local _dc, adc = dbc:getAbsolutePosition(dbc:getAnchorPosition())
            if (acc >= _dc) and (acc <= _dc + dbc:getWidth() - 1) and (bcc == adc) then
              bab = true
              dda = _dc - acc
              __b = yOff and 1 or 0
            end
          end
          dbc:removeFocusedObject()
          return true
        end
        return false
      end,
      mouseUpHandler = function(dbc, _cc, acc, bcc)
        if bab then
          bab = false
        end
        if caa.mouseUpHandler(dbc, _cc, acc, bcc) then
          if cba['mouse_up'] ~= nil then
            for ccc, dcc in ipairs(dba['mouse_up']) do
              if cba['mouse_up'][dcc] ~= nil then
                for _dc, adc in cd(cba['mouse_up'][dcc]) do
                  if adc.mouseUpHandler ~= nil then
                    if adc:mouseUpHandler(_cc, acc, bcc) then
                      return true
                    end
                  end
                end
              end
            end
          end
          return true
        end
        return false
      end,
      scrollHandler = function(dbc, _cc, acc, bcc)
        if caa.scrollHandler(dbc, _cc, acc, bcc) then
          if cba['mouse_scroll'] ~= nil then
            for dcc, _dc in pairs(dba['mouse_scroll']) do
              if cba['mouse_scroll'][_dc] ~= nil then
                for adc, bdc in cd(cba['mouse_scroll'][_dc]) do
                  if bdc.scrollHandler ~= nil then
                    if bdc:scrollHandler(_cc, acc, bcc) then
                      return true
                    end
                  end
                end
              end
            end
          end
          local ccc = _db
          if a_b then
            cbc(dbc)
            if (_cc > 0) or (_cc < 0) then
              _db = c_a(b_a(_db - _cc, 0), -b_b)
              dbc:updateDraw()
            end
          end
          dbc:removeFocusedObject()
          if _db == ccc then
            return false
          end
          return true
        end
        return false
      end,
      hoverHandler = function(dbc, _cc, acc, bcc)
        if caa.hoverHandler(dbc, _cc, acc, bcc) then
          if cba['mouse_move'] ~= nil then
            for ccc, dcc in pairs(dba['mouse_move']) do
              if cba['mouse_move'][dcc] ~= nil then
                for _dc, adc in cd(cba['mouse_move'][dcc]) do
                  if adc.hoverHandler ~= nil then
                    if adc:hoverHandler(_cc, acc, bcc) then
                      return true
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end,
      dragHandler = function(dbc, _cc, acc, bcc)
        if bab then
          local ccc, dcc = dbc.parent:getOffsetInternal()
          ccc = ccc < 0 and math.abs(ccc) or -ccc
          dcc = dcc < 0 and math.abs(dcc) or -dcc
          local _dc = 1
          local adc = 1
          if dbc.parent ~= nil then
            _dc, adc = dbc.parent:getAbsolutePosition(dbc.parent:getAnchorPosition())
          end
          dbc:setPosition(acc + dda - (_dc - 1) + ccc, bcc + __b - (adc - 1) + dcc)
          dbc:updateDraw()
          return true
        end
        if (dbc:isVisible()) and (dbc:isEnabled()) then
          if cba['mouse_drag'] ~= nil then
            for ccc, dcc in ipairs(dba['mouse_drag']) do
              if cba['mouse_drag'][dcc] ~= nil then
                for _dc, adc in cd(cba['mouse_drag'][dcc]) do
                  if adc.dragHandler ~= nil then
                    if adc:dragHandler(_cc, acc, bcc) then
                      return true
                    end
                  end
                end
              end
            end
          end
        end
        caa.dragHandler(dbc, _cc, acc, bcc)
        return false
      end,
      keyHandler = function(dbc, _cc, acc)
        if (dbc:isFocused()) or (dbc.parent == nil) then
          local bcc = dbc:getEventSystem():sendEvent('key', dbc, 'key', _cc)
          if bcc == false then
            return false
          end
          if cba['key'] ~= nil then
            for ccc, dcc in pairs(dba['key']) do
              if cba['key'][dcc] ~= nil then
                for _dc, adc in cd(cba['key'][dcc]) do
                  if adc.keyHandler ~= nil then
                    if adc:keyHandler(_cc, acc) then
                      return true
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end,
      keyUpHandler = function(dbc, _cc)
        if (dbc:isFocused()) or (dbc.parent == nil) then
          local acc = dbc:getEventSystem():sendEvent('key_up', dbc, 'key_up', _cc)
          if acc == false then
            return false
          end
          if cba['key_up'] ~= nil then
            for bcc, ccc in pairs(dba['key_up']) do
              if cba['key_up'][ccc] ~= nil then
                for dcc, _dc in cd(cba['key_up'][ccc]) do
                  if _dc.keyUpHandler ~= nil then
                    if _dc:keyUpHandler(_cc) then
                      return true
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end,
      charHandler = function(dbc, _cc)
        if (dbc:isFocused()) or (dbc.parent == nil) then
          local acc = dbc:getEventSystem():sendEvent('char', dbc, 'char', _cc)
          if acc == false then
            return false
          end
          if cba['char'] ~= nil then
            for bcc, ccc in pairs(dba['char']) do
              if cba['char'][ccc] ~= nil then
                for dcc, _dc in cd(cba['char'][ccc]) do
                  if _dc.charHandler ~= nil then
                    if _dc:charHandler(_cc) then
                      return true
                    end
                  end
                end
              end
            end
          end
        end
        return false
      end,
      setText = function(dbc, _cc, acc, bcc)
        local ccc, dcc = dbc:getAnchorPosition()
        if (acc >= 1) and (acc <= dbc:getHeight()) then
          if dbc.parent ~= nil then
            dbc.parent:setText(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          else
            dbb.setText(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          end
        end
      end,
      setBG = function(dbc, _cc, acc, bcc)
        local ccc, dcc = dbc:getAnchorPosition()
        if (acc >= 1) and (acc <= dbc:getHeight()) then
          if dbc.parent ~= nil then
            dbc.parent:setBG(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          else
            dbb.setBG(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          end
        end
      end,
      setFG = function(dbc, _cc, acc, bcc)
        local ccc, dcc = dbc:getAnchorPosition()
        if (acc >= 1) and (acc <= dbc:getHeight()) then
          if dbc.parent ~= nil then
            dbc.parent:setFG(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          else
            dbb.setFG(
              c_a(_cc + (ccc - 1), ccc),
              dcc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1))
            )
          end
        end
      end,
      writeText = function(dbc, _cc, acc, bcc, ccc, dcc)
        local _dc, adc = dbc:getAnchorPosition()
        if (acc >= 1) and (acc <= dbc:getHeight()) then
          if dbc.parent ~= nil then
            dbc.parent:writeText(
              c_a(_cc + (_dc - 1), _dc),
              adc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), dbc:getWidth() - _cc + 1),
              ccc,
              dcc
            )
          else
            dbb.writeText(
              c_a(_cc + (_dc - 1), _dc),
              adc + acc - 1,
              a_a(bcc, c_a(1 - _cc + 1, 1), c_a(dbc:getWidth() - _cc + 1, 1)),
              ccc,
              dcc
            )
          end
        end
      end,
      blit = function(dbc, _cc, acc, bcc, ccc, dcc)
        local _dc, adc = dbc:getAnchorPosition()
        if (acc >= 1) and (acc <= dbc:getHeight()) then
          local bdc = dbc:getWidth()
          if dbc.parent ~= nil then
            bcc = a_a(bcc, c_a(1 - _cc + 1, 1), bdc - _cc + 1)
            ccc = a_a(ccc, c_a(1 - _cc + 1, 1), bdc - _cc + 1)
            dcc = a_a(dcc, c_a(1 - _cc + 1, 1), bdc - _cc + 1)
            dbc.parent:blit(c_a(_cc + (_dc - 1), _dc), adc + acc - 1, bcc, ccc, dcc)
          else
            bcc = a_a(bcc, c_a(1 - _cc + 1, 1), c_a(bdc - _cc + 1, 1))
            ccc = a_a(ccc, c_a(1 - _cc + 1, 1), c_a(bdc - _cc + 1, 1))
            dcc = a_a(dcc, c_a(1 - _cc + 1, 1), c_a(bdc - _cc + 1, 1))
            dbb.blit(c_a(_cc + (_dc - 1), _dc), adc + acc - 1, bcc, ccc, dcc)
          end
        end
      end,
      drawBackgroundBox = function(dbc, _cc, acc, bcc, ccc, dcc)
        local _dc, adc = dbc:getAnchorPosition()
        ccc = (
          acc < 1 and (ccc + acc > dbc:getHeight() and dbc:getHeight() or ccc + acc - 1)
          or (ccc + acc > dbc:getHeight() and dbc:getHeight() - acc + 1 or ccc)
        )
        bcc = (
          _cc < 1 and (bcc + _cc > dbc:getWidth() and dbc:getWidth() or bcc + _cc - 1)
          or (bcc + _cc > dbc:getWidth() and dbc:getWidth() - _cc + 1 or bcc)
        )
        if dbc.parent ~= nil then
          dbc.parent:drawBackgroundBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, dcc)
        else
          dbb.drawBackgroundBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, dcc)
        end
      end,
      drawTextBox = function(dbc, _cc, acc, bcc, ccc, dcc)
        local _dc, adc = dbc:getAnchorPosition()
        ccc = (
          acc < 1 and (ccc + acc > dbc:getHeight() and dbc:getHeight() or ccc + acc - 1)
          or (ccc + acc > dbc:getHeight() and dbc:getHeight() - acc + 1 or ccc)
        )
        bcc = (
          _cc < 1 and (bcc + _cc > dbc:getWidth() and dbc:getWidth() or bcc + _cc - 1)
          or (bcc + _cc > dbc:getWidth() and dbc:getWidth() - _cc + 1 or bcc)
        )
        if dbc.parent ~= nil then
          dbc.parent:drawTextBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, a_a(dcc, 1, 1))
        else
          dbb.drawTextBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, a_a(dcc, 1, 1))
        end
      end,
      drawForegroundBox = function(dbc, _cc, acc, bcc, ccc, dcc)
        local _dc, adc = dbc:getAnchorPosition()
        ccc = (
          acc < 1 and (ccc + acc > dbc:getHeight() and dbc:getHeight() or ccc + acc - 1)
          or (ccc + acc > dbc:getHeight() and dbc:getHeight() - acc + 1 or ccc)
        )
        bcc = (
          _cc < 1 and (bcc + _cc > dbc:getWidth() and dbc:getWidth() or bcc + _cc - 1)
          or (bcc + _cc > dbc:getWidth() and dbc:getWidth() - _cc + 1 or bcc)
        )
        if dbc.parent ~= nil then
          dbc.parent:drawForegroundBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, dcc)
        else
          dbb.drawForegroundBox(c_a(_cc + (_dc - 1), _dc), c_a(acc + (adc - 1), adc), bcc, ccc, dcc)
        end
      end,
      draw = function(dbc, _cc)
        if ada and not cda then
          return false
        end
        if dbc.parent == nil then
          if dbc:getDraw() == false then
            return false
          end
        end
        if caa.draw(dbc) then
          local acc, bcc = dbc:getAbsolutePosition(dbc:getAnchorPosition())
          local ccc, dcc = dbc:getAnchorPosition()
          local _dc, adc = dbc:getSize()
          if dbc.parent == nil then
            if dbc.bgColor ~= false then
              dbb.drawBackgroundBox(ccc, dcc, _dc, adc, dbc.bgColor)
              dbb.drawTextBox(ccc, dcc, _dc, adc, ' ')
            end
            if dbc.fgColor ~= false then
              dbb.drawForegroundBox(ccc, dcc, _dc, adc, dbc.fgColor)
            end
          end
          if dbc.barActive then
            if dbc.parent ~= nil then
              dbc.parent:writeText(
                ccc,
                dcc,
                dc.getTextHorizontalAlign(dbc.barText, _dc, dbc.barTextAlign),
                dbc.barBackground,
                dbc.barTextcolor
              )
            else
              dbb.writeText(
                ccc,
                dcc,
                dc.getTextHorizontalAlign(dbc.barText, _dc, dbc.barTextAlign),
                dbc.barBackground,
                dbc.barTextcolor
              )
            end
            if dbc:getBorder 'left' then
              if dbc.parent ~= nil then
                dbc.parent:drawBackgroundBox(ccc - 1, dcc, 1, 1, dbc.barBackground)
                if dbc.bgColor ~= false then
                  dbc.parent:drawBackgroundBox(ccc - 1, dcc + 1, 1, adc - 1, dbc.bgColor)
                end
              end
            end
            if dbc:getBorder 'top' then
              if dbc.parent ~= nil then
                dbc.parent:drawBackgroundBox(ccc - 1, dcc - 1, _dc + 1, 1, dbc.barBackground)
              end
            end
          end
          for bdc, cdc in cd(aba) do
            if _ba[cdc] ~= nil then
              for ddc, __d in pairs(_ba[cdc]) do
                if __d.draw ~= nil then
                  __d:draw()
                end
              end
            end
          end
        end
      end,
      updateTerm = function(dbc)
        if ada and not cda then
          return false
        end
        dbb.update()
      end,
      addObject = function(dbc, _cc)
        return a_c(_cc)
      end,
      removeObject = c_c,
      getObject = function(dbc, _cc)
        return ddb(_cc)
      end,
      getDeepObject = function(dbc, _cc)
        return __c(_cc)
      end,
      addFrame = function(dbc, _cc)
        local acc = baa.newFrame(_cc or bd(), dbc, nil, baa)
        return a_c(acc)
      end,
      init = function(dbc)
        if not bbb then
          if _aa ~= nil then
            caa.width, caa.height = _aa:getSize()
            dbc:setBackground(_aa:getTheme 'FrameBG')
            dbc:setForeground(_aa:getTheme 'FrameText')
          else
            caa.width, caa.height = dca.getSize()
            dbc:setBackground(baa.getTheme 'BasaltBG')
            dbc:setForeground(baa.getTheme 'BasaltText')
          end
          bbb = true
        end
      end,
    }
    for dbc, _cc in pairs(bc) do
      bba['add' .. dbc] = function(acc, bcc)
        return a_c(_cc(bcc or bd(), acc))
      end
    end
    setmetatable(bba, caa)
    return bba
  end
end
project['default']['loadObjects'] = function(...)
  local d = {}
  if packaged then
    for ba, ca in pairs(getProject 'objects') do
      d[ba] = ca()
    end
    return d
  end
  local _a = table.pack(...)
  local aa = fs.getDir(_a[2] or 'Basalt')
  if aa == nil then
    error('Unable to find directory ' .. _a[2] .. ' please report this bug to our discord.')
  end
  for ba, ca in pairs(fs.list(fs.combine(aa, 'objects'))) do
    if ca ~= 'example.lua' then
      local da = ca:gsub('.lua', '')
      d[da] = require(da)
    end
  end
  return d
end
project['default']['Object'] = function(...)
  local aa = require 'basaltEvent'
  local ba = require 'utils'
  local ca = ba.splitString
  local da = ba.numberFromString
  local _b = ba.getValueFromXML
  return function(ab)
    local bb = 'Object'
    local cb = {}
    local db = 1
    local _c
    local ac = 'topLeft'
    local bc = false
    local cc = true
    local dc = false
    local _d = false
    local ad = false
    local bd = false
    local cd = { left = false, right = false, top = false, bottom = false }
    local dd = colors.black
    local __a = true
    local a_a = false
    local b_a, c_a, d_a, _aa = 0, 0, 0, 0
    local aaa = true
    local baa = {}
    local caa = aa()
    cb = {
      x = 1,
      y = 1,
      width = 1,
      height = 1,
      bgColor = colors.black,
      bgSymbol = ' ',
      bgSymbolColor = colors.black,
      fgColor = colors.white,
      transparentColor = false,
      name = ab or 'Object',
      parent = nil,
      show = function(daa)
        cc = true
        daa:updateDraw()
        return daa
      end,
      hide = function(daa)
        cc = false
        daa:updateDraw()
        return daa
      end,
      enable = function(daa)
        __a = true
        return daa
      end,
      disable = function(daa)
        __a = false
        return daa
      end,
      isEnabled = function(daa)
        return __a
      end,
      generateXMLEventFunction = function(daa, _ba, aba)
        local bba = function(cba)
          if cba:sub(1, 1) == '#' then
            local dba = daa:getBaseFrame():getDeepObject(cba:sub(2, cba:len()))
            if (dba ~= nil) and (dba.internalObjetCall ~= nil) then
              _ba(daa, function()
                dba:internalObjetCall()
              end)
            end
          else
            _ba(daa, daa:getBaseFrame():getVariable(cba))
          end
        end
        if type(aba) == 'string' then
          bba(aba)
        elseif type(aba) == 'table' then
          for cba, dba in pairs(aba) do
            bba(dba)
          end
        end
        return daa
      end,
      setValuesByXMLData = function(daa, _ba)
        local aba = daa:getBaseFrame()
        if _b('x', _ba) ~= nil then
          daa:setPosition(_b('x', _ba), daa.y)
        end
        if _b('y', _ba) ~= nil then
          daa:setPosition(daa.x, _b('y', _ba))
        end
        if _b('width', _ba) ~= nil then
          daa:setSize(_b('width', _ba), daa.height)
        end
        if _b('height', _ba) ~= nil then
          daa:setSize(daa.width, _b('height', _ba))
        end
        if _b('bg', _ba) ~= nil then
          daa:setBackground(colors[_b('bg', _ba)])
        end
        if _b('fg', _ba) ~= nil then
          daa:setForeground(colors[_b('fg', _ba)])
        end
        if _b('value', _ba) ~= nil then
          daa:setValue(colors[_b('value', _ba)])
        end
        if _b('visible', _ba) ~= nil then
          if _b('visible', _ba) then
            daa:show()
          else
            daa:hide()
          end
        end
        if _b('enabled', _ba) ~= nil then
          if _b('enabled', _ba) then
            daa:enable()
          else
            daa:disable()
          end
        end
        if _b('zIndex', _ba) ~= nil then
          daa:setZIndex(_b('zIndex', _ba))
        end
        if _b('anchor', _ba) ~= nil then
          daa:setAnchor(_b('anchor', _ba))
        end
        if _b('shadowColor', _ba) ~= nil then
          daa:setShadow(colors[_b('shadowColor', _ba)])
        end
        if _b('border', _ba) ~= nil then
          daa:setBorder(colors[_b('border', _ba)])
        end
        if _b('borderLeft', _ba) ~= nil then
          cd['left'] = _b('borderLeft', _ba)
        end
        if _b('borderTop', _ba) ~= nil then
          cd['top'] = _b('borderTop', _ba)
        end
        if _b('borderRight', _ba) ~= nil then
          cd['right'] = _b('borderRight', _ba)
        end
        if _b('borderBottom', _ba) ~= nil then
          cd['bottom'] = _b('borderBottom', _ba)
        end
        if _b('borderColor', _ba) ~= nil then
          daa:setBorder(colors[_b('borderColor', _ba)])
        end
        if _b('ignoreOffset', _ba) ~= nil then
          if _b('ignoreOffset', _ba) then
            daa:ignoreOffset(true)
          end
        end
        if _b('onClick', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onClick, _b('onClick', _ba))
        end
        if _b('onClickUp', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onClickUp, _b('onClickUp', _ba))
        end
        if _b('onScroll', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onScroll, _b('onScroll', _ba))
        end
        if _b('onDrag', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onDrag, _b('onDrag', _ba))
        end
        if _b('onHover', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onHover, _b('onHover', _ba))
        end
        if _b('onLeave', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onLeave, _b('onLeave', _ba))
        end
        if _b('onKey', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onKey, _b('onKey', _ba))
        end
        if _b('onKeyUp', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onKeyUp, _b('onKeyUp', _ba))
        end
        if _b('onChange', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onChange, _b('onChange', _ba))
        end
        if _b('onResize', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onResize, _b('onResize', _ba))
        end
        if _b('onReposition', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onReposition, _b('onReposition', _ba))
        end
        if _b('onEvent', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onEvent, _b('onEvent', _ba))
        end
        if _b('onGetFocus', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onGetFocus, _b('onGetFocus', _ba))
        end
        if _b('onLoseFocus', _ba) ~= nil then
          daa:generateXMLEventFunction(daa.onLoseFocus, _b('onLoseFocus', _ba))
        end
        daa:updateDraw()
        return daa
      end,
      isVisible = function(daa)
        return cc
      end,
      setFocus = function(daa)
        if daa.parent ~= nil then
          daa.parent:setFocusedObject(daa)
        end
        return daa
      end,
      setZIndex = function(daa, _ba)
        db = _ba
        if daa.parent ~= nil then
          daa.parent:removeObject(daa)
          daa.parent:addObject(daa)
          daa:updateEventHandlers()
        end
        return daa
      end,
      updateEventHandlers = function(daa)
        for _ba, aba in pairs(baa) do
          if aba then
            daa.parent:addEvent(_ba, daa)
          end
        end
      end,
      getZIndex = function(daa)
        return db
      end,
      getType = function(daa)
        return bb
      end,
      getName = function(daa)
        return daa.name
      end,
      remove = function(daa)
        if daa.parent ~= nil then
          daa.parent:removeObject(daa)
        end
        daa:updateDraw()
        return daa
      end,
      setParent = function(daa, _ba)
        if _ba.getType ~= nil and _ba:getType() == 'Frame' then
          daa:remove()
          _ba:addObject(daa)
          if daa.draw then
            daa:show()
          end
        end
        return daa
      end,
      setValue = function(daa, _ba)
        if _c ~= _ba then
          _c = _ba
          daa:updateDraw()
          daa:valueChangedHandler()
        end
        return daa
      end,
      getValue = function(daa)
        return _c
      end,
      getDraw = function(daa)
        return aaa
      end,
      updateDraw = function(daa, _ba)
        aaa = _ba
        if _ba == nil then
          aaa = true
        end
        if aaa then
          if daa.parent ~= nil then
            daa.parent:updateDraw()
          end
        end
        return daa
      end,
      getEventSystem = function(daa)
        return caa
      end,
      getParent = function(daa)
        return daa.parent
      end,
      setPosition = function(daa, _ba, aba, bba)
        if type(_ba) == 'number' then
          daa.x = bba and daa:getX() + _ba or _ba
        end
        if type(aba) == 'number' then
          daa.y = bba and daa:getY() + aba or aba
        end
        if daa.parent ~= nil then
          if type(_ba) == 'string' then
            daa.x = daa.parent:newDynamicValue(daa, _ba)
          end
          if type(aba) == 'string' then
            daa.y = daa.parent:newDynamicValue(daa, aba)
          end
          daa.parent:recalculateDynamicValues()
        end
        caa:sendEvent('basalt_reposition', daa)
        daa:updateDraw()
        return daa
      end,
      getX = function(daa)
        return

type(daa.x) == 'number' and daa.x or math.floor(daa.x[1] + 0.5)
      end,
      getY = function(daa)
        return

type(daa.y) == 'number' and daa.y or math.floor(daa.y[1] + 0.5)
      end,
      getPosition = function(daa)
        return daa:getX(), daa:getY()
      end,
      getVisibility = function(daa)
        return cc
      end,
      setVisibility = function(daa, _ba)
        cc = _ba or not cc
        daa:updateDraw()
        return daa
      end,
      setSize = function(daa, _ba, aba, bba)
        if type(_ba) == 'number' then
          daa.width = bba and daa:getWidth() + _ba or _ba
        end
        if type(aba) == 'number' then
          daa.height = bba and daa:getHeight() + aba or aba
        end
        if daa.parent ~= nil then
          if type(_ba) == 'string' then
            daa.width = daa.parent:newDynamicValue(daa, _ba)
          end
          if type(aba) == 'string' then
            daa.height = daa.parent:newDynamicValue(daa, aba)
          end
          daa.parent:recalculateDynamicValues()
        end
        caa:sendEvent('basalt_resize', daa)
        daa:updateDraw()
        return daa
      end,
      getHeight = function(daa)
        return type(daa.height) == 'number' and daa.height or math.floor(daa.height[1] + 0.5)
      end,
      getWidth = function(daa)
        return

type(daa.width) == 'number' and daa.width or math.floor(daa.width[1] + 0.5)
      end,
      getSize = function(daa)
        return daa:getWidth(), daa:getHeight()
      end,
      calculateDynamicValues = function(daa)
        if type(daa.width) == 'table' then
          daa.width:calculate()
        end
        if type(daa.height) == 'table' then
          daa.height:calculate()
        end
        if type(daa.x) == 'table' then
          daa.x:calculate()
        end
        if type(daa.y) == 'table' then
          daa.y:calculate()
        end
        daa:updateDraw()
        return daa
      end,
      setBackground = function(daa, _ba, aba, bba)
        daa.bgColor = _ba or false
        daa.bgSymbol = aba or (daa.bgColor ~= false and daa.bgSymbol or false)
        daa.bgSymbolColor = bba or daa.bgSymbolColor
        daa:updateDraw()
        return daa
      end,
      setTransparent = function(daa, _ba)
        daa.transparentColor = _ba or false
        daa.bgSymbol = false
        daa.bgSymbolColor = false
        daa:updateDraw()
        return daa
      end,
      getBackground = function(daa)
        return daa.bgColor
      end,
      setForeground = function(daa, _ba)
        daa.fgColor = _ba or false
        daa:updateDraw()
        return daa
      end,
      getForeground = function(daa)
        return daa.fgColor
      end,
      setShadow = function(daa, _ba)
        if _ba == false then
          bd = false
        else
          dd = _ba
          bd = true
        end
        daa:updateDraw()
        return daa
      end,
      isShadowActive = function(daa)
        return bd
      end,
      setBorder = function(daa, ...)
        if ... ~= nil then
          local _ba = { ... }
          for aba, bba in pairs(_ba) do
            if (bba == 'left') or (#_ba == 1) then
              cd['left'] = _ba[1]
            end
            if (bba == 'top') or (#_ba == 1) then
              cd['top'] = _ba[1]
            end
            if (bba == 'right') or (#_ba == 1) then
              cd['right'] = _ba[1]
            end
            if (bba == 'bottom') or (#_ba == 1) then
              cd['bottom'] = _ba[1]
            end
          end
        end
        daa:updateDraw()
        return daa
      end,
      getBorder = function(daa, _ba)
        if _ba == 'left' then
          return borderLeft
        end
        if _ba == 'top' then
          return borderTop
        end
        if _ba == 'right' then
          return borderRight
        end
        if _ba == 'bottom' then
          return borderBottom
        end
      end,
      draw = function(daa)
        if cc then
          if daa.parent ~= nil then
            local _ba, aba = daa:getAnchorPosition()
            local bba, cba = daa:getSize()
            local dba, _ca = daa.parent:getSize()
            if (_ba + bba < 1) or (_ba > dba) or (aba + cba < 1) or (aba > _ca) then
              return false
            end
            if daa.transparentColor ~= false then
              daa.parent:drawForegroundBox(_ba, aba, bba, cba, daa.transparentColor)
            end
            if daa.bgColor ~= false then
              daa.parent:drawBackgroundBox(_ba, aba, bba, cba, daa.bgColor)
            end
            if daa.bgSymbol ~= false then
              daa.parent:drawTextBox(_ba, aba, bba, cba, daa.bgSymbol)
              if daa.bgSymbol ~= ' ' then
                daa.parent:drawForegroundBox(_ba, aba, bba, cba, daa.bgSymbolColor)
              end
            end
            if bd then
              daa.parent:drawBackgroundBox(_ba + 1, aba + cba, bba, 1, dd)
              daa.parent:drawBackgroundBox(_ba + bba, aba + 1, 1, cba, dd)
              daa.parent:drawForegroundBox(_ba + 1, aba + cba, bba, 1, dd)
              daa.parent:drawForegroundBox(_ba + bba, aba + 1, 1, cba, dd)
            end
            local aca = daa.bgColor
            if cd['left'] ~= false then
              daa.parent:drawTextBox(_ba, aba, 1, cba, '\149')
              if aca ~= false then
                daa.parent:drawBackgroundBox(_ba, aba, 1, cba, daa.bgColor)
              end
              daa.parent:drawForegroundBox(_ba, aba, 1, cba, cd['left'])
            end
            if cd['top'] ~= false then
              daa.parent:drawTextBox(_ba, aba, bba, 1, '\131')
              if aca ~= false then
                daa.parent:drawBackgroundBox(_ba, aba, bba, 1, daa.bgColor)
              end
              daa.parent:drawForegroundBox(_ba, aba, bba, 1, cd['top'])
            end
            if (cd['left'] ~= false) and (cd['top'] ~= false) then
              daa.parent:drawTextBox(_ba, aba, 1, 1, '\151')
              if aca ~= false then
                daa.parent:drawBackgroundBox(_ba, aba, 1, 1, daa.bgColor)
              end
              daa.parent:drawForegroundBox(_ba, aba, 1, 1, cd['left'])
            end
            if cd['right'] ~= false then
              daa.parent:drawTextBox(_ba + bba - 1, aba, 1, cba, '\149')
              if aca ~= false then
                daa.parent:drawForegroundBox(_ba + bba - 1, aba, 1, cba, daa.bgColor)
              end
              daa.parent:drawBackgroundBox(_ba + bba - 1, aba, 1, cba, cd['right'])
            end
            if cd['bottom'] ~= false then
              daa.parent:drawTextBox(_ba, aba + cba - 1, bba, 1, '\143')
              if aca ~= false then
                daa.parent:drawForegroundBox(_ba, aba + cba - 1, bba, 1, daa.bgColor)
              end
              daa.parent:drawBackgroundBox(_ba, aba + cba - 1, bba, 1, cd['bottom'])
            end
            if (cd['top'] ~= false) and (cd['right'] ~= false) then
              daa.parent:drawTextBox(_ba + bba - 1, aba, 1, 1, '\148')
              if aca ~= false then
                daa.parent:drawForegroundBox(_ba + bba - 1, aba, 1, 1, daa.bgColor)
              end
              daa.parent:drawBackgroundBox(_ba + bba - 1, aba, 1, 1, cd['right'])
            end
            if (cd['right'] ~= false) and (cd['bottom'] ~= false) then
              daa.parent:drawTextBox(_ba + bba - 1, aba + cba - 1, 1, 1, '\133')
              if aca ~= false then
                daa.parent:drawForegroundBox(_ba + bba - 1, aba + cba - 1, 1, 1, daa.bgColor)
              end
              daa.parent:drawBackgroundBox(_ba + bba - 1, aba + cba - 1, 1, 1, cd['right'])
            end
            if (cd['bottom'] ~= false) and (cd['left'] ~= false) then
              daa.parent:drawTextBox(_ba, aba + cba - 1, 1, 1, '\138')
              if aca ~= false then
                daa.parent:drawForegroundBox(_ba - 1, aba + cba - 1, 1, 1, daa.bgColor)
              end
              daa.parent:drawBackgroundBox(_ba, aba + cba - 1, 1, 1, cd['left'])
            end
          end
          aaa = false
          return true
        end
        return false
      end,
      getAbsolutePosition = function(daa, _ba, aba)
        if (_ba == nil) or (aba == nil) then
          _ba, aba = daa:getAnchorPosition()
        end
        if daa.parent ~= nil then
          local bba, cba = daa.parent:getAbsolutePosition()
          _ba = bba + _ba - 1
          aba = cba + aba - 1
        end
        return _ba, aba
      end,
      getAnchorPosition = function(daa, _ba, aba, bba)
        if _ba == nil then
          _ba = daa:getX()
        end
        if aba == nil then
          aba = daa:getY()
        end
        if daa.parent ~= nil then
          local cba, dba = daa.parent:getSize()
          if ac == 'top' then
            _ba = math.floor(cba / 2) + _ba - 1
          elseif ac == 'topRight' then
            _ba = cba + _ba - 1
          elseif ac == 'right' then
            _ba = cba + _ba - 1
            aba = math.floor(dba / 2) + aba - 1
          elseif ac == 'bottomRight' then
            _ba = cba + _ba - 1
            aba = dba + aba - 1
          elseif ac == 'bottom' then
            _ba = math.floor(cba / 2) + _ba - 1
            aba = dba + aba - 1
          elseif ac == 'bottomLeft' then
            aba = dba + aba - 1
          elseif ac == 'left' then
            aba = math.floor(dba / 2) + aba - 1
          elseif ac == 'center' then
            _ba = math.floor(cba / 2) + _ba - 1
            aba = math.floor(dba / 2) + aba - 1
          end
          local _ca, aca = daa.parent:getOffsetInternal()
          if not (bc or bba) then
            return _ba + _ca, aba + aca
          end
        end
        return _ba, aba
      end,
      ignoreOffset = function(daa, _ba)
        bc = _ba
        if _ba == nil then
          bc = true
        end
        return daa
      end,
      getBaseFrame = function(daa)
        if daa.parent ~= nil then
          return daa.parent:getBaseFrame()
        end
        return daa
      end,
      setAnchor = function(daa, _ba)
        ac = _ba
        daa:updateDraw()
        return daa
      end,
      getAnchor = function(daa)
        return ac
      end,
      onChange = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('value_changed', aba)
          end
        end
        return daa
      end,
      onClick = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_click', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
          daa.parent:addEvent('mouse_up', daa)
          baa['mouse_up'] = true
        end
        return daa
      end,
      onClickUp = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_up', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
          daa.parent:addEvent('mouse_up', daa)
          baa['mouse_up'] = true
        end
        return daa
      end,
      onRelease = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_release', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
          daa.parent:addEvent('mouse_up', daa)
          baa['mouse_up'] = true
        end
        return daa
      end,
      onScroll = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_scroll', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_scroll', daa)
          baa['mouse_scroll'] = true
        end
        return daa
      end,
      onHover = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_hover', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_move', daa)
          baa['mouse_move'] = true
        end
        return daa
      end,
      onLeave = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_leave', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_move', daa)
          baa['mouse_move'] = true
        end
        return daa
      end,
      onDrag = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('mouse_drag', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_drag', daa)
          baa['mouse_drag'] = true
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
          daa.parent:addEvent('mouse_up', daa)
          baa['mouse_up'] = true
        end
        return daa
      end,
      onEvent = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('other_event', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('other_event', daa)
          baa['other_event'] = true
        end
        return daa
      end,
      onKey = function(daa, ...)
        if __a then
          for _ba, aba in pairs(table.pack(...)) do
            if type(aba) == 'function' then
              daa:registerEvent('key', aba)
            end
          end
          if daa.parent ~= nil then
            daa.parent:addEvent('key', daa)
            baa['key'] = true
          end
        end
        return daa
      end,
      onChar = function(daa, ...)
        if __a then
          for _ba, aba in pairs(table.pack(...)) do
            if type(aba) == 'function' then
              daa:registerEvent('char', aba)
            end
          end
          if daa.parent ~= nil then
            daa.parent:addEvent('char', daa)
            baa['char'] = true
          end
        end
        return daa
      end,
      onResize = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('basalt_resize', aba)
          end
        end
        return daa
      end,
      onReposition = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('basalt_reposition', aba)
          end
        end
        return daa
      end,
      onKeyUp = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('key_up', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('key_up', daa)
          baa['key_up'] = true
        end
        return daa
      end,
      isFocused = function(daa)
        if daa.parent ~= nil then
          return daa.parent:getFocusedObject() == daa
        end
        return false
      end,
      onGetFocus = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('get_focus', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
        end
        return daa
      end,
      onLoseFocus = function(daa, ...)
        for _ba, aba in pairs(table.pack(...)) do
          if type(aba) == 'function' then
            daa:registerEvent('lose_focus', aba)
          end
        end
        if daa.parent ~= nil then
          daa.parent:addEvent('mouse_click', daa)
          baa['mouse_click'] = true
        end
        return daa
      end,
      registerEvent = function(daa, _ba, aba)
        return caa:registerEvent(_ba, aba)
      end,
      removeEvent = function(daa, _ba, aba)
        return caa:removeEvent(_ba, aba)
      end,
      sendEvent = function(daa, _ba, ...)
        return caa:sendEvent(_ba, daa, ...)
      end,
      isCoordsInObject = function(daa, _ba, aba)
        if cc and __a then
          if (_ba == nil) or (aba == nil) then
            return false
          end
          local bba, cba = daa:getAbsolutePosition()
          local dba, _ca = daa:getSize()
          if (bba <= _ba) and (bba + dba > _ba) and (cba <= aba) and (cba + _ca > aba) then
            return true
          end
        end
        return false
      end,
      mouseHandler = function(daa, _ba, aba, bba, cba)
        if daa:isCoordsInObject(aba, bba) then
          local dba, _ca = daa:getAbsolutePosition()
          local aca = caa:sendEvent('mouse_click', daa, 'mouse_click', _ba, aba - (dba - 1), bba - (_ca - 1), cba)
          if aca == false then
            return false
          end
          if daa.parent ~= nil then
            daa.parent:setFocusedObject(daa)
          end
          ad = true
          a_a = true
          b_a, c_a = aba, bba
          return true
        end
        return false
      end,
      mouseUpHandler = function(daa, _ba, aba, bba)
        a_a = false
        if ad then
          local cba, dba = daa:getAbsolutePosition()
          local _ca = caa:sendEvent('mouse_release', daa, 'mouse_release', _ba, aba - (cba - 1), bba - (dba - 1))
          ad = false
        end
        if daa:isCoordsInObject(aba, bba) then
          local cba, dba = daa:getAbsolutePosition()
          local _ca = caa:sendEvent('mouse_up', daa, 'mouse_up', _ba, aba - (cba - 1), bba - (dba - 1))
          if _ca == false then
            return false
          end
          return true
        end
        return false
      end,
      dragHandler = function(daa, _ba, aba, bba)
        if a_a then
          local cba, dba = daa:getAbsolutePosition()
          local _ca = caa:sendEvent(
            'mouse_drag',
            daa,
            'mouse_drag',
            _ba,
            aba - (cba - 1),
            bba - (dba - 1),
            b_a - aba,
            c_a - bba,
            aba,
            bba
          )
          b_a, c_a = aba, bba
          if _ca ~= nil then
            return _ca
          end
          if daa.parent ~= nil then
            daa.parent:setFocusedObject(daa)
          end
          return true
        end
        if daa:isCoordsInObject(aba, bba) then
          local cba, dba = daa:getAbsolutePosition(daa:getAnchorPosition())
          b_a, c_a = aba, bba
          d_a, _aa = cba - aba, dba - bba
        end
        return false
      end,
      scrollHandler = function(daa, _ba, aba, bba)
        if daa:isCoordsInObject(aba, bba) then
          local cba, dba = daa:getAbsolutePosition()
          local _ca = caa:sendEvent('mouse_scroll', daa, 'mouse_scroll', _ba, aba - (cba - 1), bba - (dba - 1))
          if _ca == false then
            return false
          end
          if daa.parent ~= nil then
            daa.parent:setFocusedObject(daa)
          end
          return true
        end
        return false
      end,
      hoverHandler = function(daa, _ba, aba, bba)
        if daa:isCoordsInObject(_ba, aba) then
          local cba = caa:sendEvent('mouse_hover', daa, 'mouse_hover', _ba, aba, bba)
          if cba == false then
            return false
          end
          _d = true
          return true
        end
        if _d then
          local cba = caa:sendEvent('mouse_leave', daa, 'mouse_leave', _ba, aba, bba)
          if cba == false then
            return false
          end
          _d = false
        end
        return false
      end,
      keyHandler = function(daa, _ba, aba)
        if __a and cc then
          if daa:isFocused() then
            local bba = caa:sendEvent('key', daa, 'key', _ba, aba)
            if bba == false then
              return false
            end
            return true
          end
        end
        return false
      end,
      keyUpHandler = function(daa, _ba)
        if __a and cc then
          if daa:isFocused() then
            local aba = caa:sendEvent('key_up', daa, 'key_up', _ba)
            if aba == false then
              return false
            end
            return true
          end
        end
        return false
      end,
      charHandler = function(daa, _ba)
        if __a and cc then
          if daa:isFocused() then
            local aba = caa:sendEvent('char', daa, 'char', _ba)
            if aba == false then
              return false
            end
            return true
          end
        end
        return false
      end,
      valueChangedHandler = function(daa)
        caa:sendEvent('value_changed', daa, _c)
      end,
      eventHandler = function(daa, _ba, aba, bba, cba, dba)
        local _ca = caa:sendEvent('other_event', daa, _ba, aba, bba, cba, dba)
        if _ca ~= nil then
          return _ca
        end
        return true
      end,
      getFocusHandler = function(daa)
        local _ba = caa:sendEvent('get_focus', daa)
        if _ba ~= nil then
          return _ba
        end
        return true
      end,
      loseFocusHandler = function(daa)
        a_a = false
        local _ba = caa:sendEvent('lose_focus', daa)
        if _ba ~= nil then
          return _ba
        end
        return true
      end,
      init = function(daa)
        if daa.parent ~= nil then
          for _ba, aba in pairs(baa) do
            if aba then
              daa.parent:addEvent(_ba, daa)
            end
          end
        end
        if not dc then
          dc = true
          return true
        end
        return false
      end,
    }
    cb.__index = cb
    return cb
  end
end
project['default']['theme'] = function(...)
  return {
    BasaltBG = colors.lightGray,
    BasaltText = colors.black,
    FrameBG = colors.gray,
    FrameText = colors.black,
    ButtonBG = colors.gray,
    ButtonText = colors.black,
    CheckboxBG = colors.gray,
    CheckboxText = colors.black,
    InputBG = colors.gray,
    InputText = colors.black,
    TextfieldBG = colors.gray,
    TextfieldText = colors.black,
    ListBG = colors.gray,
    ListText = colors.black,
    MenubarBG = colors.gray,
    MenubarText = colors.black,
    DropdownBG = colors.gray,
    DropdownText = colors.black,
    RadioBG = colors.gray,
    RadioText = colors.black,
    SelectionBG = colors.black,
    SelectionText = colors.lightGray,
    GraphicBG = colors.black,
    ImageBG = colors.black,
    PaneBG = colors.black,
    ProgramBG = colors.black,
    ProgressbarBG = colors.gray,
    ProgressbarText = colors.black,
    ProgressbarActiveBG = colors.black,
    ScrollbarBG = colors.lightGray,
    ScrollbarText = colors.gray,
    ScrollbarSymbolColor = colors.black,
    SliderBG = false,
    SliderText = colors.gray,
    SliderSymbolColor = colors.black,
    SwitchBG = colors.lightGray,
    SwitchText = colors.gray,
    SwitchBGSymbol = colors.black,
    SwitchInactive = colors.red,
    SwitchActive = colors.green,
    LabelBG = false,
    LabelText = colors.black,
  }
end
local cda = require 'basaltEvent'()
local dda = require 'Frame'
local __b = require 'theme'
local a_b = require 'utils'
local b_b = require 'basaltLogs'
local c_b = a_b.uuid
local d_b = a_b.createText
local _ab = a_b.tableCount
local aab = 300
local bab = 50
local cab = term.current()
local dab = '1.6.2'
local _bb = fs.getDir ''
local abb, bbb, cbb, dbb, _cb, acb = {}, {}, {}, {}, {}, {}
local bcb, ccb, dcb, _db
local adb = {}
if not term.isColor or not term.isColor() then
  error('Basalt requires an advanced (golden) computer to run.', 0)
end
local function bdb()
  _db = false
  cab.clear()
  cab.setCursorPos(1, 1)
end
local cdb = function(_dc)
  cab.clear()
  cab.setBackgroundColor(colors.black)
  cab.setTextColor(colors.red)
  local adc, bdc = cab.getSize()
  if adb.logging then
    b_b(_dc, 'Error')
  end
  local cdc = d_b('Basalt error: ' .. _dc, adc)
  local ddc = 1
  for __d, a_d in pairs(cdc) do
    cab.setCursorPos(1, ddc)
    cab.write(a_d)
    ddc = ddc + 1
  end
  cab.setCursorPos(1, ddc + 1)
  _db = false
end
local function ddb(_dc)
  assert(_dc ~= 'function', 'Schedule needs a function in order to work!')
  return function(...)
    local adc = coroutine.create(_dc)
    local bdc, cdc = coroutine.resume(adc, ...)
    if bdc then
      table.insert(acb, adc)
    else
      cdb(cdc)
    end
  end
end
local __c = function(_dc, adc)
  _cb[_dc] = adc
end
local a_c = function(_dc)
  return _cb[_dc]
end
local b_c = function(_dc)
  __b = _dc
end
local c_c = function(_dc)
  return __b[_dc]
end
local d_c = {
  getMainFrame = function()
    return bcb
  end,
  setVariable = __c,
  getVariable = a_c,
  getTheme = c_c,
  setMainFrame = function(_dc)
    bcb = _dc
  end,
  getActiveFrame = function()
    return ccb
  end,
  setActiveFrame = function(_dc)
    ccb = _dc
  end,
  getFocusedObject = function()
    return dcb
  end,
  setFocusedObject = function(_dc)
    dcb = _dc
  end,
  getMonitorFrame = function(_dc)
    return cbb[_dc] or dbb[_dc][1]
  end,
  setMonitorFrame = function(_dc, adc, bdc)
    if bcb == adc then
      bcb = nil
    end
    if bdc then
      dbb[_dc] = { adc, sides }
    else
      cbb[_dc] = adc
    end
    if adc == nil then
      dbb[_dc] = nil
    end
  end,
  getBaseTerm = function()
    return cab
  end,
  schedule = ddb,
  stop = bdb,
  newFrame = dda,
  getDirectory = function()
    return _bb
  end,
}
local function _ac(_dc, adc, bdc, cdc, ddc)
  if #acb > 0 then
    local __d = {}
    for n = 1, #acb do
      if acb[n] ~= nil then
        if coroutine.status(acb[n]) == 'suspended' then
          local a_d, b_d = coroutine.resume(acb[n], _dc, adc, bdc, cdc, ddc)
          if not a_d then
            cdb(b_d)
          end
        else
          table.insert(__d, n)
        end
      end
    end
    for n = 1, #__d do
      table.remove(acb, __d[n] - (n - 1))
    end
  end
end
local function aac()
  if _db == false then
    return
  end
  if bcb ~= nil then
    bcb:draw()
    bcb:updateTerm()
  end
  for _dc, adc in pairs(cbb) do
    adc:draw()
    adc:updateTerm()
  end
  for _dc, adc in pairs(dbb) do
    adc[1]:draw()
    adc[1]:updateTerm()
  end
end
local bac, cac, dac = nil, nil, nil
local _bc = nil
local function abc(_dc, adc, bdc)
  bac, cac, dac = bac, adc, bdc
  if _bc == nil then
    _bc = os.startTimer(aab / 1000)
  end
end
local function bbc()
  _bc = nil
  bcb:hoverHandler(cac, dac, bac)
  ccb = bcb
end
local cbc, dbc, _cc = nil, nil, nil
local acc = nil
local function bcc()
  acc = nil
  bcb:dragHandler(cbc, dbc, _cc)
  ccb = bcb
end
local function ccc(_dc, adc, bdc)
  cbc, dbc, _cc = _dc, adc, bdc
  if bab < 50 then
    bcc()
  else
    if acc == nil then
      acc = os.startTimer(bab / 1000)
    end
  end
end
local function dcc(_dc, adc, bdc, cdc, ddc)
  if cda:sendEvent('basaltEventCycle', _dc, adc, bdc, cdc, ddc) == false then
    return
  end
  if bcb ~= nil then
    if _dc == 'mouse_click' then
      bcb:mouseHandler(adc, bdc, cdc, false)
      ccb = bcb
    elseif _dc == 'mouse_drag' then
      ccc(adc, bdc, cdc)
    elseif _dc == 'mouse_up' then
      bcb:mouseUpHandler(adc, bdc, cdc, ddc)
      ccb = bcb
    elseif _dc == 'mouse_scroll' then
      bcb:scrollHandler(adc, bdc, cdc, ddc)
      ccb = bcb
    elseif _dc == 'mouse_move' then
      abc(adc, bdc, cdc)
    end
  end
  if _dc == 'monitor_touch' then
    if cbb[adc] ~= nil then
      cbb[adc]:mouseHandler(1, bdc, cdc, true)
      ccb = cbb[adc]
    end
    if _ab(dbb) > 0 then
      for __d, a_d in pairs(dbb) do
        a_d[1]:mouseHandler(1, bdc, cdc, true, adc)
      end
    end
  end
  if _dc == 'char' then
    if ccb ~= nil then
      ccb:charHandler(adc)
    end
  end
  if _dc == 'key_up' then
    if ccb ~= nil then
      ccb:keyUpHandler(adc)
    end
    abb[adc] = false
  end
  if _dc == 'key' then
    if ccb ~= nil then
      ccb:keyHandler(adc, bdc)
    end
    abb[adc] = true
  end
  if _dc == 'terminate' then
    if ccb ~= nil then
      ccb:eventHandler(_dc)
      if _db == false then
        return
      end
    end
  end
  if

    (_dc ~= 'mouse_click')
    and (_dc ~= 'mouse_up')
    and (_dc ~= 'mouse_scroll')
    and (_dc ~= 'mouse_drag')
    and (_dc ~= 'mouse_move')
    and (_dc ~= 'key')
    and (_dc ~= 'key_up')
    and (_dc ~= 'char')
    and (_dc ~= 'terminate')
  then
    if (_dc == 'timer') and (adc == _bc) then
      bbc()
    elseif (_dc == 'timer') and (adc == acc) then
      bcc()
    else
      for __d, a_d in pairs(bbb) do
        a_d:eventHandler(_dc, adc, bdc, cdc, ddc)
      end
    end
  end
  _ac(_dc, adc, bdc, cdc, ddc)
  aac()
end
adb = {
  logging = false,
  setTheme = b_c,
  getTheme = c_c,
  drawFrames = aac,
  getVersion = function()
    return dab
  end,
  setVariable = __c,
  getVariable = a_c,
  setBaseTerm = function(_dc)
    cab = _dc
  end,
  log = function(...)
    b_b(...)
  end,
  setMouseMoveThrottle = function(_dc)
    if _HOST:find 'CraftOS%-PC' then
      if config.get 'mouse_move_throttle' ~= 10 then
        config.set('mouse_move_throttle', 10)
      end
      if _dc < 100 then
        aab = 100
      else
        aab = _dc
      end
      return true
    end
    return false
  end,
  setMouseDragThrottle = function(_dc)
    if _dc <= 0 then
      bab = 0
    else
      acc = nil
      bab = _dc
    end
  end,
  autoUpdate = function(_dc)
    _db = _dc
    if _dc == nil then
      _db = true
    end
    local function adc()
      aac()
      while _db do
        dcc(os.pullEventRaw())
      end
    end
    local bdc, cdc = xpcall(adc, debug.traceback)
    if not bdc then
      cdb(cdc)
      return
    end
  end,
  update = function(_dc, adc, bdc, cdc, ddc)
    if _dc ~= nil then
      local __d, a_d = xpcall(dcc, debug.traceback, _dc, adc, bdc, cdc, ddc)
      if not __d then
        cdb(a_d)
        return
      end
    end
  end,
  stop = bdb,
  stopUpdate = bdb,
  isKeyDown = function(_dc)
    if abb[_dc] == nil then
      return false
    end
    return abb[_dc]
  end,
  getFrame = function(_dc)
    for adc, bdc in pairs(bbb) do
      if bdc.name == _dc then
        return bdc
      end
    end
  end,
  getActiveFrame = function()
    return ccb
  end,
  setActiveFrame = function(_dc)
    if _dc:getType() == 'Frame' then
      ccb = _dc
      return true
    end
    return false
  end,
  onEvent = function(...)
    for _dc, adc in pairs(table.pack(...)) do
      if type(adc) == 'function' then
        cda:registerEvent('basaltEventCycle', adc)
      end
    end
  end,
  schedule = ddb,
  createFrame = function(_dc)
    _dc = _dc or c_b()
    for bdc, cdc in pairs(bbb) do
      if cdc.name == _dc then
        return nil
      end
    end
    local adc = dda(_dc, nil, nil, d_c)
    adc:init()
    table.insert(bbb, adc)
    if (bcb == nil) and (adc:getName() ~= 'basaltDebuggingFrame') then
      adc:show()
    end
    return adc
  end,
  removeFrame = function(_dc)
    bbb[_dc] = nil
  end,
  setProjectDir = function(_dc)
    _bb = _dc
  end,
  debug = function(...)
    local _dc = { ... }
    if bcb == nil then
      print(...)
      return
    end
    if bcb.name ~= 'basaltDebuggingFrame' then
      if bcb ~= adb.debugFrame then
        adb.debugLabel:setParent(bcb)
      end
    end
    local adc = ''
    for bdc, cdc in pairs(_dc) do
      adc = adc .. tostring(cdc) .. (#_dc ~= bdc and ', ' or '')
    end
    adb.debugLabel:setText('[Debug] ' .. adc)
    for bdc, cdc in pairs(d_b(adc, adb.debugList:getWidth())) do
      adb.debugList:addItem(cdc)
    end
    if adb.debugList:getItemCount() > 50 then
      adb.debugList:removeItem(1)
    end
    adb.debugList:setValue(adb.debugList:getItem(adb.debugList:getItemCount()))
    if adb.debugList.getItemCount() > adb.debugList:getHeight() then
      adb.debugList:setOffset(adb.debugList:getItemCount() - adb.debugList:getHeight())
    end
    adb.debugLabel:show()
  end,
}
adb.debugFrame = adb
  .createFrame('basaltDebuggingFrame')
  :showBar()
  :setBackground(colors.lightGray)
  :setBar('Debug', colors.black, colors.gray)
adb.debugFrame
  :addButton('back')
  :setAnchor('topRight')
  :setSize(1, 1)
  :setText('\22')
  :onClick(function()
    if adb.oldFrame ~= nil then
      adb.oldFrame:show()
    end
  end)
  :setBackground(colors.red)
  :show()
adb.debugList =
  adb.debugFrame:addList('debugList'):setSize('parent.w - 2', 'parent.h - 3'):setPosition(2, 3):setScrollable(true):show()
adb.debugLabel = adb.debugFrame
  :addLabel('debugLabel')
  :onClick(function()
    adb.oldFrame = bcb
    adb.debugFrame:show()
  end)
  :setBackground(colors.black)
  :setForeground(colors.white)
  :setAnchor('bottomLeft')
  :ignoreOffset()
  :setZIndex(20)
  :show()
return adb

end;
modules['packages/basalt.lua'].cache = null;
modules['packages/basalt.lua'].isCached = false;

----

modules['packages/base64.lua'] = {};
modules['packages/base64.lua'].load = function()
local __just_filename = 'base64.lua';
local __filename = 'packages/base64.lua';
local __dirname = 'packages';
local __hash = 'abb838d74919d0c924ed1acf353dcf667886b064e70a109c7bd514b0e96f38c168e23adf930d75cfc288dad437591d485b8a35ce11fa4f8dc08a8090956796bd';
-- @original: https://gist.github.com/Reselim/40d62b17d138cc74335a1b0709e19ce2
local Alphabet = {}
local Indexes = {}

-- A-Z
for Index = 65, 90 do
  table.insert(Alphabet, Index)
end

-- a-z
for Index = 97, 122 do
  table.insert(Alphabet, Index)
end

-- 0-9
for Index = 48, 57 do
  table.insert(Alphabet, Index)
end

table.insert(Alphabet, 43) -- +
table.insert(Alphabet, 47) -- /

for Index, Character in ipairs(Alphabet) do
  Indexes[Character] = Index
end

local Base64 = {}

local bit32_rshift = bit32.rshift
local bit32_lshift = bit32.lshift
local bit32_band = bit32.band

--[[**
	Encodes a string in Base64.
	@param [t:string] Input The input string to encode.
	@returns [t:string] The string encoded in Base64.
**--]]
function Base64.Encode(Input)
  local Output = {}
  local Length = 0

  for Index = 1, #Input, 3 do
    local C1, C2, C3 = string.byte(Input, Index, Index + 2)

    local A = bit32_rshift(C1, 2)
    local B = bit32_lshift(bit32_band(C1, 3), 4) + bit32_rshift(C2 or 0, 4)
    local C = bit32_lshift(bit32_band(C2 or 0, 15), 2) + bit32_rshift(C3 or 0, 6)
    local D = bit32_band(C3 or 0, 63)

    Length = Length + 1
    Output[Length] = Alphabet[A + 1]

    Length = Length + 1
    Output[Length] = Alphabet[B + 1]

    Length = Length + 1
    Output[Length] = C2 and Alphabet[C + 1] or 61

    Length = Length + 1
    Output[Length] = C3 and Alphabet[D + 1] or 61
  end

  local NewOutput = {}
  local NewLength = 0
  local IndexAdd4096Sub1

  for Index = 1, Length, 4096 do
    NewLength = NewLength + 1
    IndexAdd4096Sub1 = Index + 4096 - 1

    NewOutput[NewLength] = string.char(table.unpack(Output, Index, IndexAdd4096Sub1 > Length and Length or IndexAdd4096Sub1))
  end

  return table.concat(NewOutput)
end

--[[**
	Decodes a string from Base64.
	@param [t:string] Input The input string to decode.
	@returns [t:string] The newly decoded string.
**--]]
function Base64.Decode(Input)
  local Output = {}
  local Length = 0

  for Index = 1, #Input, 4 do
    local C1, C2, C3, C4 = string.byte(Input, Index, Index + 3)

    local I1 = Indexes[C1] - 1
    local I2 = Indexes[C2] - 1
    local I3 = (Indexes[C3] or 1) - 1
    local I4 = (Indexes[C4] or 1) - 1

    local A = bit32_lshift(I1, 2) + bit32_rshift(I2, 4)
    local B = bit32_lshift(bit32_band(I2, 15), 4) + bit32_rshift(I3, 2)
    local C = bit32_lshift(bit32_band(I3, 3), 6) + I4

    Length = Length + 1
    Output[Length] = A

    if C3 ~= 61 then
      Length = Length + 1
      Output[Length] = B
    end

    if C4 ~= 61 then
      Length = Length + 1
      Output[Length] = C
    end
  end

  local NewOutput = {}
  local NewLength = 0
  local IndexAdd4096Sub1

  for Index = 1, Length, 4096 do
    NewLength = NewLength + 1
    IndexAdd4096Sub1 = Index + 4096 - 1

    NewOutput[NewLength] = string.char(table.unpack(Output, Index, IndexAdd4096Sub1 > Length and Length or IndexAdd4096Sub1))
  end

  return table.concat(NewOutput)
end

return Base64

end;
modules['packages/base64.lua'].cache = null;
modules['packages/base64.lua'].isCached = false;

----

modules['packages/bitop.lua'] = {};
modules['packages/bitop.lua'].load = function()
local __just_filename = 'bitop.lua';
local __filename = 'packages/bitop.lua';
local __dirname = 'packages';
local __hash = '3eb8138fba20e6efce960c977bd8b3d0120aa7c230bc95a3ec462484610b8433d05a6035ad08c36f43925f6af3d63338fcde5ed1956391b382b49546ed9e245b';
-- https://github.com/AlberTajuelo/bitop-lua
-- MIT
-- im only using this for bxor but it may be useful for smth else one day :shrug:
local M = { _TYPE = 'module', _NAME = 'bitop.funcs', _VERSION = '1.0-0' }

local floor = math.floor

local MOD = 2 ^ 32
local MODM = MOD - 1

local function memoize(f)
  local mt = {}
  local t = setmetatable({}, mt)

  function mt:__index(k)
    local v = f(k)
    t[k] = v
    return v
  end

  return t
end

local function make_bitop_uncached(t, m)
  local function bitop(a, b)
    local res, p = 0, 1
    while a ~= 0 and b ~= 0 do
      local am, bm = a % m, b % m
      res = res + t[am][bm] * p
      a = (a - am) / m
      b = (b - bm) / m
      p = p * m
    end
    res = res + (a + b) * p
    return res
  end
  return bitop
end

local function make_bitop(t)
  local op1 = make_bitop_uncached(t, 2 ^ 1)
  local op2 = memoize(function(a)
    return memoize(function(b)
      return op1(a, b)
    end)
  end)
  return make_bitop_uncached(op2, 2 ^ (t.n or 1))
end

-- ok? probably not if running on a 32-bit int Lua number type platform
function M.tobit(x)
  return x % 2 ^ 32
end

M.bxor = make_bitop { [0] = { [0] = 0, [1] = 1 }, [1] = { [0] = 1, [1] = 0 }, n = 4 }
local bxor = M.bxor

function M.bnot(a)
  return MODM - a
end
local bnot = M.bnot

function M.band(a, b)
  return ((a + b) - bxor(a, b)) / 2
end
local band = M.band

function M.bor(a, b)
  return MODM - band(MODM - a, MODM - b)
end
local bor = M.bor

local lshift, rshift -- forward declare

function M.rshift(a, disp) -- Lua5.2 insipred
  if disp < 0 then
    return lshift(a, -disp)
  end
  return floor(a % 2 ^ 32 / 2 ^ disp)
end
rshift = M.rshift

function M.lshift(a, disp) -- Lua5.2 inspired
  if disp < 0 then
    return rshift(a, -disp)
  end
  return (a * 2 ^ disp) % 2 ^ 32
end
lshift = M.lshift

function M.tohex(x, n) -- BitOp style
  n = n or 8
  local up
  if n <= 0 then
    if n == 0 then
      return ''
    end
    up = true
    n = -n
  end
  x = band(x, 16 ^ n - 1)
  return ('%0' .. n .. (up and 'X' or 'x')):format(x)
end
local tohex = M.tohex

function M.extract(n, field, width) -- Lua5.2 inspired
  width = width or 1
  return band(rshift(n, field), 2 ^ width - 1)
end
local extract = M.extract

function M.replace(n, v, field, width) -- Lua5.2 inspired
  width = width or 1
  local mask1 = 2 ^ width - 1
  v = band(v, mask1) -- required by spec?
  local mask = bnot(lshift(mask1, field))
  return band(n, mask) + lshift(v, field)
end
local replace = M.replace

function M.bswap(x) -- BitOp style
  local a = band(x, 0xff)
  x = rshift(x, 8)
  local b = band(x, 0xff)
  x = rshift(x, 8)
  local c = band(x, 0xff)
  x = rshift(x, 8)
  local d = band(x, 0xff)
  return lshift(lshift(lshift(a, 8) + b, 8) + c, 8) + d
end
local bswap = M.bswap

function M.rrotate(x, disp) -- Lua5.2 inspired
  disp = disp % 32
  local low = band(x, 2 ^ disp - 1)
  return rshift(x, disp) + lshift(low, 32 - disp)
end
local rrotate = M.rrotate

function M.lrotate(x, disp) -- Lua5.2 inspired
  return rrotate(x, -disp)
end
local lrotate = M.lrotate

M.rol = M.lrotate -- LuaOp inspired
M.ror = M.rrotate -- LuaOp insipred

function M.arshift(x, disp) -- Lua5.2 inspired
  local z = rshift(x, disp)
  if x >= 0x80000000 then
    z = z + lshift(2 ^ disp - 1, 32 - disp)
  end
  return z
end
local arshift = M.arshift

function M.btest(x, y) -- Lua5.2 inspired
  return band(x, y) ~= 0
end

--
-- Start Lua 5.2 "bit32" compat section.
--

M.bit32 = {} -- Lua 5.2 'bit32' compatibility

local function bit32_bnot(x)
  return (-1 - x) % MOD
end
M.bit32.bnot = bit32_bnot

local function bit32_bxor(a, b, c, ...)
  local z
  if b then
    a = a % MOD
    b = b % MOD
    z = bxor(a, b)
    if c then
      z = bit32_bxor(z, c, ...)
    end
    return z
  elseif a then
    return a % MOD
  else
    return 0
  end
end
M.bit32.bxor = bit32_bxor

local function bit32_band(a, b, c, ...)
  local z
  if b then
    a = a % MOD
    b = b % MOD
    z = ((a + b) - bxor(a, b)) / 2
    if c then
      z = bit32_band(z, c, ...)
    end
    return z
  elseif a then
    return a % MOD
  else
    return MODM
  end
end
M.bit32.band = bit32_band

local function bit32_bor(a, b, c, ...)
  local z
  if b then
    a = a % MOD
    b = b % MOD
    z = MODM - band(MODM - a, MODM - b)
    if c then
      z = bit32_bor(z, c, ...)
    end
    return z
  elseif a then
    return a % MOD
  else
    return 0
  end
end
M.bit32.bor = bit32_bor

function M.bit32.btest(...)
  return bit32_band(...) ~= 0
end

function M.bit32.lrotate(x, disp)
  return lrotate(x % MOD, disp)
end

function M.bit32.rrotate(x, disp)
  return rrotate(x % MOD, disp)
end

function M.bit32.lshift(x, disp)
  if disp > 31 or disp < -31 then
    return 0
  end
  return lshift(x % MOD, disp)
end

function M.bit32.rshift(x, disp)
  if disp > 31 or disp < -31 then
    return 0
  end
  return rshift(x % MOD, disp)
end

function M.bit32.arshift(x, disp)
  x = x % MOD
  if disp >= 0 then
    if disp > 31 then
      return (x >= 0x80000000) and MODM or 0
    else
      local z = rshift(x, disp)
      if x >= 0x80000000 then
        z = z + lshift(2 ^ disp - 1, 32 - disp)
      end
      return z
    end
  else
    return lshift(x, -disp)
  end
end

function M.bit32.extract(x, field, ...)
  local width = ... or 1
  if field < 0 or field > 31 or width < 0 or field + width > 32 then
    error 'out of range'
  end
  x = x % MOD
  return extract(x, field, ...)
end

function M.bit32.replace(x, v, field, ...)
  local width = ... or 1
  if field < 0 or field > 31 or width < 0 or field + width > 32 then
    error 'out of range'
  end
  x = x % MOD
  v = v % MOD
  return replace(x, v, field, ...)
end

--
-- Start LuaBitOp "bit" compat section.
--

M.bit = {} -- LuaBitOp "bit" compatibility

function M.bit.tobit(x)
  x = x % MOD
  if x >= 0x80000000 then
    x = x - MOD
  end
  return x
end
local bit_tobit = M.bit.tobit

function M.bit.tohex(x, ...)
  return tohex(x % MOD, ...)
end

function M.bit.bnot(x)
  return bit_tobit(bnot(x % MOD))
end

local function bit_bor(a, b, c, ...)
  if c then
    return bit_bor(bit_bor(a, b), c, ...)
  elseif b then
    return bit_tobit(bor(a % MOD, b % MOD))
  else
    return bit_tobit(a)
  end
end
M.bit.bor = bit_bor

local function bit_band(a, b, c, ...)
  if c then
    return bit_band(bit_band(a, b), c, ...)
  elseif b then
    return bit_tobit(band(a % MOD, b % MOD))
  else
    return bit_tobit(a)
  end
end
M.bit.band = bit_band

local function bit_bxor(a, b, c, ...)
  if c then
    return bit_bxor(bit_bxor(a, b), c, ...)
  elseif b then
    return bit_tobit(bxor(a % MOD, b % MOD))
  else
    return bit_tobit(a)
  end
end
M.bit.bxor = bit_bxor

function M.bit.lshift(x, n)
  return bit_tobit(lshift(x % MOD, n % 32))
end

function M.bit.rshift(x, n)
  return bit_tobit(rshift(x % MOD, n % 32))
end

function M.bit.arshift(x, n)
  return bit_tobit(arshift(x % MOD, n % 32))
end

function M.bit.rol(x, n)
  return bit_tobit(lrotate(x % MOD, n % 32))
end

function M.bit.ror(x, n)
  return bit_tobit(rrotate(x % MOD, n % 32))
end

function M.bit.bswap(x)
  return bit_tobit(bswap(x % MOD))
end

return M

end;
modules['packages/bitop.lua'].cache = null;
modules['packages/bitop.lua'].isCached = false;

----

modules['packages/child_process.lua'] = {};
modules['packages/child_process.lua'].load = function()
local __just_filename = 'child_process.lua';
local __filename = 'packages/child_process.lua';
local __dirname = 'packages';
local __hash = 'd4d9127b6d57470743431b879789e451653aa26ade0fc0440567f71aefbaddd05601ce4fcf995065ff2ebe3c70eb5c88c380ea8d1bc7015a06f330e14d75b5fc';
---@diagnostic disable: deprecated
local cid = 0
return {
  ['execSync'] = function(process, ...)
    error 'non-functional as of now'
    -- return shell.execute(process, ...)
  end,
  ['execLuaSync'] = function(lua, chunk)
    cid = cid + 1
    local c, ex = loadstring(lua, chunk or ('Unknown Chunk Name - Chunk #' .. tostring(cid)))
    if not c then
      error('Compilation Error: ' .. ex)
    end
    return c()
  end,
}

end;
modules['packages/child_process.lua'].cache = null;
modules['packages/child_process.lua'].isCached = false;

----

modules['packages/console.lua'] = {};
modules['packages/console.lua'].load = function()
local __just_filename = 'console.lua';
local __filename = 'packages/console.lua';
local __dirname = 'packages';
local __hash = '4680436d6f199fd8fcb61ecc496c4bf33dbe7448eb2eefe36f8d0ab419726c0183db12921807d96b6d921011909418ca6d6ed8156e4a53ec2a0adee832c88a11';
-- attempt to reimplement the js console api
return {
  ['clear'] = function()
    term.clear()
    term.setCursorPos(1, 1)
  end,
  ['log'] = print,
  -- todo replace with colour variants if term.isColour()
  ['warn'] = print,
  ['error'] = print,
  -- custom apis
  ['centerLog'] = function(text)
    local sizeX, sizeY = term.getSize()
    local _, guaranteedNewlines = text:gsub('\n', '')
    term.setCursorPos(
      math.floor(sizeX / 2) - math.floor(#text / 2),
      math.floor(sizeY / 2) - math.floor(guaranteedNewlines / 2)
    )
    print(text)
  end,
  ['logNoNl'] = function(text)
    local x, y = term.getCursorPos()
    term.write(text)
    term.setCursorPos(x + #text, y)
  end,
}

end;
modules['packages/console.lua'].cache = null;
modules['packages/console.lua'].isCached = false;

----

modules['packages/forceyield.lua'] = {};
modules['packages/forceyield.lua'].load = function()
local __just_filename = 'forceyield.lua';
local __filename = 'packages/forceyield.lua';
local __dirname = 'packages';
local __hash = 'eb04b7f3c25eb022ecf4eb6d4cd49852ba4d34df8f91b9a51667256940f57f740f52dc3c6b3e3630b96f26bc12fee62fb72ed3f7ecc9608960b9727b447b964a';
return function()
  os.queueEvent 'fakeEvent'
  os.pullEvent()
end

end;
modules['packages/forceyield.lua'].cache = null;
modules['packages/forceyield.lua'].isCached = false;

----

modules['packages/hash.lua'] = {};
modules['packages/hash.lua'].load = function()
local __just_filename = 'hash.lua';
local __filename = 'packages/hash.lua';
local __dirname = 'packages';
local __hash = '634545ee941dd77783331999bdf495b4922468b96b61595d91f7b6bb76a09319f23ec27b6cf379889b8fd528366d47aa45563bcf1f5a3bfe2e5f5cbb385b3d66';
--[=[------------------------------------------------------------------------------------------------------------------------
-- HashLib by Egor Skriptunoff, boatbomber, and howmanysmall

Documentation here: https://devforum.roblox.com/t/open-source-hashlib/416732/1

--------------------------------------------------------------------------------------------------------------------------

Module was originally written by Egor Skriptunoff and distributed under an MIT license.
It can be found here: https://github.com/Egor-Skriptunoff/pure_lua_SHA/blob/master/sha2.lua

That version was around 3000 lines long, and supported Lua versions 5.1, 5.2, 5.3, and 5.4, and LuaJIT.
Although that is super cool, Roblox only uses Lua 5.1, so that was extreme overkill.

I, boatbomber, worked to port it to Roblox in a way that doesn't overcomplicate it with support of unreachable
cases. Then, howmanysmall did some final optimizations that really squeeze out all the performance possible.
It's gotten stupid fast, thanks to her!

After quite a bit of work and benchmarking, this is what we were left with.
Enjoy!

--------------------------------------------------------------------------------------------------------------------------

DESCRIPTION:
	This module contains functions to calculate SHA digest:
		MD5, SHA-1,
		SHA-224, SHA-256, SHA-512/224, SHA-512/256, SHA-384, SHA-512,
		SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128, SHAKE256,
		HMAC
	Additionally, it has a few extra utility functions:
		hex_to_bin
		base64_to_bin
		bin_to_base64
	Written in pure Lua.
USAGE:
	Input data should be a string
	Result (SHA digest) is returned in hexadecimal representation as a string of lowercase hex digits.
	Simplest usage example:
		local HashLib = require(script.HashLib)
		local your_hash = HashLib.sha256("your string")
API:
		HashLib.md5
		HashLib.sha1
	SHA2 hash functions:
		HashLib.sha224
		HashLib.sha256
		HashLib.sha512_224
		HashLib.sha512_256
		HashLib.sha384
		HashLib.sha512
	SHA3 hash functions:
		HashLib.sha3_224
		HashLib.sha3_256
		HashLib.sha3_384
		HashLib.sha3_512
		HashLib.shake128
		HashLib.shake256
	Misc utilities:
		HashLib.hmac (Applicable to any hash function from this module except SHAKE*)
		HashLib.hex_to_bin
		HashLib.base64_to_bin
		HashLib.bin_to_base64

--]=]
---------------------------------------------------------------------------

local Base64 = require 'base64'

--------------------------------------------------------------------------------
-- LOCALIZATION FOR VM OPTIMIZATIONS
--------------------------------------------------------------------------------

local ipairs = ipairs

--------------------------------------------------------------------------------
-- 32-BIT BITWISE FUNCTIONS
--------------------------------------------------------------------------------
-- Only low 32 bits of function arguments matter, high bits are ignored
-- The result of all functions (except HEX) is an integer inside "correct range":
-- for "bit" library:    (-TWO_POW_31)..(TWO_POW_31-1)
-- for "bit32" library:        0..(TWO_POW_32-1)
local bit32_band = bit32.band -- 2 arguments
local bit32_bor = bit32.bor -- 2 arguments
local bit32_bxor = bit32.bxor -- 2..5 arguments
local bit32_lshift = bit32.lshift -- second argument is integer 0..31
local bit32_rshift = bit32.rshift -- second argument is integer 0..31
local bit32_lrotate = bit32.lrotate -- second argument is integer 0..31
local bit32_rrotate = bit32.rrotate -- second argument is integer 0..31

--------------------------------------------------------------------------------
-- CREATING OPTIMIZED INNER LOOP
--------------------------------------------------------------------------------
-- Arrays of SHA2 "magic numbers" (in "INT64" and "FFI" branches "*_lo" arrays contain 64-bit values)
local sha2_K_lo, sha2_K_hi, sha2_H_lo, sha2_H_hi, sha3_RC_lo, sha3_RC_hi = {}, {}, {}, {}, {}, {}
local sha2_H_ext256 = {
  [224] = {},
  [256] = sha2_H_hi,
}

local sha2_H_ext512_lo, sha2_H_ext512_hi = {
  [384] = {},
  [512] = sha2_H_lo,
}, {
  [384] = {},
  [512] = sha2_H_hi,
}

local md5_K, md5_sha1_H = {}, { 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0 }
local md5_next_shift = {
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  28,
  25,
  26,
  27,
  0,
  0,
  10,
  9,
  11,
  12,
  0,
  15,
  16,
  17,
  18,
  0,
  20,
  22,
  23,
  21,
}
local HEX64, XOR64A5, lanes_index_base -- defined only for branches that internally use 64-bit integers: "INT64" and "FFI"
local common_W = {} -- temporary table shared between all calculations (to avoid creating new temporary table every time)
local K_lo_modulo, hi_factor, hi_factor_keccak = 4294967296, 0, 0

local TWO_POW_NEG_56 = 2 ^ -56
local TWO_POW_NEG_17 = 2 ^ -17

local TWO_POW_2 = 2 ^ 2
local TWO_POW_3 = 2 ^ 3
local TWO_POW_4 = 2 ^ 4
local TWO_POW_5 = 2 ^ 5
local TWO_POW_6 = 2 ^ 6
local TWO_POW_7 = 2 ^ 7
local TWO_POW_8 = 2 ^ 8
local TWO_POW_9 = 2 ^ 9
local TWO_POW_10 = 2 ^ 10
local TWO_POW_11 = 2 ^ 11
local TWO_POW_12 = 2 ^ 12
local TWO_POW_13 = 2 ^ 13
local TWO_POW_14 = 2 ^ 14
local TWO_POW_15 = 2 ^ 15
local TWO_POW_16 = 2 ^ 16
local TWO_POW_17 = 2 ^ 17
local TWO_POW_18 = 2 ^ 18
local TWO_POW_19 = 2 ^ 19
local TWO_POW_20 = 2 ^ 20
local TWO_POW_21 = 2 ^ 21
local TWO_POW_22 = 2 ^ 22
local TWO_POW_23 = 2 ^ 23
local TWO_POW_24 = 2 ^ 24
local TWO_POW_25 = 2 ^ 25
local TWO_POW_26 = 2 ^ 26
local TWO_POW_27 = 2 ^ 27
local TWO_POW_28 = 2 ^ 28
local TWO_POW_29 = 2 ^ 29
local TWO_POW_30 = 2 ^ 30
local TWO_POW_31 = 2 ^ 31
local TWO_POW_32 = 2 ^ 32
local TWO_POW_40 = 2 ^ 40

local TWO56_POW_7 = 256 ^ 7

-- Implementation for Lua 5.1/5.2 (with or without bitwise library available)
local function sha256_feed_64(H, str, offs, size)
  -- offs >= 0, size >= 0, size is multiple of 64
  local W, K = common_W, sha2_K_hi
  local h1, h2, h3, h4, h5, h6, h7, h8 = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
  for pos = offs, offs + size - 1, 64 do
    for j = 1, 16 do
      pos = pos + 4
      local a, b, c, d = string.byte(str, pos - 3, pos)
      W[j] = ((a * 256 + b) * 256 + c) * 256 + d
    end

    for j = 17, 64 do
      local a, b = W[j - 15], W[j - 2]
      W[j] = bit32_bxor(bit32_rrotate(a, 7), bit32_lrotate(a, 14), bit32_rshift(a, 3))
        + bit32_bxor(bit32_lrotate(b, 15), bit32_lrotate(b, 13), bit32_rshift(b, 10))
        + W[j - 7]
        + W[j - 16]
    end

    local a, b, c, d, e, f, g, h = h1, h2, h3, h4, h5, h6, h7, h8
    for j = 1, 64 do
      local z = bit32_bxor(bit32_rrotate(e, 6), bit32_rrotate(e, 11), bit32_lrotate(e, 7))
        + bit32_band(e, f)
        + bit32_band(-1 - e, g)
        + h
        + K[j]
        + W[j]
      h = g
      g = f
      f = e
      e = z + d
      d = c
      c = b
      b = a
      a = z
        + bit32_band(d, c)
        + bit32_band(a, bit32_bxor(d, c))
        + bit32_bxor(bit32_rrotate(a, 2), bit32_rrotate(a, 13), bit32_lrotate(a, 10))
    end

    h1, h2, h3, h4 = (a + h1) % 4294967296, (b + h2) % 4294967296, (c + h3) % 4294967296, (d + h4) % 4294967296
    h5, h6, h7, h8 = (e + h5) % 4294967296, (f + h6) % 4294967296, (g + h7) % 4294967296, (h + h8) % 4294967296
  end

  H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8] = h1, h2, h3, h4, h5, h6, h7, h8
end

local function sha512_feed_128(H_lo, H_hi, str, offs, size)
  -- offs >= 0, size >= 0, size is multiple of 128
  -- W1_hi, W1_lo, W2_hi, W2_lo, ...   Wk_hi = W[2*k-1], Wk_lo = W[2*k]
  local W, K_lo, K_hi = common_W, sha2_K_lo, sha2_K_hi
  local h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo =
    H_lo[1], H_lo[2], H_lo[3], H_lo[4], H_lo[5], H_lo[6], H_lo[7], H_lo[8]
  local h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi =
    H_hi[1], H_hi[2], H_hi[3], H_hi[4], H_hi[5], H_hi[6], H_hi[7], H_hi[8]
  for pos = offs, offs + size - 1, 128 do
    for j = 1, 16 * 2 do
      pos = pos + 4
      local a, b, c, d = string.byte(str, pos - 3, pos)
      W[j] = ((a * 256 + b) * 256 + c) * 256 + d
    end

    for jj = 34, 160, 2 do
      local a_lo, a_hi, b_lo, b_hi = W[jj - 30], W[jj - 31], W[jj - 4], W[jj - 5]
      local tmp1 = bit32_bxor(
        bit32_rshift(a_lo, 1) + bit32_lshift(a_hi, 31),
        bit32_rshift(a_lo, 8) + bit32_lshift(a_hi, 24),
        bit32_rshift(a_lo, 7) + bit32_lshift(a_hi, 25)
      ) % 4294967296 + bit32_bxor(
        bit32_rshift(b_lo, 19) + bit32_lshift(b_hi, 13),
        bit32_lshift(b_lo, 3) + bit32_rshift(b_hi, 29),
        bit32_rshift(b_lo, 6) + bit32_lshift(b_hi, 26)
      ) % 4294967296 + W[jj - 14] + W[jj - 32]

      local tmp2 = tmp1 % 4294967296
      W[jj - 1] = bit32_bxor(
        bit32_rshift(a_hi, 1) + bit32_lshift(a_lo, 31),
        bit32_rshift(a_hi, 8) + bit32_lshift(a_lo, 24),
        bit32_rshift(a_hi, 7)
      ) + bit32_bxor(
        bit32_rshift(b_hi, 19) + bit32_lshift(b_lo, 13),
        bit32_lshift(b_hi, 3) + bit32_rshift(b_lo, 29),
        bit32_rshift(b_hi, 6)
      ) + W[jj - 15] + W[jj - 33] + (tmp1 - tmp2) / 4294967296

      W[jj] = tmp2
    end

    local a_lo, b_lo, c_lo, d_lo, e_lo, f_lo, g_lo, h_lo = h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo
    local a_hi, b_hi, c_hi, d_hi, e_hi, f_hi, g_hi, h_hi = h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi
    for j = 1, 80 do
      local jj = 2 * j
      local tmp1 = bit32_bxor(
        bit32_rshift(e_lo, 14) + bit32_lshift(e_hi, 18),
        bit32_rshift(e_lo, 18) + bit32_lshift(e_hi, 14),
        bit32_lshift(e_lo, 23) + bit32_rshift(e_hi, 9)
      ) % 4294967296 + (bit32_band(e_lo, f_lo) + bit32_band(-1 - e_lo, g_lo)) % 4294967296 + h_lo + K_lo[j] + W[jj]

      local z_lo = tmp1 % 4294967296
      local z_hi = bit32_bxor(
        bit32_rshift(e_hi, 14) + bit32_lshift(e_lo, 18),
        bit32_rshift(e_hi, 18) + bit32_lshift(e_lo, 14),
        bit32_lshift(e_hi, 23) + bit32_rshift(e_lo, 9)
      ) + bit32_band(e_hi, f_hi) + bit32_band(-1 - e_hi, g_hi) + h_hi + K_hi[j] + W[jj - 1] + (tmp1 - z_lo) / 4294967296

      h_lo = g_lo
      h_hi = g_hi
      g_lo = f_lo
      g_hi = f_hi
      f_lo = e_lo
      f_hi = e_hi
      tmp1 = z_lo + d_lo
      e_lo = tmp1 % 4294967296
      e_hi = z_hi + d_hi + (tmp1 - e_lo) / 4294967296
      d_lo = c_lo
      d_hi = c_hi
      c_lo = b_lo
      c_hi = b_hi
      b_lo = a_lo
      b_hi = a_hi
      tmp1 = z_lo
        + (bit32_band(d_lo, c_lo) + bit32_band(b_lo, bit32_bxor(d_lo, c_lo))) % 4294967296
        + bit32_bxor(
            bit32_rshift(b_lo, 28) + bit32_lshift(b_hi, 4),
            bit32_lshift(b_lo, 30) + bit32_rshift(b_hi, 2),
            bit32_lshift(b_lo, 25) + bit32_rshift(b_hi, 7)
          )
          % 4294967296
      a_lo = tmp1 % 4294967296
      a_hi = z_hi
        + (bit32_band(d_hi, c_hi) + bit32_band(b_hi, bit32_bxor(d_hi, c_hi)))
        + bit32_bxor(
          bit32_rshift(b_hi, 28) + bit32_lshift(b_lo, 4),
          bit32_lshift(b_hi, 30) + bit32_rshift(b_lo, 2),
          bit32_lshift(b_hi, 25) + bit32_rshift(b_lo, 7)
        )
        + (tmp1 - a_lo) / 4294967296
    end

    a_lo = h1_lo + a_lo
    h1_lo = a_lo % 4294967296
    h1_hi = (h1_hi + a_hi + (a_lo - h1_lo) / 4294967296) % 4294967296
    a_lo = h2_lo + b_lo
    h2_lo = a_lo % 4294967296
    h2_hi = (h2_hi + b_hi + (a_lo - h2_lo) / 4294967296) % 4294967296
    a_lo = h3_lo + c_lo
    h3_lo = a_lo % 4294967296
    h3_hi = (h3_hi + c_hi + (a_lo - h3_lo) / 4294967296) % 4294967296
    a_lo = h4_lo + d_lo
    h4_lo = a_lo % 4294967296
    h4_hi = (h4_hi + d_hi + (a_lo - h4_lo) / 4294967296) % 4294967296
    a_lo = h5_lo + e_lo
    h5_lo = a_lo % 4294967296
    h5_hi = (h5_hi + e_hi + (a_lo - h5_lo) / 4294967296) % 4294967296
    a_lo = h6_lo + f_lo
    h6_lo = a_lo % 4294967296
    h6_hi = (h6_hi + f_hi + (a_lo - h6_lo) / 4294967296) % 4294967296
    a_lo = h7_lo + g_lo
    h7_lo = a_lo % 4294967296
    h7_hi = (h7_hi + g_hi + (a_lo - h7_lo) / 4294967296) % 4294967296
    a_lo = h8_lo + h_lo
    h8_lo = a_lo % 4294967296
    h8_hi = (h8_hi + h_hi + (a_lo - h8_lo) / 4294967296) % 4294967296
  end

  H_lo[1], H_lo[2], H_lo[3], H_lo[4], H_lo[5], H_lo[6], H_lo[7], H_lo[8] =
    h1_lo, h2_lo, h3_lo, h4_lo, h5_lo, h6_lo, h7_lo, h8_lo
  H_hi[1], H_hi[2], H_hi[3], H_hi[4], H_hi[5], H_hi[6], H_hi[7], H_hi[8] =
    h1_hi, h2_hi, h3_hi, h4_hi, h5_hi, h6_hi, h7_hi, h8_hi
end

local function md5_feed_64(H, str, offs, size)
  -- offs >= 0, size >= 0, size is multiple of 64
  local W, K, md5_next_shift = common_W, md5_K, md5_next_shift
  local h1, h2, h3, h4 = H[1], H[2], H[3], H[4]
  for pos = offs, offs + size - 1, 64 do
    for j = 1, 16 do
      pos = pos + 4
      local a, b, c, d = string.byte(str, pos - 3, pos)
      W[j] = ((d * 256 + c) * 256 + b) * 256 + a
    end

    local a, b, c, d = h1, h2, h3, h4
    local s = 25
    for j = 1, 16 do
      local F = bit32_rrotate(bit32_band(b, c) + bit32_band(-1 - b, d) + a + K[j] + W[j], s) + b
      s = md5_next_shift[s]
      a = d
      d = c
      c = b
      b = F
    end

    s = 27
    for j = 17, 32 do
      local F = bit32_rrotate(bit32_band(d, b) + bit32_band(-1 - d, c) + a + K[j] + W[(5 * j - 4) % 16 + 1], s) + b
      s = md5_next_shift[s]
      a = d
      d = c
      c = b
      b = F
    end

    s = 28
    for j = 33, 48 do
      local F = bit32_rrotate(bit32_bxor(bit32_bxor(b, c), d) + a + K[j] + W[(3 * j + 2) % 16 + 1], s) + b
      s = md5_next_shift[s]
      a = d
      d = c
      c = b
      b = F
    end

    s = 26
    for j = 49, 64 do
      local F = bit32_rrotate(bit32_bxor(c, bit32_bor(b, -1 - d)) + a + K[j] + W[(j * 7 - 7) % 16 + 1], s) + b
      s = md5_next_shift[s]
      a = d
      d = c
      c = b
      b = F
    end

    h1 = (a + h1) % 4294967296
    h2 = (b + h2) % 4294967296
    h3 = (c + h3) % 4294967296
    h4 = (d + h4) % 4294967296
  end

  H[1], H[2], H[3], H[4] = h1, h2, h3, h4
end

local function sha1_feed_64(H, str, offs, size)
  -- offs >= 0, size >= 0, size is multiple of 64
  local W = common_W
  local h1, h2, h3, h4, h5 = H[1], H[2], H[3], H[4], H[5]
  for pos = offs, offs + size - 1, 64 do
    for j = 1, 16 do
      pos = pos + 4
      local a, b, c, d = string.byte(str, pos - 3, pos)
      W[j] = ((a * 256 + b) * 256 + c) * 256 + d
    end

    for j = 17, 80 do
      W[j] = bit32_lrotate(bit32_bxor(W[j - 3], W[j - 8], W[j - 14], W[j - 16]), 1)
    end

    local a, b, c, d, e = h1, h2, h3, h4, h5
    for j = 1, 20 do
      local z = bit32_lrotate(a, 5) + bit32_band(b, c) + bit32_band(-1 - b, d) + 0x5A827999 + W[j] + e -- constant = math.floor(TWO_POW_30 * sqrt(2))
      e = d
      d = c
      c = bit32_rrotate(b, 2)
      b = a
      a = z
    end

    for j = 21, 40 do
      local z = bit32_lrotate(a, 5) + bit32_bxor(b, c, d) + 0x6ED9EBA1 + W[j] + e -- TWO_POW_30 * sqrt(3)
      e = d
      d = c
      c = bit32_rrotate(b, 2)
      b = a
      a = z
    end

    for j = 41, 60 do
      local z = bit32_lrotate(a, 5) + bit32_band(d, c) + bit32_band(b, bit32_bxor(d, c)) + 0x8F1BBCDC + W[j] + e -- TWO_POW_30 * sqrt(5)
      e = d
      d = c
      c = bit32_rrotate(b, 2)
      b = a
      a = z
    end

    for j = 61, 80 do
      local z = bit32_lrotate(a, 5) + bit32_bxor(b, c, d) + 0xCA62C1D6 + W[j] + e -- TWO_POW_30 * sqrt(10)
      e = d
      d = c
      c = bit32_rrotate(b, 2)
      b = a
      a = z
    end

    h1 = (a + h1) % 4294967296
    h2 = (b + h2) % 4294967296
    h3 = (c + h3) % 4294967296
    h4 = (d + h4) % 4294967296
    h5 = (e + h5) % 4294967296
  end

  H[1], H[2], H[3], H[4], H[5] = h1, h2, h3, h4, h5
end

local function keccak_feed(lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes)
  -- This is an example of a Lua function having 79 local variables :-)
  -- offs >= 0, size >= 0, size is multiple of block_size_in_bytes, block_size_in_bytes is positive multiple of 8
  local RC_lo, RC_hi = sha3_RC_lo, sha3_RC_hi
  local qwords_qty = block_size_in_bytes / 8
  for pos = offs, offs + size - 1, block_size_in_bytes do
    for j = 1, qwords_qty do
      local a, b, c, d = string.byte(str, pos + 1, pos + 4)
      lanes_lo[j] = bit32_bxor(lanes_lo[j], ((d * 256 + c) * 256 + b) * 256 + a)
      pos = pos + 8
      a, b, c, d = string.byte(str, pos - 3, pos)
      lanes_hi[j] = bit32_bxor(lanes_hi[j], ((d * 256 + c) * 256 + b) * 256 + a)
    end

    local L01_lo, L01_hi, L02_lo, L02_hi, L03_lo, L03_hi, L04_lo, L04_hi, L05_lo, L05_hi, L06_lo, L06_hi, L07_lo, L07_hi, L08_lo, L08_hi, L09_lo, L09_hi, L10_lo, L10_hi, L11_lo, L11_hi, L12_lo, L12_hi, L13_lo, L13_hi, L14_lo, L14_hi, L15_lo, L15_hi, L16_lo, L16_hi, L17_lo, L17_hi, L18_lo, L18_hi, L19_lo, L19_hi, L20_lo, L20_hi, L21_lo, L21_hi, L22_lo, L22_hi, L23_lo, L23_hi, L24_lo, L24_hi, L25_lo, L25_hi =
      lanes_lo[1],
      lanes_hi[1],
      lanes_lo[2],
      lanes_hi[2],
      lanes_lo[3],
      lanes_hi[3],
      lanes_lo[4],
      lanes_hi[4],
      lanes_lo[5],
      lanes_hi[5],
      lanes_lo[6],
      lanes_hi[6],
      lanes_lo[7],
      lanes_hi[7],
      lanes_lo[8],
      lanes_hi[8],
      lanes_lo[9],
      lanes_hi[9],
      lanes_lo[10],
      lanes_hi[10],
      lanes_lo[11],
      lanes_hi[11],
      lanes_lo[12],
      lanes_hi[12],
      lanes_lo[13],
      lanes_hi[13],
      lanes_lo[14],
      lanes_hi[14],
      lanes_lo[15],
      lanes_hi[15],
      lanes_lo[16],
      lanes_hi[16],
      lanes_lo[17],
      lanes_hi[17],
      lanes_lo[18],
      lanes_hi[18],
      lanes_lo[19],
      lanes_hi[19],
      lanes_lo[20],
      lanes_hi[20],
      lanes_lo[21],
      lanes_hi[21],
      lanes_lo[22],
      lanes_hi[22],
      lanes_lo[23],
      lanes_hi[23],
      lanes_lo[24],
      lanes_hi[24],
      lanes_lo[25],
      lanes_hi[25]

    for round_idx = 1, 24 do
      local C1_lo = bit32_bxor(L01_lo, L06_lo, L11_lo, L16_lo, L21_lo)
      local C1_hi = bit32_bxor(L01_hi, L06_hi, L11_hi, L16_hi, L21_hi)
      local C2_lo = bit32_bxor(L02_lo, L07_lo, L12_lo, L17_lo, L22_lo)
      local C2_hi = bit32_bxor(L02_hi, L07_hi, L12_hi, L17_hi, L22_hi)
      local C3_lo = bit32_bxor(L03_lo, L08_lo, L13_lo, L18_lo, L23_lo)
      local C3_hi = bit32_bxor(L03_hi, L08_hi, L13_hi, L18_hi, L23_hi)
      local C4_lo = bit32_bxor(L04_lo, L09_lo, L14_lo, L19_lo, L24_lo)
      local C4_hi = bit32_bxor(L04_hi, L09_hi, L14_hi, L19_hi, L24_hi)
      local C5_lo = bit32_bxor(L05_lo, L10_lo, L15_lo, L20_lo, L25_lo)
      local C5_hi = bit32_bxor(L05_hi, L10_hi, L15_hi, L20_hi, L25_hi)

      local D_lo = bit32_bxor(C1_lo, C3_lo * 2 + (C3_hi % TWO_POW_32 - C3_hi % TWO_POW_31) / TWO_POW_31)
      local D_hi = bit32_bxor(C1_hi, C3_hi * 2 + (C3_lo % TWO_POW_32 - C3_lo % TWO_POW_31) / TWO_POW_31)

      local T0_lo = bit32_bxor(D_lo, L02_lo)
      local T0_hi = bit32_bxor(D_hi, L02_hi)
      local T1_lo = bit32_bxor(D_lo, L07_lo)
      local T1_hi = bit32_bxor(D_hi, L07_hi)
      local T2_lo = bit32_bxor(D_lo, L12_lo)
      local T2_hi = bit32_bxor(D_hi, L12_hi)
      local T3_lo = bit32_bxor(D_lo, L17_lo)
      local T3_hi = bit32_bxor(D_hi, L17_hi)
      local T4_lo = bit32_bxor(D_lo, L22_lo)
      local T4_hi = bit32_bxor(D_hi, L22_hi)

      L02_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_20) / TWO_POW_20 + T1_hi * TWO_POW_12
      L02_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_20) / TWO_POW_20 + T1_lo * TWO_POW_12
      L07_lo = (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_19) / TWO_POW_19 + T3_hi * TWO_POW_13
      L07_hi = (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_19) / TWO_POW_19 + T3_lo * TWO_POW_13
      L12_lo = T0_lo * 2 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_31) / TWO_POW_31
      L12_hi = T0_hi * 2 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_31) / TWO_POW_31
      L17_lo = T2_lo * TWO_POW_10 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_22) / TWO_POW_22
      L17_hi = T2_hi * TWO_POW_10 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_22) / TWO_POW_22
      L22_lo = T4_lo * TWO_POW_2 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_30) / TWO_POW_30
      L22_hi = T4_hi * TWO_POW_2 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_30) / TWO_POW_30

      D_lo = bit32_bxor(C2_lo, C4_lo * 2 + (C4_hi % TWO_POW_32 - C4_hi % TWO_POW_31) / TWO_POW_31)
      D_hi = bit32_bxor(C2_hi, C4_hi * 2 + (C4_lo % TWO_POW_32 - C4_lo % TWO_POW_31) / TWO_POW_31)

      T0_lo = bit32_bxor(D_lo, L03_lo)
      T0_hi = bit32_bxor(D_hi, L03_hi)
      T1_lo = bit32_bxor(D_lo, L08_lo)
      T1_hi = bit32_bxor(D_hi, L08_hi)
      T2_lo = bit32_bxor(D_lo, L13_lo)
      T2_hi = bit32_bxor(D_hi, L13_hi)
      T3_lo = bit32_bxor(D_lo, L18_lo)
      T3_hi = bit32_bxor(D_hi, L18_hi)
      T4_lo = bit32_bxor(D_lo, L23_lo)
      T4_hi = bit32_bxor(D_hi, L23_hi)

      L03_lo = (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_21) / TWO_POW_21 + T2_hi * TWO_POW_11
      L03_hi = (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_21) / TWO_POW_21 + T2_lo * TWO_POW_11
      L08_lo = (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_3) / TWO_POW_3 + T4_hi * TWO_POW_29 % TWO_POW_32
      L08_hi = (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_3) / TWO_POW_3 + T4_lo * TWO_POW_29 % TWO_POW_32
      L13_lo = T1_lo * TWO_POW_6 + (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_26) / TWO_POW_26
      L13_hi = T1_hi * TWO_POW_6 + (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_26) / TWO_POW_26
      L18_lo = T3_lo * TWO_POW_15 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_17) / TWO_POW_17
      L18_hi = T3_hi * TWO_POW_15 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_17) / TWO_POW_17
      L23_lo = (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_2) / TWO_POW_2 + T0_hi * TWO_POW_30 % TWO_POW_32
      L23_hi = (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_2) / TWO_POW_2 + T0_lo * TWO_POW_30 % TWO_POW_32

      D_lo = bit32_bxor(C3_lo, C5_lo * 2 + (C5_hi % TWO_POW_32 - C5_hi % TWO_POW_31) / TWO_POW_31)
      D_hi = bit32_bxor(C3_hi, C5_hi * 2 + (C5_lo % TWO_POW_32 - C5_lo % TWO_POW_31) / TWO_POW_31)

      T0_lo = bit32_bxor(D_lo, L04_lo)
      T0_hi = bit32_bxor(D_hi, L04_hi)
      T1_lo = bit32_bxor(D_lo, L09_lo)
      T1_hi = bit32_bxor(D_hi, L09_hi)
      T2_lo = bit32_bxor(D_lo, L14_lo)
      T2_hi = bit32_bxor(D_hi, L14_hi)
      T3_lo = bit32_bxor(D_lo, L19_lo)
      T3_hi = bit32_bxor(D_hi, L19_hi)
      T4_lo = bit32_bxor(D_lo, L24_lo)
      T4_hi = bit32_bxor(D_hi, L24_hi)

      L04_lo = T3_lo * TWO_POW_21 % TWO_POW_32 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_11) / TWO_POW_11
      L04_hi = T3_hi * TWO_POW_21 % TWO_POW_32 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_11) / TWO_POW_11
      L09_lo = T0_lo * TWO_POW_28 % TWO_POW_32 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_4) / TWO_POW_4
      L09_hi = T0_hi * TWO_POW_28 % TWO_POW_32 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_4) / TWO_POW_4
      L14_lo = T2_lo * TWO_POW_25 % TWO_POW_32 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_7) / TWO_POW_7
      L14_hi = T2_hi * TWO_POW_25 % TWO_POW_32 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_7) / TWO_POW_7
      L19_lo = (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_8) / TWO_POW_8 + T4_hi * TWO_POW_24 % TWO_POW_32
      L19_hi = (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_8) / TWO_POW_8 + T4_lo * TWO_POW_24 % TWO_POW_32
      L24_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_9) / TWO_POW_9 + T1_hi * TWO_POW_23 % TWO_POW_32
      L24_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_9) / TWO_POW_9 + T1_lo * TWO_POW_23 % TWO_POW_32

      D_lo = bit32_bxor(C4_lo, C1_lo * 2 + (C1_hi % TWO_POW_32 - C1_hi % TWO_POW_31) / TWO_POW_31)
      D_hi = bit32_bxor(C4_hi, C1_hi * 2 + (C1_lo % TWO_POW_32 - C1_lo % TWO_POW_31) / TWO_POW_31)

      T0_lo = bit32_bxor(D_lo, L05_lo)
      T0_hi = bit32_bxor(D_hi, L05_hi)
      T1_lo = bit32_bxor(D_lo, L10_lo)
      T1_hi = bit32_bxor(D_hi, L10_hi)
      T2_lo = bit32_bxor(D_lo, L15_lo)
      T2_hi = bit32_bxor(D_hi, L15_hi)
      T3_lo = bit32_bxor(D_lo, L20_lo)
      T3_hi = bit32_bxor(D_hi, L20_hi)
      T4_lo = bit32_bxor(D_lo, L25_lo)
      T4_hi = bit32_bxor(D_hi, L25_hi)

      L05_lo = T4_lo * TWO_POW_14 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_18) / TWO_POW_18
      L05_hi = T4_hi * TWO_POW_14 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_18) / TWO_POW_18
      L10_lo = T1_lo * TWO_POW_20 % TWO_POW_32 + (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_12) / TWO_POW_12
      L10_hi = T1_hi * TWO_POW_20 % TWO_POW_32 + (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_12) / TWO_POW_12
      L15_lo = T3_lo * TWO_POW_8 + (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_24) / TWO_POW_24
      L15_hi = T3_hi * TWO_POW_8 + (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_24) / TWO_POW_24
      L20_lo = T0_lo * TWO_POW_27 % TWO_POW_32 + (T0_hi % TWO_POW_32 - T0_hi % TWO_POW_5) / TWO_POW_5
      L20_hi = T0_hi * TWO_POW_27 % TWO_POW_32 + (T0_lo % TWO_POW_32 - T0_lo % TWO_POW_5) / TWO_POW_5
      L25_lo = (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_25) / TWO_POW_25 + T2_hi * TWO_POW_7
      L25_hi = (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_25) / TWO_POW_25 + T2_lo * TWO_POW_7

      D_lo = bit32_bxor(C5_lo, C2_lo * 2 + (C2_hi % TWO_POW_32 - C2_hi % TWO_POW_31) / TWO_POW_31)
      D_hi = bit32_bxor(C5_hi, C2_hi * 2 + (C2_lo % TWO_POW_32 - C2_lo % TWO_POW_31) / TWO_POW_31)

      T1_lo = bit32_bxor(D_lo, L06_lo)
      T1_hi = bit32_bxor(D_hi, L06_hi)
      T2_lo = bit32_bxor(D_lo, L11_lo)
      T2_hi = bit32_bxor(D_hi, L11_hi)
      T3_lo = bit32_bxor(D_lo, L16_lo)
      T3_hi = bit32_bxor(D_hi, L16_hi)
      T4_lo = bit32_bxor(D_lo, L21_lo)
      T4_hi = bit32_bxor(D_hi, L21_hi)

      L06_lo = T2_lo * TWO_POW_3 + (T2_hi % TWO_POW_32 - T2_hi % TWO_POW_29) / TWO_POW_29
      L06_hi = T2_hi * TWO_POW_3 + (T2_lo % TWO_POW_32 - T2_lo % TWO_POW_29) / TWO_POW_29
      L11_lo = T4_lo * TWO_POW_18 + (T4_hi % TWO_POW_32 - T4_hi % TWO_POW_14) / TWO_POW_14
      L11_hi = T4_hi * TWO_POW_18 + (T4_lo % TWO_POW_32 - T4_lo % TWO_POW_14) / TWO_POW_14
      L16_lo = (T1_lo % TWO_POW_32 - T1_lo % TWO_POW_28) / TWO_POW_28 + T1_hi * TWO_POW_4
      L16_hi = (T1_hi % TWO_POW_32 - T1_hi % TWO_POW_28) / TWO_POW_28 + T1_lo * TWO_POW_4
      L21_lo = (T3_lo % TWO_POW_32 - T3_lo % TWO_POW_23) / TWO_POW_23 + T3_hi * TWO_POW_9
      L21_hi = (T3_hi % TWO_POW_32 - T3_hi % TWO_POW_23) / TWO_POW_23 + T3_lo * TWO_POW_9

      L01_lo = bit32_bxor(D_lo, L01_lo)
      L01_hi = bit32_bxor(D_hi, L01_hi)
      L01_lo, L02_lo, L03_lo, L04_lo, L05_lo =
        bit32_bxor(L01_lo, bit32_band(-1 - L02_lo, L03_lo)),
        bit32_bxor(L02_lo, bit32_band(-1 - L03_lo, L04_lo)),
        bit32_bxor(L03_lo, bit32_band(-1 - L04_lo, L05_lo)),
        bit32_bxor(L04_lo, bit32_band(-1 - L05_lo, L01_lo)),
        bit32_bxor(L05_lo, bit32_band(-1 - L01_lo, L02_lo))
      L01_hi, L02_hi, L03_hi, L04_hi, L05_hi =
        bit32_bxor(L01_hi, bit32_band(-1 - L02_hi, L03_hi)),
        bit32_bxor(L02_hi, bit32_band(-1 - L03_hi, L04_hi)),
        bit32_bxor(L03_hi, bit32_band(-1 - L04_hi, L05_hi)),
        bit32_bxor(L04_hi, bit32_band(-1 - L05_hi, L01_hi)),
        bit32_bxor(L05_hi, bit32_band(-1 - L01_hi, L02_hi))
      L06_lo, L07_lo, L08_lo, L09_lo, L10_lo =
        bit32_bxor(L09_lo, bit32_band(-1 - L10_lo, L06_lo)),
        bit32_bxor(L10_lo, bit32_band(-1 - L06_lo, L07_lo)),
        bit32_bxor(L06_lo, bit32_band(-1 - L07_lo, L08_lo)),
        bit32_bxor(L07_lo, bit32_band(-1 - L08_lo, L09_lo)),
        bit32_bxor(L08_lo, bit32_band(-1 - L09_lo, L10_lo))
      L06_hi, L07_hi, L08_hi, L09_hi, L10_hi =
        bit32_bxor(L09_hi, bit32_band(-1 - L10_hi, L06_hi)),
        bit32_bxor(L10_hi, bit32_band(-1 - L06_hi, L07_hi)),
        bit32_bxor(L06_hi, bit32_band(-1 - L07_hi, L08_hi)),
        bit32_bxor(L07_hi, bit32_band(-1 - L08_hi, L09_hi)),
        bit32_bxor(L08_hi, bit32_band(-1 - L09_hi, L10_hi))
      L11_lo, L12_lo, L13_lo, L14_lo, L15_lo =
        bit32_bxor(L12_lo, bit32_band(-1 - L13_lo, L14_lo)),
        bit32_bxor(L13_lo, bit32_band(-1 - L14_lo, L15_lo)),
        bit32_bxor(L14_lo, bit32_band(-1 - L15_lo, L11_lo)),
        bit32_bxor(L15_lo, bit32_band(-1 - L11_lo, L12_lo)),
        bit32_bxor(L11_lo, bit32_band(-1 - L12_lo, L13_lo))
      L11_hi, L12_hi, L13_hi, L14_hi, L15_hi =
        bit32_bxor(L12_hi, bit32_band(-1 - L13_hi, L14_hi)),
        bit32_bxor(L13_hi, bit32_band(-1 - L14_hi, L15_hi)),
        bit32_bxor(L14_hi, bit32_band(-1 - L15_hi, L11_hi)),
        bit32_bxor(L15_hi, bit32_band(-1 - L11_hi, L12_hi)),
        bit32_bxor(L11_hi, bit32_band(-1 - L12_hi, L13_hi))
      L16_lo, L17_lo, L18_lo, L19_lo, L20_lo =
        bit32_bxor(L20_lo, bit32_band(-1 - L16_lo, L17_lo)),
        bit32_bxor(L16_lo, bit32_band(-1 - L17_lo, L18_lo)),
        bit32_bxor(L17_lo, bit32_band(-1 - L18_lo, L19_lo)),
        bit32_bxor(L18_lo, bit32_band(-1 - L19_lo, L20_lo)),
        bit32_bxor(L19_lo, bit32_band(-1 - L20_lo, L16_lo))
      L16_hi, L17_hi, L18_hi, L19_hi, L20_hi =
        bit32_bxor(L20_hi, bit32_band(-1 - L16_hi, L17_hi)),
        bit32_bxor(L16_hi, bit32_band(-1 - L17_hi, L18_hi)),
        bit32_bxor(L17_hi, bit32_band(-1 - L18_hi, L19_hi)),
        bit32_bxor(L18_hi, bit32_band(-1 - L19_hi, L20_hi)),
        bit32_bxor(L19_hi, bit32_band(-1 - L20_hi, L16_hi))
      L21_lo, L22_lo, L23_lo, L24_lo, L25_lo =
        bit32_bxor(L23_lo, bit32_band(-1 - L24_lo, L25_lo)),
        bit32_bxor(L24_lo, bit32_band(-1 - L25_lo, L21_lo)),
        bit32_bxor(L25_lo, bit32_band(-1 - L21_lo, L22_lo)),
        bit32_bxor(L21_lo, bit32_band(-1 - L22_lo, L23_lo)),
        bit32_bxor(L22_lo, bit32_band(-1 - L23_lo, L24_lo))
      L21_hi, L22_hi, L23_hi, L24_hi, L25_hi =
        bit32_bxor(L23_hi, bit32_band(-1 - L24_hi, L25_hi)),
        bit32_bxor(L24_hi, bit32_band(-1 - L25_hi, L21_hi)),
        bit32_bxor(L25_hi, bit32_band(-1 - L21_hi, L22_hi)),
        bit32_bxor(L21_hi, bit32_band(-1 - L22_hi, L23_hi)),
        bit32_bxor(L22_hi, bit32_band(-1 - L23_hi, L24_hi))
      L01_lo = bit32_bxor(L01_lo, RC_lo[round_idx])
      L01_hi = L01_hi + RC_hi[round_idx] -- RC_hi[] is either 0 or 0x80000000, so we could use fast addition instead of slow XOR
    end

    lanes_lo[1] = L01_lo
    lanes_hi[1] = L01_hi
    lanes_lo[2] = L02_lo
    lanes_hi[2] = L02_hi
    lanes_lo[3] = L03_lo
    lanes_hi[3] = L03_hi
    lanes_lo[4] = L04_lo
    lanes_hi[4] = L04_hi
    lanes_lo[5] = L05_lo
    lanes_hi[5] = L05_hi
    lanes_lo[6] = L06_lo
    lanes_hi[6] = L06_hi
    lanes_lo[7] = L07_lo
    lanes_hi[7] = L07_hi
    lanes_lo[8] = L08_lo
    lanes_hi[8] = L08_hi
    lanes_lo[9] = L09_lo
    lanes_hi[9] = L09_hi
    lanes_lo[10] = L10_lo
    lanes_hi[10] = L10_hi
    lanes_lo[11] = L11_lo
    lanes_hi[11] = L11_hi
    lanes_lo[12] = L12_lo
    lanes_hi[12] = L12_hi
    lanes_lo[13] = L13_lo
    lanes_hi[13] = L13_hi
    lanes_lo[14] = L14_lo
    lanes_hi[14] = L14_hi
    lanes_lo[15] = L15_lo
    lanes_hi[15] = L15_hi
    lanes_lo[16] = L16_lo
    lanes_hi[16] = L16_hi
    lanes_lo[17] = L17_lo
    lanes_hi[17] = L17_hi
    lanes_lo[18] = L18_lo
    lanes_hi[18] = L18_hi
    lanes_lo[19] = L19_lo
    lanes_hi[19] = L19_hi
    lanes_lo[20] = L20_lo
    lanes_hi[20] = L20_hi
    lanes_lo[21] = L21_lo
    lanes_hi[21] = L21_hi
    lanes_lo[22] = L22_lo
    lanes_hi[22] = L22_hi
    lanes_lo[23] = L23_lo
    lanes_hi[23] = L23_hi
    lanes_lo[24] = L24_lo
    lanes_hi[24] = L24_hi
    lanes_lo[25] = L25_lo
    lanes_hi[25] = L25_hi
  end
end

--------------------------------------------------------------------------------
-- MAGIC NUMBERS CALCULATOR
--------------------------------------------------------------------------------
-- Q:
--    Is 53-bit "double" math enough to calculate square roots and cube roots of primes with 64 correct bits after decimal point?
-- A:
--    Yes, 53-bit "double" arithmetic is enough.
--    We could obtain first 40 bits by direct calculation of p^(1/3) and next 40 bits by one step of Newton's method.
do
  local function mul(src1, src2, factor, result_length)
    -- src1, src2 - long integers (arrays of digits in base TWO_POW_24)
    -- factor - small integer
    -- returns long integer result (src1 * src2 * factor) and its floating point approximation
    local result, carry, value, weight = table.create(result_length), 0, 0, 1
    for j = 1, result_length do
      for k = math.max(1, j + 1 - #src2), math.min(j, #src1) do
        carry = carry + factor * src1[k] * src2[j + 1 - k] -- "int32" is not enough for multiplication result, that's why "factor" must be of type "double"
      end

      local digit = carry % TWO_POW_24
      result[j] = math.floor(digit)
      carry = (carry - digit) / TWO_POW_24
      value = value + digit * weight
      weight = weight * TWO_POW_24
    end

    return result, value
  end

  local idx, step, p, one, sqrt_hi, sqrt_lo = 0, { 4, 1, 2, -2, 2 }, 4, { 1 }, sha2_H_hi, sha2_H_lo
  repeat
    p = p + step[p % 6]
    local d = 1
    repeat
      d = d + step[d % 6]
      if d * d > p then
        -- next prime number is found
        local root = p ^ (1 / 3)
        local R = root * TWO_POW_40
        R = mul(table.create(1, math.floor(R)), one, 1, 2)
        local _, delta = mul(R, mul(R, R, 1, 4), -1, 4)
        local hi = R[2] % 65536 * 65536 + math.floor(R[1] / 256)
        local lo = R[1] % 256 * 16777216 + math.floor(delta * (TWO_POW_NEG_56 / 3) * root / p)

        if idx < 16 then
          root = math.sqrt(p)
          R = root * TWO_POW_40
          R = mul(table.create(1, math.floor(R)), one, 1, 2)
          _, delta = mul(R, R, -1, 2)
          local hi = R[2] % 65536 * 65536 + math.floor(R[1] / 256)
          local lo = R[1] % 256 * 16777216 + math.floor(delta * TWO_POW_NEG_17 / root)
          local idx = idx % 8 + 1
          sha2_H_ext256[224][idx] = lo
          sqrt_hi[idx], sqrt_lo[idx] = hi, lo + hi * hi_factor
          if idx > 7 then
            sqrt_hi, sqrt_lo = sha2_H_ext512_hi[384], sha2_H_ext512_lo[384]
          end
        end

        idx = idx + 1
        sha2_K_hi[idx], sha2_K_lo[idx] = hi, lo % K_lo_modulo + hi * hi_factor
        break
      end
    until p % d == 0
  until idx > 79
end

-- Calculating IVs for SHA512/224 and SHA512/256
for width = 224, 256, 32 do
  local H_lo, H_hi = {}, nil
  if XOR64A5 then
    for j = 1, 8 do
      H_lo[j] = XOR64A5(sha2_H_lo[j])
    end
  else
    H_hi = {}
    for j = 1, 8 do
      H_lo[j] = bit32_bxor(sha2_H_lo[j], 0xA5A5A5A5) % 4294967296
      H_hi[j] = bit32_bxor(sha2_H_hi[j], 0xA5A5A5A5) % 4294967296
    end
  end

  sha512_feed_128(H_lo, H_hi, 'SHA-512/' .. tostring(width) .. '\128' .. string.rep('\0', 115) .. '\88', 0, 128)
  sha2_H_ext512_lo[width] = H_lo
  sha2_H_ext512_hi[width] = H_hi
end

-- Constants for MD5
do
  for idx = 1, 64 do
    -- we can't use formula math.floor(abs(sin(idx))*TWO_POW_32) because its result may be beyond integer range on Lua built with 32-bit integers
    local hi, lo = math.modf(math.abs(math.sin(idx)) * TWO_POW_16)
    md5_K[idx] = hi * 65536 + math.floor(lo * TWO_POW_16)
  end
end

-- Constants for SHA3
do
  local sh_reg = 29
  local function next_bit()
    local r = sh_reg % 2
    sh_reg = bit32_bxor((sh_reg - r) / 2, 142 * r)
    return r
  end

  for idx = 1, 24 do
    local lo, m = 0, nil
    for _ = 1, 6 do
      m = m and m * m * 2 or 1
      lo = lo + next_bit() * m
    end

    local hi = next_bit() * m
    sha3_RC_hi[idx], sha3_RC_lo[idx] = hi, lo + hi * hi_factor_keccak
  end
end

--------------------------------------------------------------------------------
-- MAIN FUNCTIONS
--------------------------------------------------------------------------------
local function sha256ext(width, message)
  -- Create an instance (private objects for current calculation)
  local Array256 = sha2_H_ext256[width] -- # == 8
  local length, tail = 0, ''
  local H = table.create(8)
  H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8] =
    Array256[1], Array256[2], Array256[3], Array256[4], Array256[5], Array256[6], Array256[7], Array256[8]

  local function partial(message_part)
    if message_part then
      local partLength = #message_part
      if tail then
        length = length + partLength
        local offs = 0
        local tailLength = #tail
        if tail ~= '' and tailLength + partLength >= 64 then
          offs = 64 - tailLength
          sha256_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
          tail = ''
        end

        local size = partLength - offs
        local size_tail = size % 64
        sha256_feed_64(H, message_part, offs, size - size_tail)
        tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
        return partial
      else
        error('Adding more chunks is not allowed after receiving the result', 2)
      end
    else
      if tail then
        local final_blocks = table.create(10) --{tail, "\128", string.rep("\0", (-9 - length) % 64 + 1)}
        final_blocks[1] = tail
        final_blocks[2] = '\128'
        final_blocks[3] = string.rep('\0', (-9 - length) % 64 + 1)

        tail = nil
        -- Assuming user data length is shorter than (TWO_POW_53)-9 bytes
        -- Anyway, it looks very unrealistic that someone would spend more than a year of calculations to process TWO_POW_53 bytes of data by using this Lua script :-)
        -- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
        length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move decimal point to the left
        for j = 4, 10 do
          length = length % 1 * 256
          final_blocks[j] = string.char(math.floor(length))
        end

        final_blocks = table.concat(final_blocks)
        sha256_feed_64(H, final_blocks, 0, #final_blocks)
        local max_reg = width / 32
        for j = 1, max_reg do
          H[j] = string.format('%08x', H[j] % 4294967296)
        end

        H = table.concat(H, '', 1, max_reg)
      end

      return H
    end
  end

  if message then
    -- Actually perform calculations and return the SHA256 digest of a message
    return partial(message)()
  else
    -- Return function for chunk-by-chunk loading
    -- User should feed every chunk of input data as single argument to this function and finally get SHA256 digest by invoking this function without an argument
    return partial
  end
end

local function sha512ext(width, message)
  -- Create an instance (private objects for current calculation)
  local length, tail, H_lo, H_hi =
    0, '', table.pack(table.unpack(sha2_H_ext512_lo[width])), not HEX64 and table.pack(table.unpack(sha2_H_ext512_hi[width]))

  local function partial(message_part)
    if message_part then
      local partLength = #message_part
      if tail then
        length = length + partLength
        local offs = 0
        if tail ~= '' and #tail + partLength >= 128 then
          offs = 128 - #tail
          sha512_feed_128(H_lo, H_hi, tail .. string.sub(message_part, 1, offs), 0, 128)
          tail = ''
        end

        local size = partLength - offs
        local size_tail = size % 128
        sha512_feed_128(H_lo, H_hi, message_part, offs, size - size_tail)
        tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
        return partial
      else
        error('Adding more chunks is not allowed after receiving the result', 2)
      end
    else
      if tail then
        local final_blocks = table.create(3) --{tail, "\128", string.rep("\0", (-17-length) % 128 + 9)}
        final_blocks[1] = tail
        final_blocks[2] = '\128'
        final_blocks[3] = string.rep('\0', (-17 - length) % 128 + 9)

        tail = nil
        -- Assuming user data length is shorter than (TWO_POW_53)-17 bytes
        -- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
        length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move floating point to the left
        for j = 4, 10 do
          length = length % 1 * 256
          final_blocks[j] = string.char(math.floor(length))
        end

        final_blocks = table.concat(final_blocks)
        sha512_feed_128(H_lo, H_hi, final_blocks, 0, #final_blocks)
        local max_reg = math.ceil(width / 64)

        if HEX64 then
          for j = 1, max_reg do
            H_lo[j] = HEX64(H_lo[j])
          end
        else
          for j = 1, max_reg do
            H_lo[j] = string.format('%08x', H_hi[j] % 4294967296) .. string.format('%08x', H_lo[j] % 4294967296)
          end

          H_hi = nil
        end

        H_lo = string.sub(table.concat(H_lo, '', 1, max_reg), 1, width / 4)
      end

      return H_lo
    end
  end

  if message then
    -- Actually perform calculations and return the SHA512 digest of a message
    return partial(message)()
  else
    -- Return function for chunk-by-chunk loading
    -- User should feed every chunk of input data as single argument to this function and finally get SHA512 digest by invoking this function without an argument
    return partial
  end
end

local function md5(message)
  -- Create an instance (private objects for current calculation)
  local H, length, tail = table.create(4), 0, ''
  H[1], H[2], H[3], H[4] = md5_sha1_H[1], md5_sha1_H[2], md5_sha1_H[3], md5_sha1_H[4]

  local function partial(message_part)
    if message_part then
      local partLength = #message_part
      if tail then
        length = length + partLength
        local offs = 0
        if tail ~= '' and #tail + partLength >= 64 then
          offs = 64 - #tail
          md5_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
          tail = ''
        end

        local size = partLength - offs
        local size_tail = size % 64
        md5_feed_64(H, message_part, offs, size - size_tail)
        tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
        return partial
      else
        error('Adding more chunks is not allowed after receiving the result', 2)
      end
    else
      if tail then
        local final_blocks = table.create(3) --{tail, "\128", string.rep("\0", (-9 - length) % 64)}
        final_blocks[1] = tail
        final_blocks[2] = '\128'
        final_blocks[3] = string.rep('\0', (-9 - length) % 64)
        tail = nil
        length = length * 8 -- convert "byte-counter" to "bit-counter"
        for j = 4, 11 do
          local low_byte = length % 256
          final_blocks[j] = string.char(low_byte)
          length = (length - low_byte) / 256
        end

        final_blocks = table.concat(final_blocks)
        md5_feed_64(H, final_blocks, 0, #final_blocks)
        for j = 1, 4 do
          H[j] = string.format('%08x', H[j] % 4294967296)
        end

        H = string.gsub(table.concat(H), '(..)(..)(..)(..)', '%4%3%2%1')
      end

      return H
    end
  end

  if message then
    -- Actually perform calculations and return the MD5 digest of a message
    return partial(message)()
  else
    -- Return function for chunk-by-chunk loading
    -- User should feed every chunk of input data as single argument to this function and finally get MD5 digest by invoking this function without an argument
    return partial
  end
end

local function sha1(message)
  -- Create an instance (private objects for current calculation)
  local H, length, tail = table.pack(table.unpack(md5_sha1_H)), 0, ''

  local function partial(message_part)
    if message_part then
      local partLength = #message_part
      if tail then
        length = length + partLength
        local offs = 0
        if tail ~= '' and #tail + partLength >= 64 then
          offs = 64 - #tail
          sha1_feed_64(H, tail .. string.sub(message_part, 1, offs), 0, 64)
          tail = ''
        end

        local size = partLength - offs
        local size_tail = size % 64
        sha1_feed_64(H, message_part, offs, size - size_tail)
        tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
        return partial
      else
        error('Adding more chunks is not allowed after receiving the result', 2)
      end
    else
      if tail then
        local final_blocks = table.create(10) --{tail, "\128", string.rep("\0", (-9 - length) % 64 + 1)}
        final_blocks[1] = tail
        final_blocks[2] = '\128'
        final_blocks[3] = string.rep('\0', (-9 - length) % 64 + 1)
        tail = nil

        -- Assuming user data length is shorter than (TWO_POW_53)-9 bytes
        -- TWO_POW_53 bytes = TWO_POW_56 bits, so "bit-counter" fits in 7 bytes
        length = length * (8 / TWO56_POW_7) -- convert "byte-counter" to "bit-counter" and move decimal point to the left
        for j = 4, 10 do
          length = length % 1 * 256
          final_blocks[j] = string.char(math.floor(length))
        end

        final_blocks = table.concat(final_blocks)
        sha1_feed_64(H, final_blocks, 0, #final_blocks)
        for j = 1, 5 do
          H[j] = string.format('%08x', H[j] % 4294967296)
        end

        H = table.concat(H)
      end

      return H
    end
  end

  if message then
    -- Actually perform calculations and return the SHA-1 digest of a message
    return partial(message)()
  else
    -- Return function for chunk-by-chunk loading
    -- User should feed every chunk of input data as single argument to this function and finally get SHA-1 digest by invoking this function without an argument
    return partial
  end
end

local function keccak(block_size_in_bytes, digest_size_in_bytes, is_SHAKE, message)
  -- "block_size_in_bytes" is multiple of 8
  if type(digest_size_in_bytes) ~= 'number' then
    -- arguments in SHAKE are swapped:
    --    NIST FIPS 202 defines SHAKE(message,num_bits)
    --    this module   defines SHAKE(num_bytes,message)
    -- it's easy to forget about this swap, hence the check
    error('Argument \'digest_size_in_bytes\' must be a number', 2)
  end

  -- Create an instance (private objects for current calculation)
  local tail, lanes_lo, lanes_hi = '', table.create(25, 0), hi_factor_keccak == 0 and table.create(25, 0)
  local result

  --~     pad the input N using the pad function, yielding a padded bit string P with a length divisible by r (such that n = len(P)/r is integer),
  --~     break P into n consecutive r-bit pieces P0, ..., Pn-1 (last is zero-padded)
  --~     initialize the state S to a string of b 0 bits.
  --~     absorb the input into the state: For each block Pi,
  --~         extend Pi at the end by a string of c 0 bits, yielding one of length b,
  --~         XOR that with S and
  --~         apply the block permutation f to the result, yielding a new state S
  --~     initialize Z to be the empty string
  --~     while the length of Z is less than d:
  --~         append the first r bits of S to Z
  --~         if Z is still less than d bits long, apply f to S, yielding a new state S.
  --~     truncate Z to d bits
  local function partial(message_part)
    if message_part then
      local partLength = #message_part
      if tail then
        local offs = 0
        if tail ~= '' and #tail + partLength >= block_size_in_bytes then
          offs = block_size_in_bytes - #tail
          keccak_feed(
            lanes_lo,
            lanes_hi,
            tail .. string.sub(message_part, 1, offs),
            0,
            block_size_in_bytes,
            block_size_in_bytes
          )
          tail = ''
        end

        local size = partLength - offs
        local size_tail = size % block_size_in_bytes
        keccak_feed(lanes_lo, lanes_hi, message_part, offs, size - size_tail, block_size_in_bytes)
        tail = tail .. string.sub(message_part, partLength + 1 - size_tail)
        return partial
      else
        error('Adding more chunks is not allowed after receiving the result', 2)
      end
    else
      if tail then
        -- append the following bits to the message: for usual SHA3: 011(0*)1, for SHAKE: 11111(0*)1
        local gap_start = is_SHAKE and 31 or 6
        tail = tail
          .. (
            #tail + 1 == block_size_in_bytes and string.char(gap_start + 128)
            or string.char(gap_start) .. string.rep('\0', (-2 - #tail) % block_size_in_bytes) .. '\128'
          )
        keccak_feed(lanes_lo, lanes_hi, tail, 0, #tail, block_size_in_bytes)
        tail = nil

        local lanes_used = 0
        local total_lanes = math.floor(block_size_in_bytes / 8)
        local qwords = {}

        local function get_next_qwords_of_digest(qwords_qty)
          -- returns not more than 'qwords_qty' qwords ('qwords_qty' might be non-integer)
          -- doesn't go across keccak-buffer boundary
          -- block_size_in_bytes is a multiple of 8, so, keccak-buffer contains integer number of qwords
          if lanes_used >= total_lanes then
            keccak_feed(lanes_lo, lanes_hi, '\0\0\0\0\0\0\0\0', 0, 8, 8)
            lanes_used = 0
          end

          qwords_qty = math.floor(math.min(qwords_qty, total_lanes - lanes_used))
          if hi_factor_keccak ~= 0 then
            for j = 1, qwords_qty do
              qwords[j] = HEX64(lanes_lo[lanes_used + j - 1 + lanes_index_base])
            end
          else
            for j = 1, qwords_qty do
              qwords[j] = string.format('%08x', lanes_hi[lanes_used + j] % 4294967296)
                .. string.format('%08x', lanes_lo[lanes_used + j] % 4294967296)
            end
          end

          lanes_used = lanes_used + qwords_qty
          return string.gsub(table.concat(qwords, '', 1, qwords_qty), '(..)(..)(..)(..)(..)(..)(..)(..)', '%8%7%6%5%4%3%2%1'),
            qwords_qty * 8
        end

        local parts = {} -- digest parts
        local last_part, last_part_size = '', 0

        local function get_next_part_of_digest(bytes_needed)
          -- returns 'bytes_needed' bytes, for arbitrary integer 'bytes_needed'
          bytes_needed = bytes_needed or 1
          if bytes_needed <= last_part_size then
            last_part_size = last_part_size - bytes_needed
            local part_size_in_nibbles = bytes_needed * 2
            local result = string.sub(last_part, 1, part_size_in_nibbles)
            last_part = string.sub(last_part, part_size_in_nibbles + 1)
            return result
          end

          local parts_qty = 0
          if last_part_size > 0 then
            parts_qty = 1
            parts[parts_qty] = last_part
            bytes_needed = bytes_needed - last_part_size
          end

          -- repeats until the length is enough
          while bytes_needed >= 8 do
            local next_part, next_part_size = get_next_qwords_of_digest(bytes_needed / 8)
            parts_qty = parts_qty + 1
            parts[parts_qty] = next_part
            bytes_needed = bytes_needed - next_part_size
          end

          if bytes_needed > 0 then
            last_part, last_part_size = get_next_qwords_of_digest(1)
            parts_qty = parts_qty + 1
            parts[parts_qty] = get_next_part_of_digest(bytes_needed)
          else
            last_part, last_part_size = '', 0
          end

          return table.concat(parts, '', 1, parts_qty)
        end

        if digest_size_in_bytes < 0 then
          result = get_next_part_of_digest
        else
          result = get_next_part_of_digest(digest_size_in_bytes)
        end
      end

      return result
    end
  end

  if message then
    -- Actually perform calculations and return the SHA3 digest of a message
    return partial(message)()
  else
    -- Return function for chunk-by-chunk loading
    -- User should feed every chunk of input data as single argument to this function and finally get SHA3 digest by invoking this function without an argument
    return partial
  end
end

local function HexToBinFunction(hh)
  return string.char(tonumber(hh, 16))
end

local function hex2bin(hex_string)
  return (string.gsub(hex_string, '%x%x', HexToBinFunction))
end

local base64_symbols = {
  ['+'] = 62,
  ['-'] = 62,
  [62] = '+',
  ['/'] = 63,
  ['_'] = 63,
  [63] = '/',
  ['='] = -1,
  ['.'] = -1,
  [-1] = '=',
}

local symbol_index = 0
for j, pair in ipairs { 'AZ', 'az', '09' } do
  for ascii = string.byte(pair), string.byte(pair, 2) do
    local ch = string.char(ascii)
    base64_symbols[ch] = symbol_index
    base64_symbols[symbol_index] = ch
    symbol_index = symbol_index + 1
  end
end

local function bin2base64(binary_string)
  local stringLength = #binary_string
  local result = table.create(math.ceil(stringLength / 3))
  local length = 0

  for pos = 1, #binary_string, 3 do
    local c1, c2, c3, c4 = string.byte(string.sub(binary_string, pos, pos + 2) .. '\0', 1, -1)
    length = length + 1
    result[length] = base64_symbols[math.floor(c1 / 4)]
      .. base64_symbols[c1 % 4 * 16 + math.floor(c2 / 16)]
      .. base64_symbols[c3 and c2 % 16 * 4 + math.floor(c3 / 64) or -1]
      .. base64_symbols[c4 and c3 % 64 or -1]
  end

  return table.concat(result)
end

local function base642bin(base64_string)
  local result, chars_qty = {}, 3
  for pos, ch in string.gmatch(string.gsub(base64_string, '%s+', ''), '()(.)') do
    local code = base64_symbols[ch]
    if code < 0 then
      chars_qty = chars_qty - 1
      code = 0
    end

    local idx = pos % 4
    if idx > 0 then
      result[-idx] = code
    else
      local c1 = result[-1] * 4 + math.floor(result[-2] / 16)
      local c2 = (result[-2] % 16) * 16 + math.floor(result[-3] / 4)
      local c3 = (result[-3] % 4) * 64 + code
      result[#result + 1] = string.sub(string.char(c1, c2, c3), 1, chars_qty)
    end
  end

  return table.concat(result)
end

local block_size_for_HMAC -- this table will be initialized at the end of the module
--local function pad_and_xor(str, result_length, byte_for_xor)
--	return string.gsub(str, ".", function(c)
--		return string.char(bit32_bxor(string.byte(c), byte_for_xor))
--	end) .. string.rep(string.char(byte_for_xor), result_length - #str)
--end

-- For the sake of speed of converting hexes to strings, there's a map of the conversions here
local BinaryStringMap = {}
for Index = 0, 255 do
  BinaryStringMap[string.format('%02x', Index)] = string.char(Index)
end

-- Update 02.14.20 - added AsBinary for easy GameAnalytics replacement.
local function hmac(hash_func, key, message, AsBinary)
  -- Create an instance (private objects for current calculation)
  local block_size = block_size_for_HMAC[hash_func]
  if not block_size then
    error('Unknown hash function', 2)
  end

  local KeyLength = #key
  if KeyLength > block_size then
    key = string.gsub(hash_func(key), '%x%x', HexToBinFunction)
    KeyLength = #key
  end

  local append = hash_func()(string.gsub(key, '.', function(c)
    return string.char(bit32_bxor(string.byte(c), 0x36))
  end) .. string.rep('6', block_size - KeyLength)) -- 6 = string.char(0x36)

  local result

  local function partial(message_part)
    if not message_part then
      result = result
        or hash_func(
          string.gsub(key, '.', function(c)
            return string.char(bit32_bxor(string.byte(c), 0x5c))
          end)
            .. string.rep('\\', block_size - KeyLength) -- \ = string.char(0x5c)
            .. (string.gsub(append(), '%x%x', HexToBinFunction))
        )

      return result
    elseif result then
      error('Adding more chunks is not allowed after receiving the result', 2)
    else
      append(message_part)
      return partial
    end
  end

  if message then
    -- Actually perform calculations and return the HMAC of a message
    local FinalMessage = partial(message)()
    return AsBinary and (string.gsub(FinalMessage, '%x%x', BinaryStringMap)) or FinalMessage
  else
    -- Return function for chunk-by-chunk loading of a message
    -- User should feed every chunk of the message as single argument to this function and finally get HMAC by invoking this function without an argument
    return partial
  end
end

local sha = {
  md5 = md5,
  sha1 = sha1,
  -- SHA2 hash functions:
  sha224 = function(message)
    return sha256ext(224, message)
  end,

  sha256 = function(message)
    return sha256ext(256, message)
  end,

  sha512_224 = function(message)
    return sha512ext(224, message)
  end,

  sha512_256 = function(message)
    return sha512ext(256, message)
  end,

  sha384 = function(message)
    return sha512ext(384, message)
  end,

  sha512 = function(message)
    return sha512ext(512, message)
  end,

  -- SHA3 hash functions:
  sha3_224 = function(message)
    return keccak((1600 - 2 * 224) / 8, 224 / 8, false, message)
  end,

  sha3_256 = function(message)
    return keccak((1600 - 2 * 256) / 8, 256 / 8, false, message)
  end,

  sha3_384 = function(message)
    return keccak((1600 - 2 * 384) / 8, 384 / 8, false, message)
  end,

  sha3_512 = function(message)
    return keccak((1600 - 2 * 512) / 8, 512 / 8, false, message)
  end,

  shake128 = function(message, digest_size_in_bytes)
    return keccak((1600 - 2 * 128) / 8, digest_size_in_bytes, true, message)
  end,

  shake256 = function(message, digest_size_in_bytes)
    return keccak((1600 - 2 * 256) / 8, digest_size_in_bytes, true, message)
  end,

  -- misc utilities:
  hmac = hmac, -- HMAC(hash_func, key, message) is applicable to any hash function from this module except SHAKE*
  hex_to_bin = hex2bin, -- converts hexadecimal representation to binary string
  base64_to_bin = base642bin, -- converts base64 representation to binary string
  bin_to_base64 = bin2base64, -- converts binary string to base64 representation
  base64_encode = Base64.Encode,
  base64_decode = Base64.Decode,
}

block_size_for_HMAC = {
  [sha.md5] = 64,
  [sha.sha1] = 64,
  [sha.sha224] = 64,
  [sha.sha256] = 64,
  [sha.sha512_224] = 128,
  [sha.sha512_256] = 128,
  [sha.sha384] = 128,
  [sha.sha512] = 128,
  [sha.sha3_224] = (1600 - 2 * 224) / 8,
  [sha.sha3_256] = (1600 - 2 * 256) / 8,
  [sha.sha3_384] = (1600 - 2 * 384) / 8,
  [sha.sha3_512] = (1600 - 2 * 512) / 8,
}

return sha

end;
modules['packages/hash.lua'].cache = null;
modules['packages/hash.lua'].isCached = false;

----

modules['packages/json.lua'] = {};
modules['packages/json.lua'].load = function()
local __just_filename = 'json.lua';
local __filename = 'packages/json.lua';
local __dirname = 'packages';
local __hash = '4dc5f6c3b5bcd0f200b1ef9ff4a812b86e199331cbfa9858a9c73f2c8b513872a4d3fbd59b0a2d82a36115ac629be786085aa54cbe4d445b0ade77bea5350a86';
--[[ json.lua

A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.

## json.stringify:

This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.

A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.

Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.

An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.

To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.

## json.parse:

This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.

It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.

If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.

--]]

-- Minified variant of https://gist.githubusercontent.com/tylerneylon/59f4bcf316be525b30ab/raw/7f69cc2cea38bf68298ed3dbfc39d197d53c80de/json.lua
local a={}local function b(c)if type(c)~='table'then return type(c)end;local d=1;for e in pairs(c)do if c[d]~=nil then d=d+1 else return'table'end end;if d==1 then return'table'else return'array'end end;local function f(g)local h={'\\','"','/','\b','\f','\n','\r','\t'}local i={'\\','"','/','b','f','n','r','t'}for d,j in ipairs(h)do g=g:gsub(j,'\\'..i[d])end;return g end;local function k(l,m,n,o)m=m+#l:match('^%s*',m)if l:sub(m,m)~=n then if o then error('Expected '..n..' near position '..m)end;return m,false end;return m+1,true end;local function p(l,m,q)q=q or''local r='End of input found while parsing string.'if m>#l then error(r)end;local j=l:sub(m,m)if j=='"'then return q,m+1 end;if j~='\\'then return p(l,m+1,q..j)end;local s={b='\b',f='\f',n='\n',r='\r',t='\t'}local t=l:sub(m+1,m+1)if not t then error(r)end;return p(l,m+2,q..(s[t]or t))end;local function u(l,m)local v=l:match('^-?%d+%.?%d*[eE]?[+-]?%d*',m)local q=tonumber(v)if not q then error('Error parsing number at position '..m..'.')end;return q,m+#v end;function a.stringify(c,w)local g={}local x=b(c)if x=='array'then if w then error'Can\'t encode array as key.'end;g[#g+1]='['for d,q in ipairs(c)do if d>1 then g[#g+1]=', 'end;g[#g+1]=a.stringify(q)end;g[#g+1]=']'elseif x=='table'then if w then error'Can\'t encode table as key.'end;g[#g+1]='{'for y,z in pairs(c)do if#g>1 then g[#g+1]=', 'end;g[#g+1]=a.stringify(y,true)g[#g+1]=':'g[#g+1]=a.stringify(z)end;g[#g+1]='}'elseif x=='string'then return'"'..f(c)..'"'elseif x=='number'then if w then return'"'..tostring(c)..'"'end;return tostring(c)elseif x=='boolean'then return tostring(c)elseif x=='nil'then return'null'else error('Unjsonifiable type: '..x..'.')end;return table.concat(g)end;a.null={}function a.parse(l,m,A)m=m or 1;if m>#l then error'Reached unexpected end of input.'end;local m=m+#l:match('^%s*',m)local B=l:sub(m,m)if B=='{'then local c,C,D={},true,true;m=m+1;while true do C,m=a.parse(l,m,'}')if C==nil then return c,m end;if not D then error'Comma missing between object items.'end;m=k(l,m,':',true)c[C],m=a.parse(l,m)m,D=k(l,m,',')end elseif B=='['then local E,q,D={},true,true;m=m+1;while true do q,m=a.parse(l,m,']')if q==nil then return E,m end;if not D then error'Comma missing between array items.'end;E[#E+1]=q;m,D=k(l,m,',')end elseif B=='"'then return p(l,m+1)elseif B=='-'or B:match'%d'then return u(l,m)elseif B==A then return nil,m+1 else local F={['true']=true,['false']=false,['null']=a.null}for G,H in pairs(F)do local I=m+#G-1;if l:sub(m,I)==G then return H,I+1 end end;local J='position '..m..': '..l:sub(m,m+10)error('Invalid json syntax starting at '..J)end end;return a

end;
modules['packages/json.lua'].cache = null;
modules['packages/json.lua'].isCached = false;

----

modules['packages/polyfills/table.create.lua'] = {};
modules['packages/polyfills/table.create.lua'].load = function()
local __just_filename = 'table.create.lua';
local __filename = 'packages/polyfills/table.create.lua';
local __dirname = 'packages/polyfills';
local __hash = '19eaa311cabc2e4b53501a8cc4090692c36cbccc4e75a0d082e8cfa7543f48cf5f70db601dba94ede670a483e36bcd7a309d720e32921ef0fd000770c799fced';
_G.table.create = table.create
  or function(count, value)
    local t = {}
    for i = 1, count, 1 do
      t[i] = value
    end
    return t
  end

end;
modules['packages/polyfills/table.create.lua'].cache = null;
modules['packages/polyfills/table.create.lua'].isCached = false;

----

modules['packages/rstr.lua'] = {};
modules['packages/rstr.lua'].load = function()
local __just_filename = 'rstr.lua';
local __filename = 'packages/rstr.lua';
local __dirname = 'packages';
local __hash = '3fbb599255778057fec55666068f44b9a1168c88fe0501982982796a7a4ed688899a4351a63875869b27a384b203df47f132982656b98423029bfe4e91d51645';
-- random string library
local rchar = function(chars)
  chars = chars or 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 '
  local rint = math.random(1, #chars)
  return chars:sub(rint, rint)
end
return function(len, chars)
  local str = ''
  for i = 1, len, 1 do
    str = str .. rchar(chars)
  end
  return str
end

end;
modules['packages/rstr.lua'].cache = null;
modules['packages/rstr.lua'].isCached = false;

----

modules['packages/termination.lua'] = {};
modules['packages/termination.lua'].load = function()
local __just_filename = 'termination.lua';
local __filename = 'packages/termination.lua';
local __dirname = 'packages';
local __hash = '363f9ffadf1be9c7074c012ecb77d6377a0d2f277f09668eefa74399becf750fbce66eaa4c0b31af551d25107c01d0d99855051a8b4473e1a01b04f4ec019dd5';
local isTerminateDisabled = false
local defaultPull = os.pullEvent
return {
  ['setDisabled'] = function(v)
    if v then
      if v ~= isTerminateDisabled then
        defaultPull = os.pullEvent
      end
      os.pullEvent = os.pullEventRaw
    else
      os.pullEvent = defaultPull
    end
    isTerminateDisabled = v
  end,
  ['getDisabled'] = function()
    return isTerminateDisabled
  end,
}

end;
modules['packages/termination.lua'].cache = null;
modules['packages/termination.lua'].isCached = false;

----

modules['packages/uniquekeys.lua'] = {};
modules['packages/uniquekeys.lua'].load = function()
local __just_filename = 'uniquekeys.lua';
local __filename = 'packages/uniquekeys.lua';
local __dirname = 'packages';
local __hash = '0da3f5a0df8b67ee7f998acc2a713a7096ffbe297e6829d6ada0e4d84bcb46a26512d9256d17c669f2b4126548801a9f80bccec971cbfe4071d67739d368e36a';
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
local shouldB64Decode = false
if shouldB64Decode then
  for k, v in pairs(keys) do
    keys[k] = require('base64').Decode(v)
  end
end
return keys

end;
modules['packages/uniquekeys.lua'].cache = null;
modules['packages/uniquekeys.lua'].isCached = false;

----

modules['packages/xor.lua'] = {};
modules['packages/xor.lua'].load = function()
local __just_filename = 'xor.lua';
local __filename = 'packages/xor.lua';
local __dirname = 'packages';
local __hash = '12d0c046a9f96fd64280170a2c96a2a7f5260f2189c4756df9dc028a99a73a464037fc967316fb58d20cdf15f91533f94e69c163cf7c06b73c60472bc6528eb2';
-- https://github.com/Braayy/xor-lua/blob/master/xor.lua
-- MIT
-- too lazy to implement my own xor & my og aes doesnt work in cc on 1.12.2 for some reason
function repeat_key(key, length)
  if #key >= length then
    return key:sub(1, length)
  end

  times = math.floor(length / #key)
  remain = length % #key

  result = ''

  for i = 1, times do
    result = result .. key
  end

  if remain > 0 then
    result = result .. key:sub(1, remain)
  end

  return result
end

function xor(message, key)
  rkey = repeat_key(key, #message)

  result = ''

  for i = 1, #message do
    k_char = rkey:sub(i, i)
    m_char = message:sub(i, i)

    k_byte = k_char:byte()
    m_byte = m_char:byte()

    xor_byte = require('bitop').bxor(m_byte, k_byte)

    xor_char = string.char(xor_byte)

    result = result .. xor_char
  end

  return result
end

return xor

end;
modules['packages/xor.lua'].cache = null;
modules['packages/xor.lua'].isCached = false;

----

modules['version.lua'] = {};
modules['version.lua'].load = function()
local __just_filename = 'version.lua';
local __filename = 'version.lua';
local __dirname = '';
local __hash = '7a5cd8cbe43906f7f1c1d50eb18312aff11909772deab5fdcb3a901ad7a86384bebb471694b4760cc67147c5c541519eaba249f1e6426369a2d2db6a32eadfc4';
return '1.0.0'

end;
modules['version.lua'].cache = null;
modules['version.lua'].isCached = false;

--> END Initial Module Definitions <--


--> BEGIN Alias/Equivalent Module Path Definitions <--

modules['auth'] = modules['auth.lua'];
modules['auth.lua'] = modules['auth.lua'];
modules['auth'] = modules['auth.lua'];
modules['/auth'] = modules['auth.lua'];
modules['\\auth.lua'] = modules['auth.lua'];
modules['\\auth'] = modules['auth.lua'];

----

modules['boot'] = modules['boot.lua'];
modules['boot.lua'] = modules['boot.lua'];
modules['boot'] = modules['boot.lua'];
modules['/boot'] = modules['boot.lua'];
modules['\\boot.lua'] = modules['boot.lua'];
modules['\\boot'] = modules['boot.lua'];

----

modules['index'] = modules['index.lua'];
modules['index.lua'] = modules['index.lua'];
modules['index'] = modules['index.lua'];
modules['/index'] = modules['index.lua'];
modules['\\index.lua'] = modules['index.lua'];
modules['\\index'] = modules['index.lua'];
modules[''] = modules['index.lua'];
modules[''] = modules['index.lua'];
modules[''] = modules['index.lua'];
modules['/'] = modules['index.lua'];
modules['\\'] = modules['index.lua'];
modules['\\'] = modules['index.lua'];

----

modules['load-installer'] = modules['load-installer.lua'];
modules['load-installer.lua'] = modules['load-installer.lua'];
modules['load-installer'] = modules['load-installer.lua'];
modules['/load-installer'] = modules['load-installer.lua'];
modules['\\load-installer.lua'] = modules['load-installer.lua'];
modules['\\load-installer'] = modules['load-installer.lua'];

----

modules['login'] = modules['login.lua'];
modules['login.lua'] = modules['login.lua'];
modules['login'] = modules['login.lua'];
modules['/login'] = modules['login.lua'];
modules['\\login.lua'] = modules['login.lua'];
modules['\\login'] = modules['login.lua'];

----

modules['misc/chime'] = modules['misc/chime.lua'];
modules['misc\\chime.lua'] = modules['misc/chime.lua'];
modules['misc\\chime'] = modules['misc/chime.lua'];
modules['/misc/chime'] = modules['misc/chime.lua'];
modules['\\misc\\chime.lua'] = modules['misc/chime.lua'];
modules['\\misc\\chime'] = modules['misc/chime.lua'];

----

modules['packages/basalt'] = modules['packages/basalt.lua'];
modules['packages\\basalt.lua'] = modules['packages/basalt.lua'];
modules['packages\\basalt'] = modules['packages/basalt.lua'];
modules['basalt'] = modules['packages/basalt.lua'];
modules['basalt.lua'] = modules['packages/basalt.lua'];
modules['basalt'] = modules['packages/basalt.lua'];
modules['/basalt'] = modules['packages/basalt.lua'];
modules['\\basalt.lua'] = modules['packages/basalt.lua'];
modules['\\basalt'] = modules['packages/basalt.lua'];
modules['/packages/basalt'] = modules['packages/basalt.lua'];
modules['\\packages\\basalt.lua'] = modules['packages/basalt.lua'];
modules['\\packages\\basalt'] = modules['packages/basalt.lua'];

----

modules['packages/base64'] = modules['packages/base64.lua'];
modules['packages\\base64.lua'] = modules['packages/base64.lua'];
modules['packages\\base64'] = modules['packages/base64.lua'];
modules['base64'] = modules['packages/base64.lua'];
modules['base64.lua'] = modules['packages/base64.lua'];
modules['base64'] = modules['packages/base64.lua'];
modules['/base64'] = modules['packages/base64.lua'];
modules['\\base64.lua'] = modules['packages/base64.lua'];
modules['\\base64'] = modules['packages/base64.lua'];
modules['/packages/base64'] = modules['packages/base64.lua'];
modules['\\packages\\base64.lua'] = modules['packages/base64.lua'];
modules['\\packages\\base64'] = modules['packages/base64.lua'];

----

modules['packages/bitop'] = modules['packages/bitop.lua'];
modules['packages\\bitop.lua'] = modules['packages/bitop.lua'];
modules['packages\\bitop'] = modules['packages/bitop.lua'];
modules['bitop'] = modules['packages/bitop.lua'];
modules['bitop.lua'] = modules['packages/bitop.lua'];
modules['bitop'] = modules['packages/bitop.lua'];
modules['/bitop'] = modules['packages/bitop.lua'];
modules['\\bitop.lua'] = modules['packages/bitop.lua'];
modules['\\bitop'] = modules['packages/bitop.lua'];
modules['/packages/bitop'] = modules['packages/bitop.lua'];
modules['\\packages\\bitop.lua'] = modules['packages/bitop.lua'];
modules['\\packages\\bitop'] = modules['packages/bitop.lua'];

----

modules['packages/child_process'] = modules['packages/child_process.lua'];
modules['packages\\child_process.lua'] = modules['packages/child_process.lua'];
modules['packages\\child_process'] = modules['packages/child_process.lua'];
modules['child_process'] = modules['packages/child_process.lua'];
modules['child_process.lua'] = modules['packages/child_process.lua'];
modules['child_process'] = modules['packages/child_process.lua'];
modules['/child_process'] = modules['packages/child_process.lua'];
modules['\\child_process.lua'] = modules['packages/child_process.lua'];
modules['\\child_process'] = modules['packages/child_process.lua'];
modules['/packages/child_process'] = modules['packages/child_process.lua'];
modules['\\packages\\child_process.lua'] = modules['packages/child_process.lua'];
modules['\\packages\\child_process'] = modules['packages/child_process.lua'];

----

modules['packages/console'] = modules['packages/console.lua'];
modules['packages\\console.lua'] = modules['packages/console.lua'];
modules['packages\\console'] = modules['packages/console.lua'];
modules['console'] = modules['packages/console.lua'];
modules['console.lua'] = modules['packages/console.lua'];
modules['console'] = modules['packages/console.lua'];
modules['/console'] = modules['packages/console.lua'];
modules['\\console.lua'] = modules['packages/console.lua'];
modules['\\console'] = modules['packages/console.lua'];
modules['/packages/console'] = modules['packages/console.lua'];
modules['\\packages\\console.lua'] = modules['packages/console.lua'];
modules['\\packages\\console'] = modules['packages/console.lua'];

----

modules['packages/forceyield'] = modules['packages/forceyield.lua'];
modules['packages\\forceyield.lua'] = modules['packages/forceyield.lua'];
modules['packages\\forceyield'] = modules['packages/forceyield.lua'];
modules['forceyield'] = modules['packages/forceyield.lua'];
modules['forceyield.lua'] = modules['packages/forceyield.lua'];
modules['forceyield'] = modules['packages/forceyield.lua'];
modules['/forceyield'] = modules['packages/forceyield.lua'];
modules['\\forceyield.lua'] = modules['packages/forceyield.lua'];
modules['\\forceyield'] = modules['packages/forceyield.lua'];
modules['/packages/forceyield'] = modules['packages/forceyield.lua'];
modules['\\packages\\forceyield.lua'] = modules['packages/forceyield.lua'];
modules['\\packages\\forceyield'] = modules['packages/forceyield.lua'];

----

modules['packages/hash'] = modules['packages/hash.lua'];
modules['packages\\hash.lua'] = modules['packages/hash.lua'];
modules['packages\\hash'] = modules['packages/hash.lua'];
modules['hash'] = modules['packages/hash.lua'];
modules['hash.lua'] = modules['packages/hash.lua'];
modules['hash'] = modules['packages/hash.lua'];
modules['/hash'] = modules['packages/hash.lua'];
modules['\\hash.lua'] = modules['packages/hash.lua'];
modules['\\hash'] = modules['packages/hash.lua'];
modules['/packages/hash'] = modules['packages/hash.lua'];
modules['\\packages\\hash.lua'] = modules['packages/hash.lua'];
modules['\\packages\\hash'] = modules['packages/hash.lua'];

----

modules['packages/json'] = modules['packages/json.lua'];
modules['packages\\json.lua'] = modules['packages/json.lua'];
modules['packages\\json'] = modules['packages/json.lua'];
modules['json'] = modules['packages/json.lua'];
modules['json.lua'] = modules['packages/json.lua'];
modules['json'] = modules['packages/json.lua'];
modules['/json'] = modules['packages/json.lua'];
modules['\\json.lua'] = modules['packages/json.lua'];
modules['\\json'] = modules['packages/json.lua'];
modules['/packages/json'] = modules['packages/json.lua'];
modules['\\packages\\json.lua'] = modules['packages/json.lua'];
modules['\\packages\\json'] = modules['packages/json.lua'];

----

modules['packages/polyfills/table.create'] = modules['packages/polyfills/table.create.lua'];
modules['packages\\polyfills\\table.create.lua'] = modules['packages/polyfills/table.create.lua'];
modules['packages\\polyfills\\table.create'] = modules['packages/polyfills/table.create.lua'];
modules['polyfills/table.create'] = modules['packages/polyfills/table.create.lua'];
modules['polyfills\\table.create.lua'] = modules['packages/polyfills/table.create.lua'];
modules['polyfills\\table.create'] = modules['packages/polyfills/table.create.lua'];
modules['/polyfills/table.create'] = modules['packages/polyfills/table.create.lua'];
modules['\\polyfills\\table.create.lua'] = modules['packages/polyfills/table.create.lua'];
modules['\\polyfills\\table.create'] = modules['packages/polyfills/table.create.lua'];
modules['/packages/polyfills/table.create'] = modules['packages/polyfills/table.create.lua'];
modules['\\packages\\polyfills\\table.create.lua'] = modules['packages/polyfills/table.create.lua'];
modules['\\packages\\polyfills\\table.create'] = modules['packages/polyfills/table.create.lua'];

----

modules['packages/rstr'] = modules['packages/rstr.lua'];
modules['packages\\rstr.lua'] = modules['packages/rstr.lua'];
modules['packages\\rstr'] = modules['packages/rstr.lua'];
modules['rstr'] = modules['packages/rstr.lua'];
modules['rstr.lua'] = modules['packages/rstr.lua'];
modules['rstr'] = modules['packages/rstr.lua'];
modules['/rstr'] = modules['packages/rstr.lua'];
modules['\\rstr.lua'] = modules['packages/rstr.lua'];
modules['\\rstr'] = modules['packages/rstr.lua'];
modules['/packages/rstr'] = modules['packages/rstr.lua'];
modules['\\packages\\rstr.lua'] = modules['packages/rstr.lua'];
modules['\\packages\\rstr'] = modules['packages/rstr.lua'];

----

modules['packages/termination'] = modules['packages/termination.lua'];
modules['packages\\termination.lua'] = modules['packages/termination.lua'];
modules['packages\\termination'] = modules['packages/termination.lua'];
modules['termination'] = modules['packages/termination.lua'];
modules['termination.lua'] = modules['packages/termination.lua'];
modules['termination'] = modules['packages/termination.lua'];
modules['/termination'] = modules['packages/termination.lua'];
modules['\\termination.lua'] = modules['packages/termination.lua'];
modules['\\termination'] = modules['packages/termination.lua'];
modules['/packages/termination'] = modules['packages/termination.lua'];
modules['\\packages\\termination.lua'] = modules['packages/termination.lua'];
modules['\\packages\\termination'] = modules['packages/termination.lua'];

----

modules['packages/uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['packages\\uniquekeys.lua'] = modules['packages/uniquekeys.lua'];
modules['packages\\uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['uniquekeys.lua'] = modules['packages/uniquekeys.lua'];
modules['uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['/uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['\\uniquekeys.lua'] = modules['packages/uniquekeys.lua'];
modules['\\uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['/packages/uniquekeys'] = modules['packages/uniquekeys.lua'];
modules['\\packages\\uniquekeys.lua'] = modules['packages/uniquekeys.lua'];
modules['\\packages\\uniquekeys'] = modules['packages/uniquekeys.lua'];

----

modules['packages/xor'] = modules['packages/xor.lua'];
modules['packages\\xor.lua'] = modules['packages/xor.lua'];
modules['packages\\xor'] = modules['packages/xor.lua'];
modules['xor'] = modules['packages/xor.lua'];
modules['xor.lua'] = modules['packages/xor.lua'];
modules['xor'] = modules['packages/xor.lua'];
modules['/xor'] = modules['packages/xor.lua'];
modules['\\xor.lua'] = modules['packages/xor.lua'];
modules['\\xor'] = modules['packages/xor.lua'];
modules['/packages/xor'] = modules['packages/xor.lua'];
modules['\\packages\\xor.lua'] = modules['packages/xor.lua'];
modules['\\packages\\xor'] = modules['packages/xor.lua'];

----

modules['version'] = modules['version.lua'];
modules['version.lua'] = modules['version.lua'];
modules['version'] = modules['version.lua'];
modules['/version'] = modules['version.lua'];
modules['\\version.lua'] = modules['version.lua'];
modules['\\version'] = modules['version.lua'];

--> END Alias/Equivalent Module Path Definitions <--


return require 'index'

end)(require or function()end,...);
