local utils = require('utils')

local Module = {}

Module.Setup = function()
  local mason = utils.SafeRequire('mason')
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

return Module
