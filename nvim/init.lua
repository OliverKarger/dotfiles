local utils = require('utils')
local settings = utils.safe_require('settings')

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

  -- Common Utilities
  use 'nvim-lualine/lualine.nvim' -- Status Line
  use 'nvim-tree/nvim-web-devicons' -- Icons
  use 'stevearc/dressing.nvim' -- UI Improvements
  use 'rcarriga/nvim-notify' -- Notifications
  use 'nvim-lua/plenary.nvim'
  use 'wbthomason/packer.nvim'  -- Packer manages itself
  use 'sheerun/vim-polyglot'  -- Language support
  use 'jiangmiao/auto-pairs'  -- Auto pairs

  -- Themes
  use 'morhetz/gruvbox'      -- Gruvbox colorscheme
  use 'scottmckendry/cyberdream.nvim' -- Colorscheme

  -- File Browser
  use 'nvim-telescope/telescope.nvim' -- File Browser/Explorer
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  -- LSPs and Stuff 
  use 'neovim/nvim-lspconfig' -- LSP Configuration
  use 'hrsh7th/nvim-cmp' -- Autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- Autocompletion with LSPs
  use 'saadparwaiz1/cmp_luasnip' -- Lua Snippets
  use 'L3MON4D3/LuaSnip' -- Snippets
  use 'williamboman/mason.nvim' -- Mason for managing LSPs and Tools
  use 'williamboman/mason-lspconfig' -- Mason integration for lspconfig
  use 'mhartington/formatter.nvim' -- Formatter
  use 'mfussenegger/nvim-lint' -- Linter

  -- Debugging and Testing
  use 'mfussenegger/nvim-dap' -- Deubg Adapter
  use 'rcarriga/nvim-dap-ui' -- Debug Adapter UI
  use 'nvim-neotest/nvim-nio' -- Test UI

  -- Utilities
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'nvim-pack/nvim-spectre' -- Search ad Replace Tool 
  use 'stevearc/overseer.nvim' -- Task Management

end)

settings.keymaps()
settings.settings()

-- Colorscheme and Background
vim.cmd('colorscheme cyberdream')
vim.o.background = 'dark'

utils.load_files( { 'lualine_config', 'ui_config', 'spectre_config', 'telescope_config', 'mason_config', 'lsp_config', 'dap_config' } )

-- Task Management
utils.safe_require('overseer').setup()
vim.api.nvim_set_keymap('n', '<C-R>', ':OverseerRun<CR>', settings.keymap_opts)

-- Formatter Configuration
utils.safe_require('formatter').setup()
