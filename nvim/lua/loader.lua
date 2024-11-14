local safe_require = require('safe_require').safe_require

return {
  load_files = function(files)
    local notify = safe_require("notify")
    local has_error = false

    for i = 1, #files do
      local f = safe_require(files[i])
      if f and not pcall(function() f.setup() end) then
        notify("Error while Loading File: " .. files[i], "error")
        has_error = true
      end
    end

    if not has_error then
      notify(string.format("Loaded %d Lua Files", #files))
    end
  end
}
