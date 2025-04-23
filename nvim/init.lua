local utils = require('utils')
local settings = utils.SafeRequire('settings')

-- Ensure Packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    fn.system([[packeradd packer.nvim]])
  end
end
ensure_packer()

local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
  print("Failed to load Packer. Please restart")
  return
end

-- Packer setup
packer.startup(function(use)

  -- Common Utilities
  use 'nvim-lualine/lualine.nvim' -- Status Line
  use 'nvim-tree/nvim-web-devicons' -- Icons
  use 'stevearc/dressing.nvim' -- UI Improvements
  use 'rcarriga/nvim-notify' -- Notifications
  use 'nvim-lua/plenary.nvim'
  use 'wbthomason/packer.nvim'  -- Packer manages itself
  use 'sheerun/vim-polyglot'  -- Language support
  -- use 'jiangmiao/auto-pairs'  -- Auto pairs
  use 'MunifTanjim/nui.nvim' -- I don't know and certainly don't care
  use {
    'L3MON4D3/LuaSnip',
    run = "make install_jsregexp"
  }

  -- Themes
  use 'ellisonleao/gruvbox.nvim'      -- Gruvbox Theme
  use 'scottmckendry/cyberdream.nvim' -- Cyberdream Theme
  use 'olimorris/onedarkpro.nvim' -- One Dark Pro Theme
  use 'alexvzyl/nordic.nvim' -- Nordic Theme
  use 'bluz71/vim-moonfly-colors' -- Moonfly Colors Theme
  use 'maxmx03/fluoromachine.nvim' -- Synthwave84 x Fluoromachine Theme
  use 'sainnhe/everforest' -- Everforest Theme

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
  use 'rachartier/tiny-inline-diagnostic.nvim'

  -- Debugging and Testing
  use 'mfussenegger/nvim-dap' -- Deubg Adapter
  use 'rcarriga/nvim-dap-ui' -- Debug Adapter UI
  use 'nvim-neotest/nvim-nio' -- Test UI

  -- Utilities
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'nvim-pack/nvim-spectre' -- Search ad Replace Tool 
  use 'stevearc/overseer.nvim' -- Task Management
  use 'zaldih/themery.nvim' -- Theme Management
  use 'superbo/fugit2.nvim' -- Git GUI

end)

settings.ApplyKeymap()
settings.ApplyVimSettings()

-- Load Files
utils.LoadFiles( { 'lualine_config', 'ui_config', 'telescope_config', 'mason_config', 'lsp_config', 'dap_config' } )

-- Formatter Configuration
utils.SafeRequire('formatter').setup()

-- Open Config Command
vim.api.nvim_create_user_command("OpenConfig", function()
    local config_path = vim.fn.stdpath("config")
    vim.cmd("cd " .. config_path)
end, { bang = true, desc = "Open Neovim Config" })

-- Function to adjust Neovide scale
local function adjust_neovide_scale(amount)
  if vim.g.neovide_scale_factor == nil then
    vim.g.neovide_scale_factor = 1.0
  end
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + amount
end

-- Keybindings for zooming
vim.keymap.set("n", "<C-+>", function() adjust_neovide_scale(0.1) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", function() adjust_neovide_scale(-0.1) end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { noremap = true, silent = true }) -- Reset zoom
