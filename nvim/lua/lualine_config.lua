local module = {}

local safe_require = require('safe_require').safe_require
local lualine = safe_require('lualine')

function module.setup() 
  safe_require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' }
    }
  })
end

return module
