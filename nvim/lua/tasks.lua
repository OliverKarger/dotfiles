local utils = require('utils')
local settings = utils.safe_require('settings')

local _M = {}

_M.setup = function()
  utils.safe_require('overseer').setup()
end

return _M
