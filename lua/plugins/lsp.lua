-- plugins/lsp.lua
local lspconfig = require('lspconfig')

-- Настройка LSP-сервера для C/C++ (clangd)
lspconfig.clangd.setup{}

