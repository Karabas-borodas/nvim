
require'nvim-treesitter.configs'.setup {
 ensure_installed = { "bash", "c", 'html', 'lua', 'markdown', 'vim', 'vimdoc' },--выбрать языки которые будет поддерживать c++ c# не поддерждиваются нужно допольнительно устанавливать

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
