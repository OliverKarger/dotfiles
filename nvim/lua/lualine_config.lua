local utils = require('utils')

return {
  setup = function()
    local lualine = utils.safe_require('lualine')

    local function on_theme_click()
      vim.cmd(":Themery")
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        disabled_filetypes = { "NvimTree", "packer", "COMMIT_EDITMSG" }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress, location' },
        lualine_z = {
          {
            utils.get_current_theme,
            on_click = function()
              on_theme_click()
            end
          },
          {
            utils.get_attached_lsp
          }
        },
      },
      extensions = { "fzf" }
    })
  end
}

