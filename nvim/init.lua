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
local lsp_servers = { "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service", "pyright" }

-- Plugins

-- Ensure Packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end
ensure_packer()

-- Packer setup
require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'  -- Packer manages itself

  -- General Plugins
  use 'sheerun/vim-polyglot'  -- Language support
  use 'jiangmiao/auto-pairs'  -- Auto pairs
  use 'morhetz/gruvbox'      -- Gruvbox colorscheme

  -- Lualine for the status line
  use 'nvim-lualine/lualine.nvim'

  -- File icons
  use 'nvim-tree/nvim-web-devicons'

  -- Plenary, a dependency for several other plugins
  use 'nvim-lua/plenary.nvim'

  -- Telescope for fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',  -- Main Telescope plugin
    requires = { 'nvim-lua/plenary.nvim' },  -- Dependency for Telescope
    cmd = 'Telescope',  -- Lazy-load on command
    config = function()
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
          },
          file_ignore_patterns = { "*.git/*", "bin/*", "obj/*" }
        }
      }
    end
  }


  -- Telescope file browser
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
  }

  -- FZF Vim integration
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end,  -- Install FZF
    opt = true  -- Lazy-load
  }

  use {
    'junegunn/fzf.vim',
    opt = true  -- Lazy-load
  }


  -- Toggleterm for terminal integration
  use {
    'akinsho/toggleterm.nvim',
    tag = '*',  -- Latest version
    cmd = 'ToggleTerm',  -- Lazy-load on command
    config = function()
      require("toggleterm").setup()
    end
  }

  -- Cyberdream colorscheme
  use 'scottmckendry/cyberdream.nvim'

  -- Debugger
  use 'mfussenegger/nvim-dap'

  -- Linting
  use 'mfussenegger/nvim-lint'

  -- Neotest for testing
  use 'nvim-neotest/nvim-nio'

  -- DAP UI
  use 'rcarriga/nvim-dap-ui'

  -- Formatter
  use 'mhartington/formatter.nvim'

  -- Search and replace
  use 'nvim-pack/nvim-spectre'

  -- LSP config
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- Mason for managing LSP servers and tools
  use 'williamboman/mason.nvim'

  -- Lazy-load Mason LSP config (only when needed)
  use {
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',  -- Load after Mason is loaded
    config = function()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = lsp_servers
      })
    end
  }

end)

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
-- require('which-key').setup {}

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

-- Telescope Keybindings
vim.api.nvim_set_keymap('n', '<C-e>', ':Telescope file_browser<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-s>', ':Telescope find_files<CR>', keymap_opts)

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


