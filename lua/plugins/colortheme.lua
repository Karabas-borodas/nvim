 -- return {
 --   {
 --     -- Название плагина на GitHub
 --     "sam4llis/nvim-tundra",

 --     -- lazy = false: Загружать плагин сразу при запуске.
 --     -- Это обязательно для цветовых схем, чтобы избежать "мигания"
 --     -- стандартной темы при старте.
 --     lazy = false,

 --     -- priority = 1000: Установить очень высокий приоритет загрузки.
 --     -- Это гарантирует, что цветовая схема загрузится раньше,
 --     -- чем другие плагины (например, lualine), которые от нее зависят.
 --     priority = 1000,

 --     -- config: Эта функция выполнится после того, как плагин будет загружен.
 --     -- Здесь мы настраиваем и применяем тему.
 --     config = function()
 --       -- Устанавливаем глобальные переменные и опции ДО вызова setup
 --       vim.g.tundra_biome = 'arctic' -- 'arctic' or 'jungle'
 --       vim.opt.background = 'dark'

 --       -- Вызываем функцию setup плагина со всеми вашими настройками
 --       require('nvim-tundra').setup({
 --         transparent_background = false,
 --         dim_inactive_windows = {
 --           enabled = false,
 --           color = nil,
 --         },
 --         sidebars = {
 --           enabled = true,
 --           color = nil,
 --         },
 --         editor = {
 --           search = {},
 --           substitute = {},
 --         },
 --         syntax = {
 --           booleans = { bold = true, italic = true },
 --           comments = { bold = true, italic = true },
 --           conditionals = {},
 --           constants = { bold = true },
 --           fields = {},
 --           functions = {},
 --           keywords = {},
 --           loops = {},
 --           numbers = { bold = true },
 --           operators = { bold = true },
 --           punctuation = {},
 --           strings = {},
 --           types = { italic = true },
 --         },
 --         diagnostics = {
 --           errors = {},
 --           warnings = {},
 --           information = {},
 --           hints = {},
 --         },
 --         plugins = {
 --           lsp = true,
 --           semantic_tokens = true,
 --           treesitter = true,
 --           telescope = true,
 --           nvimtree = true,
 --           cmp = true,
 --           context = true,
 --           dbui = true,
 --           gitsigns = true,
 --           neogit = true,
 --           textfsm = true,
 --         },
 --         overwrite = {
 --           colors = {},
 --           highlights = {},
 --         },
 --       })

 --       -- Применяем цветовую схему. Это должен быть последний шаг.
 --       vim.cmd('colorscheme tundra')
 --     end,
 --   },
 -- }
 --not bad green theme
 -- return {
 --   {
 --    'navarasu/onedark.nvim',
 --    config = function()
 --      require('onedark').load()
 --    end
 --   },
 -- }
return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('bamboo').setup {
      -- Main options --
      -- NOTE: to use the light theme, set `vim.o.background = 'light'`
      style = 'multiplex', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
      toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
      transparent = true, -- Show/hide background
      dim_inactive = false, -- Dim inactive windows/buffers
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- Change code style ---
      -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
      -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
      code_style = {
        comments = { italic = true, bold = false },
        conditionals = { italic = false },
        keywords = {},
        functions = {},
        namespaces = { italic = true },
        parameters = { italic = false },
        strings = {},
        variables = {},
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {}, -- Override default colors
      highlights = {
        ['LspReferenceRead'] = { fg = '#000'},
        ['@lsp.type.namespace.cs'] = { fg = '#ffffff'},
      }, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    }
    require('bamboo').load()
    vim.cmd('colorscheme bamboo')
  end,
}
