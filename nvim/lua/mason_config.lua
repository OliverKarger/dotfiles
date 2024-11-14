local safe_require = require('safe_require').safe_require

local module = {}

function module.setup()
  safe_require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
end

return module
