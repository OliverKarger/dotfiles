local utils = require('utils')
local notify = utils.safe_require('notify')

local function find_executable_for_csproj(csproj_file)
  local csproj_name = vim.fn.fnamemodify(csproj_file, ":t:r")

  local current_dir = vim.fn.getcwd()
  local bin_dir = current_dir .. "/bin"
  if vim.fn.isdirectory(bin_dir) == 0 then
    notify("No 'bin' Directory found", "Warn", { title = ".NET Debugger" })
    return nil
  end

  local pattern = bin_dir .. "/**/" .. csproj_name
  local files = vim.fn.glob(pattern, true, true)

  for _, file in ipairs(files) do
    if vim.fn.executable(file) == 1 then
      return file  -- Return the path of the executable
    end
  end

  print("Executable not found in any subdirectories of 'bin'.")
  return nil
end

local function get_process_id(executable)
  local executable_name = vim.fn.fnamemodify(executable, ":t:r")
  local cmd = string.format("pgrep -f '%s'", executable_name)
  local process_id = vim.fn.system(cmd)
  process_id = process_id:gsub("\n", ""):gsub("^%s*(.-)%s*$", "%1")

  if process_id ~= "" then
    return tonumber(process_id)
  else
    return nil
  end
end

return {
  setup = function()
    vim.api.nvim_create_user_command('NetDebugSetup', function()
      utils.safe_require('dotnet_debug').NetDebugger()
    end, {})
  end,

  NetDebugSetup = function()
    local dap = utils.safe_require('dap')
    local dap_ui = utils.safe_require('dapui')

    if utils.is_windows() then
      notify('Windows is currently not supported.', 'error', { title='.NET Debugger' })
    else
      dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/bin/netcoredbg',
        args = { '--interpreter=vscode' }
      }
    end

    local current_dir = vim.fn.getcwd()
    local csproj_files = {}
    for _, file in ipairs(vim.fn.globpath(current_dir, '*.csproj', false, true)) do
      table.insert(csproj_files, file)
    end

    if csproj_files == {} then
      return false
    end

    local function select_prompt_callback(action)
      if action == nil then
        notify("Not a valid File!", "warn", { title = ".NET Debugger" })
        return false
      end
      local executable = find_executable_for_csproj(action)
      notify(string.format("Debug: %s", executable), "info", { title = ".NET Debugger" })
      if not executable then
        return false
      end

      dap.configurations.cs = {
        {
          name = string.format('Launch %s', executable),
          type = 'coreclr',
          request = 'launch',
          program = executable .. ".dll",
          cwd = vim.fn.getcwd(),
          args = {},
          -- processId = utils.safe_require('dap.utils').pick_process,
          stopAtEntry = false
        },
        {
          name = string.format('Attach to %s', executable),
          type = 'coreclr',
          request = 'attach',
          program = executable .. ".dll",
          cwd = vim.fn.getcwd(),
          args = {},
          processId = function()
            local process_id = get_process_id(executable)
            if not process_id then
              notify(string.format("Could not find Process Id for %s", executable), "warn", { title = ".NET Debugger" })
              utils.safe_require('dap.utils').pick_process()
            end
            return process_id
          end,
          stopAtEntry = false
        }
      }

      dap_ui.open()
      return true
    end

    vim.ui.select(
      csproj_files,
      {
        prompt = "Select csproj File for Debugging",
      },
      select_prompt_callback)

  end
}
