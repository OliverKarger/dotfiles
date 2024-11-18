local utils = require('utils')

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

  dap_ui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dap_ui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dap_ui.open()
  end

  vim.api.nvim_create_user_command('Debugger', function()
    local is_dotnet = utils.safe_require('dotnet_debug').NetDebug()

    if not is_dotnet then
      -- dap_ui.open()
    end
  end, {})
end

return _M
