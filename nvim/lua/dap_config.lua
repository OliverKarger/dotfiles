local utils = require('utils')
local settings = require('settings')

local _M = {}

_M.setup = function()
  local dap = utils.safe_require('dap')
  local dap_ui = utils.safe_require('dapui')

  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'codelldb',
      args = { "--port", "${port}" }
    }
  }

  dap.adapters.gdb = {
      id = 'gdb',
      type = 'executable',
      command = 'gdb',
      args = { '--quiet', '--interpreter=dap' },
  }

  dap.configurations.cpp = {
      {
          name = 'Run executable (GDB)',
          type = 'gdb',
          request = 'launch',
          -- This requires special handling of 'run_last', see
          -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
          program = function()
              local path = vim.fn.input({
                  prompt = 'Path to executable: ',
                  default = vim.fn.getcwd() .. '/',
                  completion = 'file',
              })

              return (path and path ~= '') and path or dap.ABORT
          end,
      },
      {
          name = 'Run executable with arguments (GDB)',
          type = 'gdb',
          request = 'launch',
          -- This requires special handling of 'run_last', see
          -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
          program = function()
              local path = vim.fn.input({
                  prompt = 'Path to executable: ',
                  default = vim.fn.getcwd() .. '/',
                  completion = 'file',
              })

              return (path and path ~= '') and path or dap.ABORT
          end,
          args = function()
              local args_str = vim.fn.input({
                  prompt = 'Arguments: ',
              })
              return vim.split(args_str, ' +')
          end,
      },
      {
          name = 'Attach to process (GDB)',
          type = 'gdb',
          request = 'attach',
          processId = require('dap.utils').pick_process,
      },
  }

  dap_ui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dap_ui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dap_ui.open()
  end

  vim.api.nvim_create_user_command('OpenDebugger', function()
    dap_ui.open()
  end, {})
  vim.api.nvim_create_user_command('CloseDebugger', function()
    dap_ui.close();
  end, {})
  vim.api.nvim_set_keymap('n', '<leader>db', ":lua require('dap').toggle_breakpoint()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>do', ":lua require('dapui').open()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>de', ":lua require('dapui').close()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>drl', ":lua require('dap').run_last()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>dre', ":lua require('dap').restart()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>dsi', ":lua require('dap').step_into()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>dso', ":lua require('dap').step_over()<CR>", settings.keymap_opts)
  vim.api.nvim_set_keymap('n', '<leader>dc', ":lua require('dap').continue()<CR>", settings.keymap_opts)
end

return _M
