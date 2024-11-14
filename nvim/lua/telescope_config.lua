local safe_require = require('safe_require').safe_require

return {
  setup = function()
    local telescope = safe_require('telescope')
    local keymap_opts = require('shared').keymap_opts
    
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
          safe_require('telescope.themes').get_dropdown {}
        }
      }
    }

    telescope.load_extension("ui-select")

    vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', keymap_opts)
  end
}
