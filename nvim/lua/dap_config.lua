local utils = require('utils')

return {
  setup = function()
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

    dap_ui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dap_ui.close()
    end

    vim.api.nvim_create_user_command('Debugger', function()
      dap_ui.toggle()
    end, {})
  end
}
