-- load ui
print 'Preparing...'
_G.Math = math
local sizeX, sizeY = term.getSize()
local basalt = require 'basalt'
local hash = require 'hash'
local uniqueKeys = require 'uniquekeys'
local xor = require 'xor'
require('termination').setDisabled(true)
local login = basalt
  .createFrame()
  :setTheme({
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
    -- ProgramBG = colors.black,
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
  })
  :setForeground(colors.white)
  :setBackground(colors.black)
local passwdField = login:addInput():setPosition(2, math.floor(sizeY / 2 - 3)):setSize(sizeX - 2, 1)
local invalidText = login
  :addLabel()
  :setText('')
  :setPosition(Math.floor(sizeX / 2) - 7, math.floor(sizeY / 2 + 7))
  :setSize(#'Invalid Password', 1)
local submitBtn =
  login:addButton():setPosition(Math.floor(sizeX / 2) - 8, math.floor(sizeY / 2 + 1)):setSize(18, 3):setText 'Login'
submitBtn:onClick(function()
  local pw = hash.hmac(hash.sha3_512, uniqueKeys.pw, passwdField:getValue())
  local enc = xor(uniqueKeys.enc, uniqueKeys.Eenc .. pw)
  if xor(require('auth').encryped, enc) ~= pw then
    login:setBackground(colors.red)
    invalidText:show()
    passwdField:hide()
    sleep(2)
    invalidText:hide()
    passwdField:show()
    login:setBackground(colors.black)
  else
    for k, v in pairs(uniqueKeys) do
      if k ~= 'Eenc' and k ~= 'pw' then
        uniqueKeys[k] = xor(v, uniqueKeys.Eenc .. pw)
      end
    end
    submitBtn:hide()
    passwdField:hide()
    require('termination').setDisabled(false)
    login:hide()
    require 'boot'()
  end
end)

basalt.autoUpdate()
