return {
  setup = function()
    vim.keymap.set('n', '<C-f>s', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = "Toggle Spectre"
    })
    vim.keymap.set('n', '<C-f>w', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = "Search current Word"
    })
  end
}
