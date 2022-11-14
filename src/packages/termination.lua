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
  ['set'] = function() end,
  ['get'] = function()
    return isTerminateDisabled
  end,
}
