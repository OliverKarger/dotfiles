local module = {}

-- "safe" require wrapper
function module.safe_require(plugin)
  local success, result = pcall(require, plugin)
  if not success then
    print("Plugin Error: " .. plugin)
	print(result)
  end
  return result
end

return module
