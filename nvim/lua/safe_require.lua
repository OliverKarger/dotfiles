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
  end
}
