-------------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local home = os.getenv("HOME")
local g = vim.g
local opt = vim.opt
local opt_global = vim.opt_global


-- disable language provider support (use lua and vimscript plugins
-- only)отключаем ненужные плагины что бы ускорить загрузку
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0

-- disable unused stuff отключаем остальные плагины
g.loaded = 1
g.loaded_netrw = 1 --встроенный файловый менеджер заменен на neotree
g.loaded_netrwPlugin = 1 --встроенный файловый менеджер заменен на neotree
g.loaded_2html_plugin = 1 --конвертер в html
g.loaded_tutor_mode_plugin = 1 -- встроенный учебник vimtutor
g.loaded_matchit = 1  -- use vim-matchup
g.loaded_matchparen = 1  -- use vim-matchup

-- basic settings
vim.cmd('filetype plugin on')-- Включает плагины для конкретных типов файлов.
g.completeopt = { "menuone", "noinsert", "noselect" } -- Настройки меню автодополнения (важно для nvim-cmp).
opt_global.shortmess:remove("F")-- Убирает полное имя файла из сообщений, делая их короче.
opt.encoding = "utf-8" -- Стандартная кодировка для файлов.
opt.backspace = "indent,eol,start" -- backspace works on every char in insert mode
-- Позволяет Backspace удалять всё: отступы, переносы строк и символы перед началом вставки.
opt.history = 1000-- Сколько команд хранить в истории.
opt.startofline = true-- Некоторые команды перемещают курсор в начало строки, а не на первый символ.
opt.clipboard = 'unnamedplus' -- **Очень важно!** Синхронизирует буфер обмена Neovim с системным буфером обмена (Ctrl+C/Ctrl+V).
opt.textwidth = 73-- Устанавливает максимальную ширину строки в 73 символа.

-- wait time
-- opt.timeout = false
opt.timeoutlen = 300-- Сколько миллисекунд (0.3с) ждать следующую клавишу в комбинации (например, в `jk` для выхода из insert mode).
opt.ttimeout = true
opt.ttimeoutlen = 100-- Сколько миллисекунд (0.3с) ждать следующую клавишу в комбинации (например, в `jk` для выхода из insert mode).

-- display
-- Кратковременно подсвечивает парную скобку.
opt.showmatch  = true -- show matching brackets
-- Оставляет минимум 3 строки сверху и снизу от курсора при прокрутке.
opt.scrolloff = 5 -- always show 3 rows from edge of the screen
-- Отключает подсветку синтаксиса для очень длинных строк (более 300 символов) для улучшения производительности.
opt.synmaxcol = 300 -- stop syntax highlight after x lines for performance
-- Всегда показывать строку состояния (statusline).
opt.laststatus = 2 -- always show status line
opt.list = false -- do not display white characters
 -- Отключить сворачивание кода (фолдинг).
opt.foldenable = false
opt.foldlevel = 4 -- limit folding to 4 levels
opt.foldmethod = 'syntax' -- use language syntax to generate folds
 -- Не переносить длинные строки на следующую.
opt.wrap = false --do not wrap lines even if very long
opt.eol = false -- show if there's no eol char
opt.showbreak= '↪' -- character to show when line is broken
-- Включает поддержку 24-битных цветов в терминале. **Обязательно** для современных цветовых схем.
opt.termguicolors = true

-- sidebar
 -- Показывать номера строк.
opt.number = true -- line number on the left
-- Резервирует 3 колонки для номеров строк.
opt.numberwidth = 3 -- always reserve 3 spaces for line number
 -- Всегда показывать колонку для знаков (ошибки LSP, метки git). Это предотвращает "прыгание" текста.
opt.signcolumn = 'yes' -- keep 1 column for coc.vim  check
opt.modelines = 0
-- Показывать нажимаемые команды в правом нижнем углу.
opt.showcmd = true -- display command in bottom bar

-- search
-- Начинать поиск по мере ввода символов, не дожидаясь Enter.
opt.incsearch = true -- starts searching as soon as typing, without enter needed
-- Игнорировать регистр при поиске.
opt.ignorecase = true -- ignore letter case when searching
 -- Но если в поисковом запросе есть хотя бы одна заглавная буква, поиск становится чувствительным к регистру.
opt.smartcase = true -- case insentive unless capitals used in search

-- backup and undo
-- Создавать резервную копию файла перед сохранением.
opt.backup = true
-- **Отключить** создание `.swp` файлов (файлов восстановления после сбоя).
opt.swapfile = false
-- Указывает, куда складывать файлы бэкапов.
opt.backupdir = home .. '/.config/nvim/.backup/'
-- Указывает, куда складывать swap-файлы (если бы они были включены).
opt.directory = home .. '/.config/nvim/.swp/'
-- Указывает, куда складывать файлы истории изменений.
opt.undodir = home .. '/.config/nvim/.undo/'
 -- **Ключевая фича!** Сохраняет историю изменений между сессиями. Можно закрыть файл, открыть снова и продолжать отменять (undo) изменения.
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000

-- text format
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
-- Включает автоотступы в стиле C.
opt.cindent = true
-- Копирует отступ с предыдущей строки при создании новой.
opt.autoindent = true
--"Умные" отступы для разных языков.
opt.smartindent = true
-- **Важно!** Преобразует нажатие Tab в пробелы.
opt.expandtab = true -- expand tab to spaces
-- Tab в начале строки работает по `shiftwidth`, а в середине — как
-- обычный таб.
opt.smarttab = true
