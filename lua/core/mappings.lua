vim.g.mapleader = " "

-- NeoTree
-- vim.keymap.set("n", "<leader>e", ":Neotree left reveal<CR>")
-- vim.keymap.set("n", "<leader>o", ":Neotree float git_status<CR>")
-- Настройка сочетания клавиш для открытия и закрытия neo-tree
vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
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

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Назначение сочетания клавиш для вставки пустой строки ниже текущей строки
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert empty line below" })
