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
 return {
   {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end
   },
 }

