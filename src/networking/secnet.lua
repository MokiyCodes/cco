---@diagnostic disable: deprecated
local sha, xor, json = require 'hash', require 'xor', require 'json'
local secnet = {}
_G.secureCommunications = secnet
_G.secnet = secnet
--- Starts listening on to rednet on all peripherals. If you only want to listen on specific ones, manually call rednet.open on those.
secnet.listen = function()
  peripheral.find('modem', rednet.open)
end
--- Creates and/or joins a new secnet channel, provides an API to interact with it | Channel & Password combinatiton matters to be able to receive data.
secnet.new = function(channel, pass)
  if not channel then
    error 'You must provide a channel!'
  end
  if not pass then
    error 'You must provide a password!'
  end
  local self = {}
  --- Encryption Key. Derived from Channel & Password.
  self.key = xor(sha.hmac(sha.sha3_512, pass, xor(channel, pass)), sha.sha3_512(pass))
  --- Internal Channel ID to listen to; hash of the channel as to avoid leaking the channel name publicly in broadcasts
  self.channelId = sha.sha3_512(string.rep(channel, 2))
  self.prefix = '++cco.secure-communications++\n+++channel+' .. self.channelId .. '+++'
  --- Broadcast message to all devices listening on channel
  self.broadcast = function(message, ...)
    if not message then
      error 'Must provide a message'
    end
    message = json.stringify { message, ... }
    rednet.broadcast(self.prefix .. xor(message, self.key))
    return self
  end
  --- Send message to device with id listening on channel
  self.send = function(id, message, ...)
    if not message then
      error 'Must provide a message'
    end
    message = json.stringify { message, ... }
    rednet.send(id, self.prefix .. xor(message, self.key))
    return self
  end
  --- Awaits a message with a specific timeout & an optional filter function | Ignores unparsable (/invalid password) entities | Returns sender, ...message
  self.receive = function(timeout, filter)
    filter = filter or (typeof(timeout) == 'function' and timeout) or function()
      return true
    end
    if typeof(timeout) ~= 'number' then
      timeout = nil
    end
    local finalMessage
    local endTime = os.clock() + (timeout or math.huge)
    local sender
    repeat
      -- wait for message
      local senderId, encryptedMessageWithPrefix = rednet.receive(endTime - os.clock())
      if encryptedMessageWithPrefix then
        -- check if its for us
        if string.sub(encryptedMessageWithPrefix, 1, #self.prefix) == self.prefix then
          -- strip prefix
          local encryptedMessage = string.sub(encryptedMessageWithPrefix, #self.prefix + 1)
          -- decrypt
          local decryptedMessage = xor(encryptedMessage, self.key)
          -- parse
          local s, rt = pcall(json.parse, decryptedMessage)
          if s then
            finalMessage = rt
            sender = senderId
          end
          -- else
          --   print('Debug: Message not for us', encryptedMessageWithPrefix, '\nExpected prefix', self.prefix)
        end
      end
    until finalMessage or os.clock() >= endTime
    ---@diagnostic disable-next-line: param-type-mismatch
    return sender, (table.unpack or unpack)(finalMessage)
  end
  return self
end
