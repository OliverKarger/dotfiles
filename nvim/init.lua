-- "safe" require wrapper
local function safe_require(plugin)
	local success, result = pcall(require, plugin)
	if not success then
		print("Plugin Error: " .. plugin)
	end
	return result
end

-- Variables
local vim = vim
local Plug = vim.fn['plug#']
local keymap_opts = { noremap = true, silent = true }

-- Plugins

vim.call('plug#begin')

Plug('sheerun/vim-polyglot')
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
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

-- Global Settings
vim.o.termguicolors = true
vim.wo.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.updatetime = 100
vim.o.undodir = '~/.cache/nvim/undodir'
vim.o.undofile = true
vim.o.autoread = true
vim.o.ruler = true
vim.o.visualbell = true
vim.o.wrap = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd('filetype indent on')

-- Disable netrw (default Neovim Directory Browser)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Window Navigation
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', keymap_opts)

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
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', keymap_opts)

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

-- LSPConfig
local on_attach = function(client, bufnr)
    local opts_buffer = { noremap = true, silent = true, buffer = bufnr }
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings: LSP
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts_buffer)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts_buffer)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts_buffer)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts_buffer)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts_buffer)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts_buffer)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts_buffer)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts_buffer)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts_buffer)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts_buffer)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts_buffer)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts_buffer)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts_buffer)
    vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts_buffer)
end

safe_require('lspconfig').clangd.setup { on_attach = on_attach }
safe_require('lspconfig').omnisharp.setup { on_attach = on_attach }
safe_require('lspconfig').lua_ls.setup { on_attach = on_attach }
safe_require('lspconfig').bashls.setup { on_attach = on_attach }
safe_require('lspconfig').docker_compose_language_service.setup { on_attach = on_attach }
