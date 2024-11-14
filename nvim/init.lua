local safe_require = require('safe_require').safe_require
local shared_config = require('shared')

-- Variables
local vim = vim

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
  use 'wbthomason/packer.nvim'  -- Packer manages itself
  use 'sheerun/vim-polyglot'  -- Language support
  use 'jiangmiao/auto-pairs'  -- Auto pairs
  use 'morhetz/gruvbox'      -- Gruvbox colorscheme
  use 'nvim-lualine/lualine.nvim' -- Status Line
  use 'nvim-tree/nvim-web-devicons' -- Icons
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim' -- File Browser/Explorer
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'scottmckendry/cyberdream.nvim' -- Colorscheme
  use 'mfussenegger/nvim-dap' -- Deubg Adapter
  use 'rcarriga/nvim-dap-ui' -- Debug Adapter UI
  use 'mhartington/formatter.nvim' -- Formatter
  use 'mfussenegger/nvim-lint' -- Linter
  use 'nvim-pack/nvim-spectre' -- Search ad Replace Tool
  use 'neovim/nvim-lspconfig' -- LSP Configuration
  use 'hrsh7th/nvim-cmp' -- Autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- Autocompletion with LSPs
  use 'saadparwaiz1/cmp_luasnip' -- Lua Snippets
  use 'L3MON4D3/LuaSnip' -- Snippets
  use 'williamboman/mason.nvim' -- Mason for managing LSPs and Tools
  use 'williamboman/mason-lspconfig' -- Mason integration for lspconfig
end)

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
vim.cmd('filetype indent on')   -- Enable filetype-based indentation

-- Disable netrw (default Neovim Directory Browser)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Window Navigation Keybindings
vim.api.nvim_set_keymap('n', '<C-w><Up>', '<C-w>k', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Down>', '<C-w>j', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Left>', '<C-w>h', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w><Right>', '<C-w>l', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>v', ':vsplit<CR>', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>h', ':split<CR>', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-w>T', ':term<CR>', shared_config.keymap_opts)
vim.api.nvim_set_keymap('n', '<C-t>', '<Nop>', shared_config.keymap_opts)

-- Colorscheme and Background
vim.cmd('colorscheme cyberdream')
vim.o.background = 'dark'

require('lualine_config').setup()
require('spectre_config').setup()
require('telescope_config').setup()
require('mason_config').setup()
require('lsp_config').setup()

-- Formatter Configuration
safe_require('formatter').setup()
