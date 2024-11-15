return {
  keymap_opts = { noremap = true, silent = true },
  lsp_servers = { "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service", "pyright" },
  keymaps = function()
    local keymap_opts = { noremap = true, silent = true }

    -- Window Navigation Keybindings
    vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', keymap_opts)
    vim.api.nvim_set_keymap('n', '<C-t>', '<Nop>', keymap_opts)
  end,

  settings = function()
    -- General Neovim Settings
    vim.opt.termguicolors = true       -- Enable true colors
    vim.wo.number = true               -- Show line numbers
    vim.wo.relativenumber = true       -- Relative Line Numbers
    vim.opt.shiftwidth = 4             -- Indentation width
    vim.opt.tabstop = 4               -- Tab width
    vim.opt.updatetime = 100          -- Faster completion
    vim.opt.autoread = true           -- Auto-read files changed outside Neovim
    vim.opt.ruler = true              -- Show cursor position
    vim.opt.visualbell = true         -- Visual bell instead of audible bell
    vim.opt.wrap = true               -- Wrap lines
    vim.opt.autoindent = true         -- Auto indentation
    vim.opt.smartindent = true        -- Smart indentation
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = "1"
    vim.cmd('filetype indent on')   -- Enable filetype-based indentation

    -- Disable netrw (default Neovim Directory Browser)
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
  end
}
