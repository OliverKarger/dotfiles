local utils = require('utils')

local Module = {}

Module.Setup = function()
  utils.safe_require('formatter').setup()
end

return Module
