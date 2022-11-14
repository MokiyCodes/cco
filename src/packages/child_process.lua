---@diagnostic disable: deprecated
local cid = 0
return {
  ['execSync'] = function(process, ...)
    error 'non-functional as of now'
    -- return shell.execute(process, ...)
  end,
  ['execLuaSync'] = function(lua, chunk)
    cid = cid + 1
    local c, ex = loadstring(lua, chunk or ('Unknown Chunk Name - Chunk #' .. tostring(cid)))
    if not c then
      error('Compilation Error: ' .. ex)
    end
    return c()
  end,
}
