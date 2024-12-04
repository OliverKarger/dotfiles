local _M = {}
local utils = require('utils')
local notify = utils.safe_require('notify')

_M.setup = function()
  local dap = utils.safe_require('dap')
end

_M.is_cpp = function()
  if vim.bo.filetype == 'cpp' then
    return true
  else
    return false
  end
end

_M.find_cmake_files = function()
  local current_dir = vim.fn.getcwd()
  local cmake_files = {}
  for _, file in ipairs(vim.fn.globpath(current_dir, 'CMakeLists.txt', false, true)) do
    table.insert(cmake_files, file)
  end
end

_M.find_cmake_executables = function(file)
end

_M.setup_adapter = function()
end

_M.select_cmake = function(cmake_files)
  local cmake_file = ""
  local function select_callback(file)
    cmake_file = file
  end

  vim.ui.select(cmake_files, { prompt = 'Select a CMakeLists.txt to proceed' }, select_callback);
  return cmake_file
end

_M.start = function(file)
end

return _M
