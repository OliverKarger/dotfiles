local Module = {}

Module.KeymapOptions = { noremap = true, silent = true }

Module.LSPServers = { "ansiblels", "ansible-lint", "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service", "pyright", "rust-analyzer", "codelldb" }

Module.ApplyKeymap = function()
  local map = vim.keymap.set
  local nmap = vim.api.nvim_set_keymap
  
  -- Unbind
  map('n', '<C-t>', '<Nop>', Module.KeymapOptions)
  map('i', '"', '"', Module.KeymapOptions)
  map('i', "'", "'", Module.KeymapOptions)

  -- Window Navigation Keybindings
  map('n', '<leader>wu', '<C-w>k', Module.KeymapOptions)
  map('n', '<leader>wd', '<C-w>j', Module.KeymapOptions)
  map('n', '<leader>wl', '<C-w>h', Module.KeymapOptions)
  map('n', '<leader>wr', '<C-w>l', Module.KeymapOptions)
  map('n', '<leader>wv', ':vsplit<CR>', Module.KeymapOptions)
  map('n', '<leader>wh', ':split<CR>', Module.KeymapOptions)
  map('n', '<leader>wt', ':term<CR>', Module.KeymapOptions)

  -- Tabs
  map('n', '<leader>tn', ':tabnew<CR>', Module.KeymapOptions)
  map('n', '<leader>tc', ':tabclose<CR>', Module.KeymapOptions)
  for i = 1, 8 do -- map <leader>t1-8 to tabs 1-8
    map('n', '<leader>t' .. i, i .. 'gt', Module.KeymapOptions)
  end

  -- Telescope Keymaps 
  map('n', '<leader>ff', ':Telescope find_files<CR>', Module.KeymapOptions)
  map('n', '<leader>fe', ':Telescope file_browser<CR>', Module.KeymapOptions)
  map('n', '<leader>fg', ':Telescope live_grep<CR>', Module.KeymapOptions)
  map('n', '<leader>fh', ':Telescope help_tags<CR>', Module.KeymapOptions)

  -- Spectre
  map('n', '<leader>st', '<cmd>lua require("spectre").toggle()<CR>', Module.KeymapOptions)
  map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', Module.KeymapOptions)
  map('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', Module.KeymapOptions)

  -- Debug Adapter
end

Module.ApplyVimSettings = function()
  -- General Neovim Settings
  vim.opt.termguicolors = true       -- Enable true colors
  vim.wo.number = true               -- Show line numbers
  vim.wo.relativenumber = true       -- Relative Line Numbers
  vim.opt.shiftwidth = 4             -- Indentation width
  vim.opt.tabstop = 4                -- Tab width
  vim.opt.updatetime = 100           -- Faster completion
  vim.opt.autoread = true            -- Auto-read files changed outside Neovim
  vim.opt.ruler = true               -- Show cursor position
  vim.opt.visualbell = true          -- Visual bell instead of audible bell
  vim.opt.wrap = true                -- Wrap lines
  vim.opt.autoindent = true          -- Auto indentation
  vim.opt.smartindent = true         -- Smart indentation
  vim.opt.showtabline = 1
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = "1"
  vim.cmd('filetype indent on')     -- Enable filetype-based indentation
  vim.opt.clipboard = "unnamedplus" -- Enable Copy/Paste to/from System Clipboard
  vim.opt.colorcolumn = "120"       -- Max 120 Characters per Line

  vim.o.linespace = 5               -- Line Height

  -- Disable netrw (default Neovim Directory Browser)
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

Module.LSPSettings = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'jit' }
        }
      }
    }
  },
  clangd = {
    cmd = { "clangd", "--clang-tidy" }
  },
  omnisharp = (function()
    local pid = tostring(vim.fn.getpid())
    local omnisharp_path = vim.fn.expand("~\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll")

    local dotnet_sdk_path = vim.fn.trim(vim.fn.system("dotnet --list-sdks")):match("^(%d+%.%d+%.%d+)")
    vim.env.DOTNET_ROOT = "C:\\Program Files\\dotnet"
    vim.env.MSBuildSDKsPath = "C:\\Program Files\\dotnet\\sdk\\" .. dotnet_sdk_path .. "\\Sdks"

    return {
      cmd = { "dotnet", omnisharp_path, "--languageserver", "--hostPID", pid },
      enable_import_completion = true,
      organize_imports_on_format = true,
      enable_roslyn_analyzers = true,
      handlers = {
        ["$/logTrace"] = function(_, result)
          print("OmniSharp trace:", result.message)
        end
      },
      settings = {
        omnisharp = {
          useModernNet = true,
          enableEditorConfigSupport = true,
          enableImportCompletion = true,
        }
      }
    }
  end)()
}

return Module
