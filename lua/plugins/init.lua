return {    { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,},
  --% прыжок к следйющей скобке, слову закрывающей скобке
  --g%	Перейти к парному элементу в обратном направлении.
  --[%	Перейти к началу блока.
  --]%	Перейти к концу блока.
  --z%	Перейти к следующему элементу в середине блока.
   {
   "andymass/vim-matchup",
  event = "BufReadPost",
  config = function()
    vim.g.matchup_matchparen_enabled = 1          -- Отключает встроенный matchparen
    vim.g.matchup_matchparen_deferred = 1        -- Улучшает производительность
    vim.g.matchup_matchparen_offscreen = {      -- Показывает подсказки за пределами экрана
      method = "popup",
    }
    vim.g.matchup_text_obj_enabled = 1          -- Включает текстовые объекты (di%, ci% etc.)
    vim.g.matchup_surround_enabled = 1          -- Интеграция с vim-surround
  end,  },
  'bronson/vim-visual-star-search',
  {
    'chentoast/marks.nvim',
    event = "VeryLazy",
    opts = {},
  },
  -- install mason
  { import = 'plugins.mason' },

  'godlygeek/tabular',
  'itspriddle/vim-marked',
  'ludovicchabant/vim-gutentags',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
      }
    end,
  },
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tyru/open-browser.vim',
  'vim-test/vim-test',
  {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup({
        mode = "document_diagnostics"
      })
    end
  },
  {
    'gelguy/wilder.nvim',
    config = function() require('config/wilder') end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'onsails/lspkind.nvim',
    },
    config = function() require('config/nvim-cmp') end,
  },
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = { theme = 'onedark' },
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function() require('config/telescope') end,
  },
  {
    'preservim/vim-pencil',
    dependencies = {
      'preservim/vim-litecorrect',
      'kana/vim-textobj-user',
      'preservim/vim-textobj-quote',
      'preservim/vim-textobj-sentence',
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      augroup('pencil', { clear = true })
      autocmd('FileType', {
        group = 'pencil',
        pattern = { "markdown" ,"text" },
        callback = function()
          vim.cmd("call pencil#init({'wrap': 'hard'})")
          vim.cmd("call litecorrect#init()")
          vim.cmd("call textobj#quote#init()")
          vim.cmd("call textobj#sentence#init()")
        end
      })
    end
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
      })
    end
  },
}
