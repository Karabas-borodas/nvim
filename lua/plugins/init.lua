return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,},
  --% прыжок к следйющей скобке, слову закрывающей скобке
  --g%	Перейти к парному элементу в обратном направлении.
  --[%	Перейти к началу блока.
  --]%	Перейти к концу блока.
  --z%	Перейти к следующему элементу в середине блока.
   {
   "ajdymass/vim-matchup",
  event = "BufReadPost",
  config = function()
    vim.g.matchup_matchparen_enabled = 1          -- Отключает встроенный matchparen
    vim.g.matchup_matchparen_deferred = 1        -- Улучшает производительность
    vim.g.matchup_matchparen_offscreen = {      -- Показывает подсказки за пределами экрана
      method = "popup",
    }
    vim.g.matchup_text_obj_enabled = 1          -- Включает текстовые объекты (di%, ci% etc.)
    vim.g.matchup_surround_enabled = 1          -- Интеграция с vim-surround
  end,  },
  -- ищет посторящищиеся слова <leader>* и переходитк с ледующему через
  -- shift n
  'bronson/vim-visual-star-search',
  --установка меток и переход по ним
  --
-- mx Установить метку x
-- m, Установить следующую доступную буквенную (строчную) метку
-- m: Переключить следующую доступную метку в текущей строке
-- dmx Удалить метку x
-- dm- Удалить все метки в текущей строке
-- dm<пробел> Удалить все метки в текущем буфере
-- m] Перейти к следующей метке
-- m[ Перейти к предыдущей метке
-- m: Предварительный просмотр метки. Будет предложено указать метку для
-- предварительного просмотра; нажмите <cr>, чтобы просмотреть следующую метку.

-- m[0-9] Добавить закладку из группы закладок [0-9].
-- dm[0-9] Удалить все закладки из группы закладок [0-9].
-- m} Перейти к следующей закладке того же типа, что и закладка под
-- курсором. Работает во всех буферах.
-- m{ Перейти к предыдущей закладке того же типа, что и закладка под
-- курсором. Работает во всех буферах.
-- dm= Удалить закладку под курсором.о
  {
    'chentoast/marks.nvim',
    event = "VeryLazy",
    opts = {},
  },
  -- install mason
  { import = 'plugins.mason' },

  -- 'godlygeek/tabular',
  -- только дял ios markdown захват
  -- 'itspriddle/vim-marked',
  -- создание тегови  перемещение по ним
  -- 'ludovicchabant/vim-gutentags',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  --добавляет цветные иконки в меню neotree меню файлов
  'nvim-tree/nvim-web-devicons',
  --dashboard первое окно
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
      }
    end,
  },
  --коментарии gcc
  'tpope/vim-commentary',
  --позволяет пользовать git в командной строке :Git ....
  'tpope/vim-fugitive',
--при нажатии . повторяте последнюю команду
  'tpope/vim-repeat',
  --позволяет пользовать git в командной строке :Git ....
  'tpope/vim-rhubarb',
  --оборачивает слово в кавычки
  --ysiw<обёртка> Обернуть слово под курсором
  --yss<обёртка> Обернуть целую строку
  --cs<старая><новая> Заменить обёртку
  --ds<обёртка> Удалить обёртку
  --S<обёртка>Обернуть визуально выделенный текст
  'tpope/vim-surround',
-- прыгает по файлам
-- [b на предыдущий файл ]b на следующий
'tpope/vim-unimpaired',
-- если в коде есть строка вызова браузера то :OpenBrowser открое ее в
-- браузере
--FIX: пока не работает
  'tyru/open-browser.vim',
  -- запускает тесты для текущего файла\строки\
  -- :TestFile Запустить все тесты в текущем файле
  -- :TestNearest Запустить ближайший тест (функция, класс)
  -- :TestLast Повторить последний запущенный тест
  -- :TestVisit Открыть последний файл с результатами тестов
  -- :TestSuite Запустить все тесты в проекте
  'vim-test/vim-test',
  {
    -- открывает окно диагностики
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup({
        mode = "document_diagnostics"
      })
    end
  },
  {
    --подсказки в нижней строке при введение :
    'gelguy/wilder.nvim',
    config = function() require('config/wilder') end,
  },
  --lsp plugins
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'onsails/lspkind.nvim',
    },
    config = function() require('config/nvim-cmp') end,
  },
  -- цветовая тема
    -- включатся в пагине colortheme
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = { theme = 'onedark' },
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function() require('config/telescope') end,
  },
  {
    -- плагие позволяет нормально редактировать markdown файлы
    -- :Pencil	Включить режим "карандаша". По умолчанию включает мягкий перенос строк (SoftPencil).
    -- :SoftPencil	Включить режим с мягким (визуальным) переносом.
    -- Текст в файле остается одной длинной строкой, но на экране выглядит как параграф.
    -- :HardPencil	Включить режим с жестким переносом. Плагин будет автоматически вставлять разрыв строки, когда вы достигаете textwidth.
    'preservim/vim-pencil',
    dependencies = {
      'preservim/vim-litecorrect',
      'kana/vim-textobj-user',
      'preservim/vim-textobj-quote',
      'preservim/vim-textobj-sentence',
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      augroup('pencil', { clear = true })
      autocmd('FileType', {
        group = 'pencil',
        pattern = { "markdown" ,"text" },
        callback = function()
          vim.cmd("call pencil#init({'wrap': 'hard'})")
          vim.cmd("call litecorrect#init()")
          vim.cmd("call textobj#quote#init()")
          vim.cmd("call textobj#sentence#init()")
        end
      })
    end
  },

}
