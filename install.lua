---@diagnostic disable: deprecated
_G.typeof = _G.typeof or _G.type or type
local flags = {}
for _, o in pairs { ... } do
  flags[string.lower(string.gsub(o, '-', ''))] = true
end
local loadbundle = function(bundle)
  _G.bundle = bundle
  print 'Compiling CCO...'
  local b, ce =
    loadstring('local installer = true;local thisBundle = _G.bundle;_G.bundle=nil;' .. bundle, 'installer bundle')
  if typeof(b) ~= 'function' then
    error('Compilation Error: ' .. (ce or b or 'Unknown Error'))
  end
  print 'Loading Installer...'
  b()
end
print 'Downloading CCO...'
if fs.exists '/cco.lua' then
  fs.delete '/cco.lua'
end
if fs.exists '/startup.lua' then
  fs.delete '/startup.lua'
end
if fs.exists '/basalt.lua' then
  fs.delete '/basalt.lua'
end
if flags['devserver'] or (os.about and string.find(os.about(), 'CraftOS-PC')) then
  -- ComputerCraft Development Loader
  local _http_url = 'http://127.0.0.1:16969/build.lua';
  (function(rq)
    if not rq then
      ---@diagnostic disable-next-line: undefined-global
      local checkSuccess, checkException = http.checkURL(_http_url)
      if checkException or not checkSuccess then
        error(
          'HTTP URL Check failed with: '
            .. checkException
            .. '\nYou may need to tweak your computercraft config (.minecraft/config/computercraft.cfg for local) to allow 127.0.0.0'
        )
      end
      error 'HTTP Failed - Unknown Reason. Check that the server is accessible.'
    end
    loadbundle(rq.readAll())
    rq.close()
    ---@diagnostic disable-next-line: undefined-global
  end)(http.get(_http_url))
else
  shell.run 'wget https://raw.githubusercontent.com/MokiyCodes/cco/main/out.lua'
  fs.move('out.lua', 'install-cco.lua')
  local file = fs.open('install-cco', 'r')
  local data = (file.readAll())
  file.close()
  fs.delete 'install-cco.lua'
  loadbundle(data)
end
