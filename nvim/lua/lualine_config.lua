local safe_require = require('safe_require').safe_require

return {
  setup = function()
    local lualine = safe_require('lualine')
    lualine.setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' }
      }
    })
  end
}

