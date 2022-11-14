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
