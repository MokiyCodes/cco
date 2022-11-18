local progs = {
  ['System'] = {
    ['Update'] = '/rom/programs/http/wget.lua run https://raw.githubusercontent.com/MokiyCodes/cco/main/install.lua',
    ['Power'] = {
      ['Reboot'] = function()
        os.reboot()
      end,
      ['Shutdown'] = function()
        os.shutdown()
      end,
    },
  },
  ['Network'] = {
    ['Chat'] = function()
      console.log 'Hi!\nPlease enter the name of the room you want to join.'
      local room = read()
      console.clear()
      console.log 'Please enter the username you want to join as.'
      local uname = read()
      shell.run(string.format('/rom/programs/rednet/chat.lua join %s %s', room, uname))
    end,
  },
  ['Shell'] = fs.exists '/shell.lua' and '/shell.lua'
    or fs.exists '/mbs.lua' and '/mbs.lua startup'
    or '/rom/programs/shell.lua',
}
if fs.exists '/.cco/programs.json' then
  local progsFile = fs.open('/.cco/', 'r')
  local progsRaw = progsFile.readAll()
  progsFile.close()
  local progsExtra = require('json').parse(progsRaw)
  local doStuff
  doStuff = function(t, t2)
    for k, v in pairs(t) do
      if type(v) == 'table' then
        doStuff(v, t2[k])
      else
        t[k] = t[k] or t2[k]
      end
    end
  end
  doStuff(progsExtra, progs)
  ---@diagnostic disable-next-line: cast-local-type
  progs = progsExtra
end
return progs
