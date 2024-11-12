-- Load Plugins
-- Assuming you're using vim-plug in the `vim-plug/plugins.vim` file
vim.cmd('source ' .. vim.fn.expand('~') .. '/.config/nvim/vim-plug/plugins.vim')

-- --- Settings: Start ---
vim.o.termguicolors = true
vim.wo.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.cmd('filetype indent on')

-- Disable netrw (default file explorer in Neovim)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
-- --- Settings: End ---

-- --- Toggleterm: Start ---
require("toggleterm").setup({})
-- --- Toggleterm: End ---

-- --- Telescope: Start ---
require('telescope').setup {
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
    }
  }
}

-- Key mappings for Telescope
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- --- Telescope: End ---

-- --- LSP: Start ---
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
require('mason-lspconfig').setup({
	automatic_installation = true,
	ensure_installed = { "csharpier", "lua_ls", "clangd", "cmakelang", "bashls", "docker_compose_language_service" }
})
-- --- LSP: End ---

-- --- Color Scheme: Start ---
vim.cmd('colorscheme gruvbox')
vim.o.background = 'dark'
vim.g.airline_theme = 'wombat'

-- Key mappings for Gruvbox highlighting
vim.api.nvim_set_keymap('n', '[oh', ':call gruvbox#hls_show()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']oh', ':call gruvbox#hls_hide()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'coh', ':call gruvbox#hls_toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '*', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>*', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '/', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>/', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '?', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>?', { noremap = true, silent = true })
-- --- Color Scheme: End ---

-- --- Window Navigation: Start ---
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', { noremap = true, silent = true })
-- --- Window Navigation: End ---

