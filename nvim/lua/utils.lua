return {
  safe_require = function(plugin) 
    local success, result = pcall(require, plugin)
    if not success then
      local notify_s, notify_r = pcall(require, "notify")
        if not notify_s then
          print("Plugin Error: " .. plugin)
        else
          notify_r("Plugin Error: " .. plugin, "error", { title = "Safe Require" })
        end
    end
    return result
  end,

  load_files = function(files)
    local notify = require("notify")
    local has_error = false

    for i = 1, #files do
      local f = require(files[i])
      if f and not pcall(function() f.setup() end) then
        notify("Error while Loading File: " .. files[i], "error", { title = 'Lua Loader' })
        has_error = true
      end
    end

    if not has_error then
      notify(string.format("Loaded %d Lua Files", #files), 'info', { title = 'Lua Loader' })
    end
  end,

  get_current_theme = function()
    return vim.g.colors_name
  end,

  get_attached_lsp = function()
    local clients = vim.lsp.get_active_clients()
    if #clients == 0 then
      return 'No LSP'
    end
    -- Get the name of the first active LSP client
    return clients[1].name
  end
}
