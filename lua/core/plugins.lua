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
--    {
--     'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- -- or                              , branch = '0.1.x',
--       dependencies = { 'nvim-lua/plenary.nvim' }
{
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {   "mason-org/mason.nvim",
    opts = {}},
    	 -- lsp конфиг

	 {
	 	"neovim/nvim-lspconfig",
	 	dependencies = {
	 		-- Automatically install LSPs and related tools to stdpath for neovim
	 		"williamboman/mason.nvim",
	 		"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

 		-- Useful status updates for LSP.
 		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
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
	-- thems
    -- {
    --   "rebelot/kanagawa.nvim",
    --   config = function()
    --     vim.cmd("colorscheme kanagawa-wave")
    --   end,
    -- },
--theme
{
      'JoosepAlviste/palenightfall.nvim',
      config = function()
        vim.cmd("colorscheme palenightfall")
      end,
    },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
--keymap jklh move
      {  'phaazon/hop.nvim'},
-- treesitter делает разметку текста
{"nvim-treesitter/nvim-treesitter"},
--cmp plugins (плагины для автодополнения)
 { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
-- leader meny (вызывает меню на пробел)
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},




    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})



