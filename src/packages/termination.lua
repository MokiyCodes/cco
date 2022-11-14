local isTerminateDisabled = false
local enabledPullEvent = os.pullEvent
local disabledPullEvent = os.pullEventRaw
os.pullEvent = function(...)
  if isTerminateDisabled then
    return disabledPullEvent(...)
  else
    return enabledPullEvent(...)
  end
end
return {
  ['setDisabled'] = function(v)
    isTerminateDisabled = v
  end,
  ['getDisabled'] = function()
    return isTerminateDisabled
  end,
}
