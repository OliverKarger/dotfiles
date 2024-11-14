local safe_require = require('safe_require').safe_require

return {
  setup = function()
    local mason = safe_require('mason')
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
}
