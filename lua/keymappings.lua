-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local remap = require("me.util").remap
local bufopts = { silent = true, noremap = true }
-- open neotee
vim.keymap.set("n", "<leader>e", ":Neotree left reveal<CR>")
-- Переход на правое окно
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true })
-- Переход на левое окно
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { noremap = true, silent = true })
--open neotree
vim.api.nvim_set_keymap("n", "\\", ":Neotree close<CR>", { noremap = true, silent = true })
-- disable search highlighting by pressing enter
remap("n", "<cr>", "<cmd>:nohlsearch<cr><cr>")
-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- tab management
remap("n", "<C-Insert>", "<cmd>:tabnew<cr>", bufopts, "New tab")
remap("n", "<C-Delete>", "<cmd>:tabclose<cr>", bufopts, "Close tab")
remap("i", "<C-Insert>", "<cmd>:tabnew<cr>", bufopts, "New tab")
remap("i", "<C-Delete>", "<cmd>:tabclose<cr>", bufopts, "Close tab")

--Перейти на самую первую вкладку.
remap("n", "th", "<cmd>:tabfirst<cr>", bufopts, "First tab")
--tk: Перейти на следующую вкладку (вправо).
remap("n", "tk", "<cmd>:tabnext<cr>", bufopts, "Next tab")
--tj: Перейти на предыдущую вкладку (влево).
remap("n", "tj", "<cmd>:tabprev<cr>", bufopts, "Previous tab")
--tl: Перейти на самую последнюю вкладку.
remap("n", "tl", "<cmd>:tablast<cr>", bufopts, "Last tab")
--tt: Создать новую пустую вкладку.
remap("n", "tt", "<cmd>:tabedit<cr>", bufopts, "New tab")
--tt: Создать новую пустую вкладку.
remap("n", "td", "<cmd>:tabclose<cr>", bufopts, "Close tab")
--tn: Переместить текущую вкладку влево.
remap("n", "tn", "<cmd>:tabmove -1<cr>", bufopts, "Move tab next")
--tm: Переместить текущую вкладку вправо.
remap("n", "tm", "<cmd>:tabmove +1<cr>", bufopts, "Move tab previous")

-- window management
--<C-S-Right> (Ctrl+Shift+Right): Сделать текущее вертикальное окно уже.
remap("n", "<C-S-Right>", "<cmd>:vertical resize -1<cr>", bufopts, "Minimize window")
--<C-S-Left> (Ctrl+Shift+Left): Сделать текущее вертикальное окно шире.
remap("n", "<C-S-Left>", "<cmd>:vertical resize +1<cr>", bufopts, "Maximize window")

-- formatting
 --(в нормальном режиме): Отформатировать текущий параграф.
remap("n", "Q", "gqap", bufopts, "Format paragraph")
--Q (в визуальном режиме): Отформатировать выделенный текст.
remap("x", "Q", "gq", bufopts, "Format paragraph")
--<leader>Q: Объединить текущий параграф со следующим и отформатировать их.
remap("n", "<leader>Q", "vapJgqap", bufopts, "Merge paragraphs")

--
-- Plugins
--

-- vim-marked
--добавляет маркер для маркдаун файла
remap("n", "<leader>mo", "<cmd>MarkedOpen<cr>", bufopts, "Open marked")

-- vim-pencil
--<leader>qc: Заменить прямые кавычки (") на фигурные (“ ”).
remap("n", "<leader>qc", "<Plug>ReplaceWithCurly", bufopts, "Curl quotes")
--<leader>qs: Заменить фигурные кавычки на прямые.
remap("n", "<leader>qs", "<Plug>ReplaceWithStraight", bufopts, "Straighten quotes")

-- telescope
-- Найти файлы в проекте.
remap("n", ",ff", "<cmd>Telescope find_files<cr>", bufopts, "Find file")
--Найти текст во всех файлах проекта (grep).
remap("n", ",fg", "<cmd>Telescope live_grep<cr>", bufopts, "Grep")
-- Найти среди открытых буферов (файлов).
remap("n", ",fb", "<cmd>Telescope buffers<cr>", bufopts, "Find buffer")
-- Найти по меткам (marks).
remap("n", ",fm", "<cmd>Telescope marks<cr>", bufopts, "Find mark")
-- Найти все использования (references) переменной/функции под курсором (LSP).
remap("n", ",fr", "<cmd>Telescope lsp_references<cr>", bufopts, "Find references (LSP)")
--: Найти символы (функции, классы) в текущем файле (LSP).
remap("n", ",fs", "<cmd>Telescope lsp_document_symbols<cr>", bufopts, "Find symbols (LSP)")
--fc: Показать, где вызывается текущая функция (входящие вызовы, LSP).
remap("n", ",fc", "<cmd>Telescope lsp_incoming_calls<cr>", bufopts, "Find incoming calls (LSP)")
--fo: Показать, какие функции вызываются из текущей (исходящие вызовы, LSP).
remap("n", ",fo", "<cmd>Telescope lsp_outgoing_calls<cr>", bufopts, "Find outgoing calls (LSP)")
--fi: Найти реализации интерфейса/абстрактного класса (LSP).
remap("n", ",fi", "<cmd>Telescope lsp_implementations<cr>", bufopts, "Find implementations (LSP)")
--fx: Показать список ошибок и предупреждений в текущем файле (LSP).
remap("n", ",fx", "<cmd>Telescope diagnostics bufnr=0<cr>", bufopts, "Find errors (LSP)")

-- trouble
--<leader>xx: Открыть/закрыть удобное окно со списком ошибок и предупреждений (LSP).
remap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", bufopts, "Display errors")
-- remap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", bufopts, "Display workspace errors")
-- remap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", bufopts, "Display document errors")

-- symbols-outline
--<leader>o: Показать "оглавление" файла — список всех функций, классов, переменных.
remap("n", "<leader>o", "<cmd>SymbolsOutline<cr>", bufopts, "Show symbols")

-- oil
--<leader>n: Открыть Oil, файловый менеджер, который позволяет редактировать папки как обычный текстовый файл.
remap("n", "<leader>n", "<cmd>Oil<cr>", bufopts, "Oil")

-- vim-test
--<leader>vt: Запустить тест, ближайший к курсору
remap("n", "<leader>vt", "<cmd>TestNearest<cr>", bufopts, "Test nearest")
--<leader>vf: Запустить все тесты в текущем файле.
remap("n", "<leader>vf", "<cmd>TestFile<cr>", bufopts, "Test file")
--<leader>vs: Запустить весь набор тестов (test suite).
remap("n", "<leader>vs", "<cmd>TestSuite<cr>", bufopts, "Test suite")
--<leader>vl: Запустить последний запущенный тест.
remap("n", "<leader>vl", "<cmd>TestLast<cr>", bufopts, "Test last")
--<leader>vg: Перейти к файлу с тестом для текущего кода.
remap("n", "<leader>vg", "<cmd>TestVisit<cr>", bufopts, "Go to test")
