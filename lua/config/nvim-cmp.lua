local cmp = require 'cmp'
local lspkind = require('lspkind')
cmp.setup {
  sources = {
    -- откуда lsp берет подсказки синтаксиса
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    { name = "copilot" },
  },
  -- вставка сниппета из базы
  snippet = {
    expand = function(args)
     -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),-- Ctr+d прокрутка вниз сниппетов
    ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Ctr_f прокрутка вверх
    ['<C-Space>'] = cmp.mapping.complete(),--  Принудительно вызывает меню автодополнения, если оно не появилось само.
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },--  (клавиша Enter): Подтверждает выбор.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()--Если меню открыто: Tab выбирает следующий пункт в меню.
      else
        fallback()--Если меню закрыто: Tab работает как обычно (вставляет символ табуляции).
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()--Если меню открыто: Shift+Tab выбирает предыдущий пункт.
      else
        fallback()--Если меню закрыто: Shift+Tab работает как обычно.:
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  }
}
