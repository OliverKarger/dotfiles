-- "safe" require wrapper
local function safe_require(plugin)
  local success, result = pcall(require, plugin)
  if not success then
    print("Plugin Error: " .. plugin)
	print(result)
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

-- General Plugins
Plug('sheerun/vim-polyglot')            -- Polyglot for language support
Plug('jiangmiao/auto-pairs')            -- Auto pair brackets
Plug('williamboman/mason.nvim')        -- Mason for LSP management
Plug('williamboman/mason-lspconfig.nvim') -- Mason LSP config
Plug('nvim-lualine/lualine.nvim')      -- Lualine statusline
Plug('nvim-tree/nvim-web-devicons')    -- File icons for Neovim
Plug('nvim-lua/plenary.nvim')          -- Utility library for Neovim
Plug('nvim-telescope/telescope.nvim')  -- Telescope fuzzy finder
Plug('nvim-telescope/telescope-file-browser.nvim') -- Telescope file browser
Plug('junegunn/fzf')                  -- FZF plugin for fast file searching
Plug('junegunn/fzf.vim')              -- FZF Vim integration
Plug('akinsho/toggleterm.nvim', { ['tag'] = '*' }) -- Terminal toggler
Plug('scottmckendry/cyberdream.nvim')  -- Cyberdream colorscheme
Plug('mfussenegger/nvim-dap')         -- Debugger integration
Plug('mfussenegger/nvim-lint')        -- Linting support
Plug('nvim-neotest/nvim-nio')         -- Neotest plugin
Plug('rcarriga/nvim-dap-ui')          -- DAP UI for Neovim
Plug('mhartington/formatter.nvim')    -- Code formatting
Plug('nvim-pack/nvim-spectre')        -- Search and replace in files
Plug('neovim/nvim-lspconfig')         -- LSP configurations
Plug('hrsh7th/nvim-cmp')              -- Completion plugin
Plug('hrsh7th/cmp-nvim-lsp')          -- LSP completion source
Plug('saadparwaiz1/cmp_luasnip')      -- LuaSnip completion source
Plug('L3MON4D3/LuaSnip')              -- Snippet engine
Plug('folke/which-key.nvim')          -- Keybinding Suggestions

vim.call('plug#end')

-- General Neovim Settings
vim.opt.termguicolors = true       -- Enable true colors
vim.wo.number = true             -- Show line numbers
vim.opt.shiftwidth = 4             -- Indentation width
vim.opt.tabstop = 4               -- Tab width
vim.opt.updatetime = 100          -- Faster completion
vim.opt.autoread = true           -- Auto-read files changed outside Neovim
vim.opt.ruler = true              -- Show cursor position
vim.opt.visualbell = true         -- Visual bell instead of audible bell
vim.opt.wrap = true               -- Wrap lines
vim.opt.autoindent = true         -- Auto indentation
vim.opt.smartindent = true        -- Smart indentation
vim.cmd('filetype indent on')   -- Enable filetype-based indentation

-- Disable netrw (default Neovim Directory Browser)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Window Navigation Keybindings
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', keymap_opts)

-- Setup which-key
require('which-key').setup {}

-- Spectre Search Keybindings
vim.keymap.set('n', '<C-f>s', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<C-f>w', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search current Word"
})

-- Colorscheme and Background
vim.cmd('colorscheme cyberdream')
vim.o.background = 'dark'

-- Lualine Configuration
safe_require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' }
  }
})

-- Telescope Configuration
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
    },
	file_ignore_patterns = { "*.git/*", "bin/*", "obj/*" }
  }
}

-- Telescope Keybindings
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', keymap_opts)

-- Toggleterm Configuration
safe_require("toggleterm").setup()

-- Mason Plugin Configuration
safe_require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason LSP Configuration
safe_require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = lsp_servers
})

-- Formatter Configuration
safe_require('formatter').setup()

-- LSPConfig Setup
for _, lsp in ipairs(lsp_servers) do
  safe_require('lspconfig')[lsp].setup {}
end

-- Snippets and Completion Setup
local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Scroll up
    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Scroll down
    ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
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
	{ name = 'buffer' },
	{ name = 'path' }
  },
  completion = {
	  autocomplete = { cmp.TriggerEvent.TextChanged }
  }
}

