-- Yielding's Bundler Prefix Script
-- Forked & Stripped by Mokiy
-- Copyright (c) 2022 YieldingExploiter.
-- Copyright (c) 2022 MokiyCodes.
-- MIT License

local args = { ... }
local null = nil -- null is better than nil, change my mind
local modules = {} -- we will assign modules to here later
local require = function(...) -- handle loading modules
  local requested, returned = { ... }, {}
  for _, filepath in pairs(requested) do
    if not modules[filepath] then
      table.insert(returned, oldRequire(filepath) or error('[blb] no such module \'' .. filepath .. '\''))
    else
      local module = modules[filepath]
      if module.isCached then
        table.insert(returned, module.cache)
      else
        local moduleValue = module.load()
        module.cache = moduleValue
        module.isCached = true
        table.insert(returned, module.cache)
      end
    end
  end
  return table.unpack(returned)
end
