local utils = require('utils')
local settings = require('settings')

local Module = {}

Module.Setup = function()
  local dap = utils.SafeRequire('dap')
  local dap_ui = utils.SafeRequire('dapui')

  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'codelldb',
      args = { "--port", "${port}" }
    }
  }

  dap.adapters.coreclr = {
    type = 'executable',
    command = 'C:\\Program Files\\netcoredbg\\netcoredbg.exe',
    args = { '--interpreter=vscode' }
  }

  dap.configurations.cs = {{
    type = 'coreclr',
    name = 'Launch .NET Debug',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end
  }}

  dap_ui.setup()

  local debug_shortcuts = {
    { desc = 'Open Debugger', cmd = ":lua require('dapui').open()" },
    { desc = 'Close Debugger', cmd = ":lua require('dapui').close()" },
    { desc = 'Set Breakpoint', cmd = ":lua require('dap').toggle_breakpoint()" },
    { desc = 'Run Last Configuration', cmd = ":lua require('dap').run_last()" },
  }

  vim.api.nvim_create_user_command('Debugger', function()
    utils.ShortcutMenu(
      'Debugger Shortcuts', 
      debug_shortcuts, 
      function(item)
        vim.cmd(item.cmd)
      end
    )
  end, {})

  vim.api.nvim_set_keymap('n', '<leader>db', ":Debugger<CR>", settings.KeymapOptions)

  dap.listeners.before.attach.dapui_config = function()
    dap_ui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dap_ui.open()
  end

end

return Module
