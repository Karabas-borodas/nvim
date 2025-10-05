local Remap = require("rtd.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

---------------------
-- General Keymaps
---------------------
-- clear search highlights
nnoremap("<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
nnoremap("x", '"_x')

-- increment/decrement numbers
nnoremap("<leader>=", "<C-a>") -- increment
nnoremap("<leader>-", "<C-x>") -- decrement

-- window management
-- splits
nnoremap("<leader>sv", "<C-w>v") -- split window vertically
nnoremap("<leader>sh", "<C-w>s") -- split window horizontally
nnoremap("<leader>se", "<C-w>=") -- make split windows equal width & height
nnoremap("<leader>sx", ":close<CR>") -- close current split window
nnoremap("<leader>si", "<C-w><S->><C-w><S->>") -- increase split window focus size 
nnoremap("<leader>sd", "<C-w><S-<><C-w><S-<>") -- decrease split window focus size 
-- tabs
nnoremap("<leader>tn", ":tabnew<CR>") -- open new tab
nnoremap("<leader>tx", ":tabclose<CR>") -- close current tab
nnoremap("<leader>tk", ":tabn<CR>") --  go to next tab
nnoremap("<leader>tj", ":tabp<CR>") --  go to previous tab

-- randy
vnoremap("J", ":m '>+1<CR>gv=gv") --  move current line up 
vnoremap("K", ":m '<-2<CR>gv=gv") --  move current line down 

xnoremap("p", "P") -- Allows to repeat paste 

-- go into things and center screen
nnoremap("gi", "gi<cr>zz");
nnoremap("go", "go<cr>zz");
nnoremap("gd", "gd<cr>zz");
nnoremap("<C-o>", "<C-o><cr>zz");

nnoremap("n", "nzz");
nnoremap("N", "Nzz");
nnoremap("Y", "^y$");
-- page down & up but keep cursor in middle
nnoremap("<C-d>", "<C-d><cr>zz")
nnoremap("<C-u>", "<C-u><cr>zz")

----------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
-- nnoremap("<leader>e", ":NvimTreeToggle<cr>") -- toggle file explorer
-- neotree
-- oil
-- nnoremap("<leader>e", ":lua require('oil').toggle_float()<cr>") -- toggle file explorer
-- nnoremap("<leader>e", ":Neotree toggle<cr>")
-- telescope
nnoremap(",ff", "<cmd>Telescope find_files show_untracked=true<cr>") -- find files within current working directory, respects .gitignore
nnoremap(",fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
nnoremap(",fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
nnoremap(",fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
-- Найти все использования (references) переменной/функции под курсором (LSP).
nnoremap(",fr", "<cmd>Telescope lsp_references<cr>")
nnoremap(",fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
nnoremap(",fcb", "<cmd>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<cr>") -- list available help tags
nnoremap(",fj", "<cmd>Telescope jumplist<cr>") -- search jumplist!!! 
nnoremap(",ft", "<cmd>Telescope colorscheme<cr>")
--: Найти символы (функции, классы) в текущем файле (LSP).
nnoremap(",fs", "<cmd>Telescope lsp_document_symbols<cr>")
--fc: Показать, где вызывается текущая функция (входящие вызовы, LSP).
nnoremap(",fc", "<cmd>Telescope lsp_incoming_calls<cr>")
--fo: Показать, какие функции вызываются из текущей (исходящие вызовы, LSP).
nnoremap(",fo", "<cmd>Telescope lsp_outgoing_calls<cr>" )
--fi: Найти реализации интерфейса/абстрактного класса (LSP).
nnoremap(",fi", "<cmd>Telescope lsp_implementations<cr>")
--fx: Показать список ошибок и предупреждений в текущем файле (LSP).
nnoremap(",fx", "<cmd>Telescope diagnostics bufnr=0<cr>")
-- telescope git commands (not on youtube nvim video)
nnoremap(",fgc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
nnoremap(",fgb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
nnoremap(",fgs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
nnoremap("<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary


-- Save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
-- preview files (netrw)
nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- debug
nnoremap("<F4>", ":lua require('dapui').toggle()<CR>")
nnoremap("<F7>", ":lua require('dap').toggle_breakpoint()<CR>")
nnoremap("<F5>", ":lua require('dap').continue()<CR>")

nnoremap("<F1>", ":lua require('dap').step_over()<CR>")
nnoremap("<F2>", ":lua require('dap').step_into()<CR>")
nnoremap("<F3>", ":lua require('dap').step_out()<CR>")

nnoremap("<leader>dsc", ":lua require('dap').continue()<CR>")
nnoremap("<leader>dsv", ":lua require('dap').step_over()<CR>")
nnoremap("<leader>dsi", ":lua require('dap').step_into()<CR>")
nnoremap("<leader>dso", ":lua require('dap').step_out()<CR>")

nnoremap("<leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
vnoremap("<leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

nnoremap("<leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
nnoremap("<leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

nnoremap("<leader>dro", ":lua require('dap').repl.open()<CR>")
nnoremap("<leader>drl", ":lua require('dap').repl.run_last()<CR>")

nnoremap("<leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nnoremap("<leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: '))<CR>")
nnoremap("<leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

nnoremap("<leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
nnoremap("<leader>di", ":lua require('dapui').toggle()<CR>")

