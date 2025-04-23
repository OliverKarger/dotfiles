local utils = require('utils')
local settings = require('settings')

local Module = {}

Module.Setup = function()
  local telescope = utils.SafeRequire('telescope')

  telescope.setup {
    defaults = {
      find_command = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--binary-files=without-match',  -- Ignore binary files
        '--type=f'
      },
      file_ignore_patterns = { "*.git/*", "bin/*", "obj/*" },
    },
    extension = {
      ["ui-select"] = {
        utils.SafeRequire('telescope.themes').get_dropdown {}
      }
    }
  }

  telescope.load_extension("ui-select")
end

return Module
