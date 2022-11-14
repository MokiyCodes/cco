local console = require 'console'
if isStartup then
  require('termination').setDisabled(true)
end
if not term.isColor or not term.isColor() then
  local err = function(t)
    (isStartup and print or error)(t)
    if isStartup then
      sleep(3)
      os.shutdown()
    end
  end
  return err 'This is not a colour display. We only support colour displays.\nGoodbye.\n\nP.S. '
    .. (
      installer
        and 'If you aren\'t planning on running this on startup, you can use the monitor command on a colour display to use this anyways.\nNote that this may lead to undesireable side-effects & may brick this device. Be careful.'
      or 'You can still run \'monitor <monitor> cco\' to run this.'
    )
  -- WIP:
  -- local monitors = { peripheral.find 'monitor' }
  -- local monitorsByName = {}
  -- local hasColour = false
  -- for _, o in pairs(monitors) do
  --   if o.isColour() then
  --     monitorsByName[peripheral.getName(o)] = o
  --     hasColour = true
  --   end
  -- end
  -- if #monitors == 0 or not hasColour then
  --   err 'Please connect an advanced monitor or run this on an advanced (golden) computer.'
  -- end
  -- if not isStartup then
  --   print 'This display is not a colour display.\nExternal Colour Display Support is highly experimental.\nType \'YES\' in all caps to continue anyway.\n\nContinue?'
  --   if read() ~= 'YES' then
  --     error 'Aborting.'
  --     return
  --   end
  -- end
  -- local response = ''
  -- while not monitorsByName[response] do
  --   console.clear()
  --   print 'Please input a monitor to use.\nAvailable colour monitors:'
  --   for name in pairs(monitorsByName) do
  --     print('-', name)
  --   end
  --   print 'Note: You\'ll still need to perform keyboard input on this device.\nSelected Montior:'
  --   response = read()
  -- end
  -- console.clear()
  -- console.centerLog 'Please continue on the monitor.\nInput text here.'
  -- term.redirect(monitorsByName[response])
end
-- init script
require 'polyfills/table.create'
console.clear()
print('Host:', _HOST)
print('Is Installer:', (installer and 'true' or 'false'))
return require(installer and 'load-installer' or 'login')
