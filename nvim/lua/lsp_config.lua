local utils = require('utils')
local settings = require('settings')

local _M = {}

_M.setup = function()
  local luasnip = utils.safe_require('luasnip')
  local cmp = utils.safe_require('cmp')
  local mason_lspconfig = utils.safe_require('mason-lspconfig')
  local notify = utils.safe_require('notify')
  local diag = utils.safe_require('tiny-inline-diagnostic')

  mason_lspconfig.setup({
    automatic_installation = true,
    ensurere_installed = settings.lsp_servers
  })

  local function on_lsp_attach(lspname)
    notify(string.format('Language Server %s attached', lspname), "info", { title = 'LSP' })
  end

  -- LSPConfig Setup
  for _, lsp in ipairs(settings.lsp_servers) do
    local lsp_options = {}
    if settings.lsp_settings[lsp] then
      lsp_options = settings.lsp_settings[lsp]
    end

    local setup_options = utils.merge_tables({ on_attach = function() on_lsp_attach(lsp) end }, lsp_options)
    utils.safe_require('lspconfig')[lsp].setup(setup_options)
  end

  -- Neovim Diagnostics Configuration
  diag.setup({
      signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        up_arrow = "    ",
        vertical = " │",
        vertical_end = " └",
      },
      options = {
        show_soruce = true,
        multilines = true,
      }
  })
  vim.diagnostic.config({ virtual_text = false })

  -- Snippets and Completion Setup
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Scroll up
      ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Scroll down
      ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' }
    },
    completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged }
    },
    formatting = {
      format = function(entry, vim_item)
        local icons = {
          Text = " ",
          Method = " ",
          Function = " ",
          Constructor = " ",
          Field = " ",
          Variable = " ",
          Class = " ",
          Interface = " ",
          Module = " ",
          Property = " ",
          Unit = " ",
          Value = " ",
          Enum = " ",
          Keyword = " ",
          Snippet = " ",
          Color = " ",
          File = " ",
          Reference = " ",
          Folder = " ",
          EnumMember = " ",
          Constant = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        }

        vim_item.kind = (icons[vim_item.kind] or "") .. vim_item.kind

        local source_names = {
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lua = "[Lua]",
          calc = "[Calc]",
        }

        vim_item.menu = source_names[entry.source.name] or "[Unknown]"

        return vim_item
      end,
  }}
end

return _M
