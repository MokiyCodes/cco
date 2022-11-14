return function()
  os.queueEvent 'fakeEvent'
  os.pullEvent()
end
