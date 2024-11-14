local safe_require = require('safe_require').safe_require

return {
  setup = function()
    local lsp_servers = safe_require('shared').lsp_servers
    local luasnip = safe_require('luasnip')
    local cmp = safe_require('cmp')
    local mason_lspconfig = safe_require('mason-lspconfig')

    mason_lspconfig.setup({
      automatic_installation = true,
      ensurere_installed = lsp_servers
    })

    -- LSPConfig Setup
    for _, lsp in ipairs(lsp_servers) do
      safe_require('lspconfig')[lsp].setup {}
    end

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
      }
    }
  end
}