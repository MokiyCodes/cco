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
      :setSize((w or 30) + 1, (h or 12))
      :setPosition(x or math.random(2, 12), y or math.random(2, 8))
      :setBackground(colors.red)

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

  local appList = main:addFrame():setScrollable():setSize('parent.w - 2', 16):setPosition(1, 1)
  appList:addButton():setPosition('parent.w - 16', 2):setText('Open'):onClick(function()
    openProgram('/rom/programs/shell.lua', 'Shell', true)
  end)

  basalt.autoUpdate()
end
