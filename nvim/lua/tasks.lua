local utils = require('utils')
local _M = {}

_M.setup = function()
  utils.safe_require('overseer').setup()
end

return _M
