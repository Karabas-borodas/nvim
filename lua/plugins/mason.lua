return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'jdtls', 'gopls', 'pyright', 'rust_analyzer', 'ts_ls' },
        automatic_installation = true,
      })
    end,
  },
}
