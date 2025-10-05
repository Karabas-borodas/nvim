return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = {
        enable = true,
        filetypes = { "html", "xml", "javascriptreact", "typescriptreact" },
      },
      ensure_installed = {
        "lua", "rust", "c", "cpp", "python", "javascript", "typescript", "html", "css", "json", "yaml", "markdown",
      },
      auto_install = true,
    })
  end
}
