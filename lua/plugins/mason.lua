--lua/plagins/mason
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
        ensure_installed = {
          'jdtls',           -- Java LSP
          'gopls',
          'pyright',
          'rust_analyzer',
          'ts_ls'
        },
        automatic_installation = true,
      })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'mason.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require('mason-nvim-dap').setup({
        ensure_installed = {
          'java-debug-adapter',  -- Java Debug Adapter
          'java-test',          -- Java Test runner
        },
        automatic_installation = true,
      })
    end,
  },
}
