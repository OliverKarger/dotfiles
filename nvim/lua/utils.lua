local _M = {}

_M.safe_require = function(plugin) 
  local success, result = pcall(require, plugin)
  if not success then
    local notify_s, notify_r = pcall(require, "notify")
      if not notify_s then
        print("Plugin Error: " .. plugin)
      else
        notify_r(string.format('%s - Lua Error: %s', plugin, result), "error", { title = "Safe Require" })
      end
  end
  return result
end

_M.load_files = function(files)
  local notify = require("notify")
  local has_error = false

  for i = 1, #files do
    local f = _M.safe_require(files[i])
    if f and not pcall(function() f.setup() end) then
      notify("Error while Loading File: " .. files[i], "error", { title = 'Lua Loader' })
      has_error = true
    end
  end

  if not has_error then
    notify(string.format("Loaded %d Lua Files", #files), 'info', { title = 'Lua Loader' })
  end
end

_M.get_current_theme = function()
  return vim.g.colors_name
end

_M.get_attached_lsp = function()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    return 'No LSP'
  end
  -- Get the name of the first active LSP client
  return clients[1].name
end

_M.is_windows = function()
  if jit then
    return jit.os
  end
  local _, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if err then
    return true
  else
    return false
  end
end

return _M
