---@diagnostic disable: lowercase-global
-- https://github.com/Braayy/xor-lua/blob/master/xor.lua
-- MIT
-- too lazy to implement my own xor & my og aes doesnt work in cc on 1.12.2 for some reason
local repeat_key = function(key, length)
  if #key >= length then
    return key:sub(1, length)
  end

  times = math.floor(length / #key)
  remain = length % #key

  result = ''

  for _ = 1, times do
    result = result .. key
  end

  if remain > 0 then
    result = result .. key:sub(1, remain)
  end

  return result
end

local xor = function(message, key)
  rkey = repeat_key(key, #message)

  result = ''

  for i = 1, #message do
    k_char = rkey:sub(i, i)
    m_char = message:sub(i, i)

    k_byte = k_char:byte()
    m_byte = m_char:byte()

    xor_byte = require('bitop').bxor(m_byte, k_byte)

    xor_char = string.char(xor_byte)

    result = result .. xor_char
  end

  return result
end

return xor
