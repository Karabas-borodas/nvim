vim.g.mapleader = " "

-- NeoTree
vim.keymap.set("n", "<leader>e", ":Neotree left reveal<CR>")
-- vim.keymap.set("n", "<leader>o", ":Neotree float git_status<CR>")
-- Настройка сочетания клавиш для открытия и закрытия neo-tree
vim.api.nvim_set_keymap("n", "\\", ":Neotree close<CR>", { noremap = true, silent = true })
-- Key mappings for NERDTree tree plagin
--vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true, silent = true })

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Telescope bindings
vim.keymap.set("n", ",ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.keymap.set("n", ",fg", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Назначение сочетания клавиш для вставки пустой строки ниже текущей строки
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert empty line below" })
