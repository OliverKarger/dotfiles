local utils = require('utils')
local settings = utils.safe_require('settings')

local _M = {}

_M.setup = function()
  utils.safe_require('overseer').setup()
  vim.api.nvim_set_keymap('n', '<C-R>', ':OverseerRun<CR>', settings.keymap_opts)
end

return _M
