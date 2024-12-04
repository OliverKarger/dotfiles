local utils = require('utils')
local settings = require('settings')

local _M = {}

_M.setup = function()
  local telescope = utils.safe_require('telescope')

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
        utils.safe_require('telescope.themes').get_dropdown {}
      }
    }
  }

  telescope.load_extension("ui-select")

  vim.api.nvim_set_keymap('n', '<leader>fe', ':Telescope file_browser<CR>', settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope find_files<CR>', settings.keymap_opts)
end

return _M
