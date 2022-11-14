-- init script
require 'polyfills/table.create'
local console = require 'console'
console.clear()
print('Host:', _HOST)
print('Is Installer:', (installer and 'true' or 'false'))
sleep(0.25)
return require(installer and 'load-installer' or 'login')
