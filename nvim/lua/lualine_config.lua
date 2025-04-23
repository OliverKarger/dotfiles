local utils = require('utils')

local Module = {}

Module.Setup = function()
  local lualine = utils.SafeRequire('lualine')

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators  = { left = '', right = '' },
      -- component_separators = { left = '', right = '' },
      -- section_separators  = { left = '', right = '' },
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = true,
      disabled_filetypes = { "NvimTree", "packer", "COMMIT_EDITMSG" }
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          on_click = function()
            vim.cmd(':Fugit2Graph')
          end
        },
        {
          'diff',
          on_click = function()
            vim.cmd(':Fugit2Diff')
          end
        }
      },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress', 'location' },
      lualine_z = {
        {
          utils.GetCurrentTheme,
          on_click = function()
            vim.cmd(":Themery")
          end
        },
        {
          utils.GetAttachedLSP
        }
      },
    },
    extensions = { "fzf" },
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 2,
           max_length = vim.o.columns,
          show_filename_only = true,
          show_modified_status = true
        }
      }
    }
  })
end

return Module
