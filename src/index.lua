local console = require 'console'
_G.console = console
if isStartup then
  require('termination').setDisabled(true)
end
if installer and (not term.isColor or not term.isColor()) then
  console.clear()
  print 'Warning: On non-colour displays, the main UI is replaced with a "lite" UI.\nContinue? [Y/n]'
  if string.lower(string.sub(read(), 1, 1)) == 'n' then
    print 'Aborted.'
    return
  end
end
-- init script
require 'polyfills/table.create'
require 'networking/secnet'
require 'installationid'
_G.sha = require 'deepcopy'(require 'hash')
console.clear()
print('Host:', _HOST)
print('Is Installer:', (installer and 'true' or 'false'))
return require(installer and 'load-installer' or 'login')
