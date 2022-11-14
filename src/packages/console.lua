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
