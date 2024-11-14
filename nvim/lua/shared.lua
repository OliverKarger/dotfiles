local module = {}

module.keymap_opts = { noremap = true, silent = true }
module.lsp_servers = { "clangd", "omnisharp", "lua_ls", "bashls", "docker_compose_language_service", "pyright" }

return module
