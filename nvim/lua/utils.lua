local Module = {}

Module.SafeRequire = function(plugin)
  local success, result = pcall(require, plugin)
  if not success then
    local notify_s, notify_r = pcall(require, "notify")
      if not notify_s then
        print("Lua Error: " .. plugin)
      else
        notify_r(string.format('%s - Lua Error: %s', plugin, result), "error", { title = "Safe Require" })
      end
  end
  return result
end

Module.LoadFiles = function(files)
  local notify = require("notify")
  local has_error = false

  for i = 1, #files do
    local f = Module.SafeRequire(files[i])
    if f and not pcall(function() f.Setup() end) then
      notify("Error while Loading File: " .. files[i], "error", { title = 'Lua Error: ' .. files[i] })
      has_error = true
    end
  end

  if not has_error then
    notify(string.format("Loaded %d Lua Files", #files), 'info', { title = 'Lua Loader' })
  end
end

Module.GetCurrentTheme = function()
  return vim.g.colors_name
end

Module.GetAttachedLSP = function()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    return 'No LSP'
  end
  -- Get the name of the first active LSP client
  return clients[1].name
end

Module.GetOSPlatform = function()
  if jit then
    return jit.os
  end
  local _, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if err then
    return 'Windows'
  else
    return 'Other'
  end
end

Module.MergeTables = function(table1, table2)

  local merged = {}

  -- Copy elements from the first table
  for k, v in pairs(table1) do
    merged[k] = v
  end

  -- Copy elements from the second table
  for k, v in pairs(table2) do
    merged[k] = v
  end

  return merged

end

Module.ShortcutMenu = function(prompt, list, callback)
  local telescope_actions = Module.SafeRequire('telescope.actions')
  local telescope_pickers = Module.SafeRequire('telescope.pickers')
  local telescope_finders = Module.SafeRequire('telescope.finders')
  local telescope_conf = Module.SafeRequire('telescope.config').values
  local telescope_state = Module.SafeRequire('telescope.actions.state')

  telescope_pickers.new({}, {
    prompt_title = prompt,
    finder = telescope_finders.new_table {
      results = list,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.desc,
          ordinal = entry.desc,
        }
      end,
    },
    sorter = telescope_conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      telescope_actions.select_default:replace(function()
        telescope_actions.close(prompt_bufnr)
        local selection = telescope_state.get_selected_entry()
        callback(selection.value)
      end)
      return true
    end,
  }):find()
end

return Module
