-- "safe" require wrapper
local function safe_require(plugin)
	local success, result = pcall(require, plugin)
	if not success then
		print("Plugin Error: " .. plugin)
	end
	return result
end

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
Plug('scottmckendry/cyberdream.nvim')
Plug('mfussenegger/nvim-dap')
Plug('mfussenegger/nvim-lint')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('mhartington/formatter.nvim')
Plug('nvim-pack/nvim-spectre')

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

-- Window Navigation
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', { noremap = true, silent = true })

-- Spectre Search
vim.keymap.set('n', '<C-f>s', '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre"		
})
vim.keymap.set('n', '<C-f>w', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
		desc = "Search current Word"
})

-- Colorscheme
vim.cmd('colorscheme cyberdream')
vim.o.background = 'dark'

-- Lualine
safe_require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' }
	}
})

-- Telescope File Browser
safe_require('telescope').setup {
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

-- Toggleterm
safe_require("toggleterm").setup({})

-- Mason
safe_require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason LSP
safe_require('mason-lspconfig').setup({
	automatic_installation = true,
	ensure_installed = { "omnisharp", "lua_ls", "clangd", "bashls", "docker_compose_language_service" }
})

-- Formatter
safe_require('formatter').setup()
