local _M = {}

_M.keymap_opts = { noremap = true, silent = true }
_M.lsp_servers = { "ansiblels", "ansible-lint", "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service", "pyright", "rust-analyzer", "codelldb" }
_M.set_keymaps = function()
  local keymap_opts = { noremap = true, silent = true }
  local map = vim.api.nvim_set_keymap

  -- Unbind
  map('n', '<C-t>', '<Nop>', keymap_opts)
  map('i', '"', '"', keymap_opts)
  map('i', "'", "'", keymap_opts)

  -- Window Navigation Keybindings
  map('n', '<leader>wu', '<C-w>k', keymap_opts)
  map('n', '<leader>wd', '<C-w>j', keymap_opts)
  map('n', '<leader>wl', '<C-w>h', keymap_opts)
  map('n', '<leader>wr', '<C-w>l', keymap_opts)
  map('n', '<leader>wv', ':vsplit<CR>', keymap_opts)
  map('n', '<leader>wh', ':split<CR>', keymap_opts)
  map('n', '<leader>wt', ':term<CR>', keymap_opts)

  -- Tabs
  map('n', '<leader>tn', ':tabnew<CR>', keymap_opts)
  map('n', '<leader>tc', ':tabclose<CR>', keymap_opts)
  for i = 1, 8 do -- map <leader>t1-8 to tabs 1-8
    map('n', '<leader>t' .. i, i .. 'gt', keymap_opts)
  end

  -- Telescope Keymaps 
  map('n', '<leader>ff', ':Telescope find_files<CR>', _M.keymap_opts)
  map('n', '<leader>fe', ':Telescope file_browser<CR>', _M.keymap_opts)
  map('n', '<leader>fg', ':Telescope live_grep<CR>', _M.keymap_opts)
  map('n', '<leader>fh', ':Telescope help_tags<CR>', _M.keymap_opts)

  -- Spectre
  map('n', '<leader>st', '<cmd>lua require("spectre").toggle()<CR>', _M.keymap_opts)
  map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', _M.keymap_opts)
  map('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', _M.keymap_opts)

  -- Debug Adapter
end

_M.set_common = function()
  -- General Neovim Settings
  vim.opt.termguicolors = true       -- Enable true colors
  vim.wo.number = true               -- Show line numbers
  vim.wo.relativenumber = true       -- Relative Line Numbers
  vim.opt.shiftwidth = 4             -- Indentation width
  vim.opt.tabstop = 4                -- Tab width
  vim.opt.updatetime = 100           -- Faster completion
  vim.opt.autoread = true            -- Auto-read files changed outside Neovim
  vim.opt.ruler = true               -- Show cursor position
  vim.opt.visualbell = true          -- Visual bell instead of audible bell
  vim.opt.wrap = true                -- Wrap lines
  vim.opt.autoindent = true          -- Auto indentation
  vim.opt.smartindent = true         -- Smart indentation
  vim.opt.showtabline = 1
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = "1"
  vim.cmd('filetype indent on')     -- Enable filetype-based indentation
  vim.opt.clipboard = "unnamedplus" -- Enable Copy/Paste to/from System Clipboard
  vim.opt.colorcolumn = "120"       -- Max 120 Characters per Line

  vim.o.linespace = 5               -- Line Height

  -- Disable netrw (default Neovim Directory Browser)
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

_M.lsp_settings = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'jit' }
        }
      }
    }
  },
  clangd = {
    cmd = { "clangd", "--clang-tidy" }
  }
}

return _M
