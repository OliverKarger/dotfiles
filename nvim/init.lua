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
local lsp_servers = { "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service" }

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
Plug('scottmckendry/cyberdream.nvim')
Plug('mfussenegger/nvim-dap')
Plug('mfussenegger/nvim-lint')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('mhartington/formatter.nvim')
Plug('nvim-pack/nvim-spectre')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('saadparwaiz1/cmp_luasnip')
Plug('L3MON4D3/LuaSnip')

vim.call('plug#end')

-- Global Settings
vim.o.termguicolors = true
vim.wo.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.updatetime = 100
-- vim.o.undodir = '~/.cache/nvim/undodir'
-- vim.o.undofile = true
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
	ensure_installed = lsp_servers
})

-- Formatter
safe_require('formatter').setup()

-- LSPConfig
for _, lsp in ipairs(lsp_servers) do
	safe_require('lspconfig')[lsp].setup {}
end

-- Snippets
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
