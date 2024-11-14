return {
  safe_require = function(plugin)
    local success, result = pcall(require, plugin)
    if not success then
      print("Plugin Error: " .. plugin)
      print(result)
    end
    return result
  end
}
