if not fs.exists '/basalt.lua' then
  local url = 'https://raw.githubusercontent.com/MokiyCodes/cco/main/basalt.lua'
  local f = fs.open('/basalt.lua', 'w')
  local rq = http.get(url)
  f.write(rq.readAll())
  f.close()
  rq.close()
end
local file = fs.open('/basalt.lua', 'r')
---@diagnostic disable-next-line: deprecated
local chunk, err = (load or loadstring)(file.readAll())
file.close()
if not chunk then
  error(err)
end
local basalt = chunk()
_G.libs = _G.libs or {}
_G.libs.basalt = basalt
return basalt
