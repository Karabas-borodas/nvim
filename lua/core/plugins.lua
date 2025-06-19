-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {'nvim-lua/plenary.nvim'},
-- плагин заметок NOTE:
-- FIX:
-- HACK:
-- TODO:
-- PERF:
-- WARNING:
-- INFO:
-- ISSUE:
-- OPTIM:
-- XXX:
-- PERFORMANCE:
-- TESTING:
-- PASSED:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "mason-org/mason.nvim",
      opts = {},
    },
    -- LSP config
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },
        -- nvim-cmp for autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("plugins.lsp")
      end,
    },
    -- Themes
--     {
--
--   "rebelot/kanagawa.nvim",
--
--   config = function()
--
--     vim.cmd("colorscheme kanagawa-dragon")  -- Make sure to use the correct colorscheme name
--
--   end,
--
-- },
{"sam4llis/nvim-tundra",
  -- config = function()
  --
  --   vim.cmd("colorscheme arctic")  -- Make sure to use the correct colorscheme name
  --
  -- end,
  },
-- {
--       'JoosepAlviste/palenightfall.nvim',
--       config = function()
--         vim.cmd("colorscheme palenightfall")
--       end,
--     },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'phaazon/hop.nvim' },
    -- Treesitter for syntax highlighting
    { "nvim-treesitter/nvim-treesitter" },
    -- DAP configuration
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
      },
      config = function()
        require("plugins.dap")
      end,
    },
    { import = "plugins" },
  },

  -- UI configuration for lazy.nvim
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
