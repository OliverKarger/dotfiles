local utils = require('utils')

return {
  setup = function()
    local lualine = utils.safe_require('lualine')
    lualine.setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_y = { 'filename', 'filetype', 'progress' },
        lualine_z = {
          function()
            local clients = vim.lsp.get_active_clients()
            if #clients == 0 then
              return 'No LSP'
            end
            -- Get the name of the first active LSP client
            return clients[1].name
          end, -- Custom component to display LSP name
        },
      },
    })
  end
}

