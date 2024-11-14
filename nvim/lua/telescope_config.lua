local module = {}

local shared_config = require('shared')

function module.setup()
  vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', shared_config.keymap_opts)
  vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', shared_config.keymap_opts)
end

return module
