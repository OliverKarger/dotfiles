return {
  safe_require = function(plugin)
    local notify = require('notify')
    local success, result = pcall(require, plugin)
    if not success then
      notify("Plugin Error: " .. plugin, "error")
      print("Plugin Error: " .. plugin)
      print(result)
    end
    return result
  end
}
