local utils = require('utils')

local _M = {}

_M.setup = function()
  local mason = utils.safe_require('mason')
  mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
end

return _M
