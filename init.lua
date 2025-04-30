--Basic
require("core.plugins")
require("core.mappings")
require("core.colors")

--Plugins
require("plugins.neotree")
require("plugins.treesitter")
require("plugins.mason")
require("plugins.some_plagins")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.cmp")

--require('plugins.nullls')
require("plugins.debug")
require("plugins.tmux_navigator")
require("plugins.terminal")
require("plugins.buffline")
require("plugins.planery")
--require('plugins.lsp')
vim.cmd([[
  autocmd VimEnter * if filereadable("mix.exs") | silent !mix phx.server & | endif
]])
vim.cmd("autocmd VimEnter * !mix archive.install hex phx_new --force")
