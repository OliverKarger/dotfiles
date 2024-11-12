-- Plugins
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('sheerun/vim-polyglot')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('jiangmiao/auto-pairs')
Plug('morhetz/gruvbox')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('junegunn/fzf', { ['do'] = function() 
	vim.fn['fzf#install']()
	end })
Plug('junegunn/fzf.vim')
Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' })
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/vim-vsnip-integ')

vim.call('plug#end')


-- Global Settings
vim.o.termguicolors = true
vim.wo.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.cmd('filetype indent on')

-- Disable netrw (default Neovim Directory Browser)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Toggleterm
require("toggleterm").setup({})

-- Telescope File Browser
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
-- Key Mappings for Telescope File Browser
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- Mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
-- Mason LSP
require('mason-lspconfig').setup({
	automatic_installation = true,
	ensure_installed = { "omnisharp", "lua_ls", "clangd", "bashls", "docker_compose_language_service" }
})

-- Lualine
require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'gruvbox-material',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' }
	}
})

-- Colorscheme
vim.cmd('colorscheme gruvbox')
vim.o.background = 'dark'

-- Window Navigation
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', { noremap = true, silent = true })

