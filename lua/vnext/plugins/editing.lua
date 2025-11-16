return {
--Плагин для автоформатирования кода при сохранении файла, уходе из режима вставки и при открытии буфера.
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "InsertLeave" },
    opts = {
      format_on_save = function()
        -- Disable with a global variable
        if not vim.g.autoformat then
          return
        end
        return { async = false, timeout_ms = 500, lsp_fallback = false }
      end,
      -- log_level = vim.log.levels.TRACE,
      formatters_by_ft = {
        dockerfile = { "dockerfmt" },
        go = { "goimports", "gofmt" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier", "markdownlint-cli2" },
        python = { "isort", "ruff_format" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        tex = { "latexindent" },
        toml = { "taplo" },
        typst = { "typstfmt" },
        yaml = { "yamlfmt" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      conform.formatters.shfmt = {
        prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
      }
      conform.formatters.stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
      }
      conform.formatters.yamlfmt = {
        prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
      }
      vim.g.autoformat = vim.g.autoformat
      vim.api.nvim_create_user_command("ToggleAutoformat", function()
        vim.api.nvim_notify("Toggling autoformat", vim.log.levels.INFO, { title = "conform.nvim", timeout = 2000 })
        vim.g.autoformat = vim.g.autoformat == false and true or false
      end, { desc = "Toggling autoformat" })
      vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
    end,
  },

--Позволяет быстро прыгать к словам или элементам кода по шаблону или дереву синтаксиса (treesitter).
  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      {
        "ss",
        mode = { "n", "x", "o" },
        -- Jump to any word
        function()
          ---@diagnostic disable: missing-fields
          require("flash").jump({
            pattern = ".", -- initialize pattern with any char
            search = {
              mode = function(pattern)
                -- remove leading dot
                if pattern:sub(1, 1) == "." then
                  pattern = pattern:sub(2)
                end
                -- return word pattern and proper skip pattern
                return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
              end,
            },
          })
        end,
        desc = "Flash",
      },
      -- stylua: ignore start
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
      -- stylua: ignore end
    },
  },

  -- обрамление текста буфера 
  {
    "nvim-mini/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Number of lines within which surrounding is searched
      n_lines = 50,
    },
  },

 --Позволяет изящно заменять текст выбранной области или в операторном режиме с помощью горячих клавиш.
-- Клавиша s в нормальном режиме — оператор для замены (вызывается require("substitute").operator()).
-- Клавиша s в визуальном режиме — замена выделенного текста (вызывается require("substitute").visual()).

  {
    "gbprod/substitute.nvim",
    keys = {
    -- stylua: ignore start
    { "s", function() require("substitute").operator() end, desc = "Substitute", },
    { "s", mode = "x", function() require("substitute").visual() end, desc = "Substitute", },
      -- stylua: ignore end
    },
    opts = {},
  },

  -- вызывает лист коментариев <leader>sT
  {
    {
      "folke/todo-comments.nvim",
      event = "BufReadPre", -- needed to highlight keywords
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        highlight = {
          multiline = false, -- I usually only want one line to be highlighted
        },
      },
      keys = {
        -- stylua: ignore start
        { "<leader>sT", function() Snacks.picker.todo_comments() end, desc = "Todo", },
        -- stylua: ignore end
      },
    },
  },

  {
 "allaman/emoji.nvim",
  version = "1.0.0", -- optionally pin to a tag
  ft = "markdown", -- adjust to your needs
  dependencies = {
    -- util for handling paths
    "nvim-lua/plenary.nvim",
    -- optional for nvim-cmp integration
    "hrsh7th/nvim-cmp",
    -- optional for telescope integration
    "nvim-telescope/telescope.nvim",
    -- optional for fzf-lua integration via vim.ui.select
    "ibhagwan/fzf-lua",
  },
  opts = {
    -- default is false, also needed for blink.cmp integration!
    enable_cmp_integration = true,
    -- optional if your plugin installation directory
    -- is not vim.fn.stdpath("data") .. "/lazy/
    plugin_path = vim.fn.expand("$HOME/plugins/"),
  },
  config = function(_, opts)
    require("emoji").setup(opts)
    -- optional for telescope integration
    local ts = require('telescope').load_extension 'emoji'
    vim.keymap.set('n', '<leader>se', ts.emoji, { desc = '[S]earch [E]moji' })
  end,
  },

-- emoji blink.cmp integration
-- Высокопроизводительный движок автодополнения с поддержкой множества источников, включая emoji и lazydev (см. предыдущие ответы).
-- Горячие клавиши для управления автодополнением: <C-space>, <C-e>, <CR>, <Tab>, <S-Tab>, <C-k>, <C-j>, <C-f>, <C-b> (управление списком автодополнения и документацией).
    {
    "saghen/blink.cmp",
    dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(ctx, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },
    },
  },

  -- Инструмент для поиска и замены, интегрированный через удобные горячие клавиши и команды.
    -- <leader>RG — открыть окно поиска и замены.
    -- <leader>Rg — открыть поиск в текущем файле.
    -- <leader>Rw — поиск слова под курсором.
    -- <leader>Rs — поиск выделенного текста.
  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    opts = {},
    keys = {
      -- stylua: ignore start
      { "<leader>R", "", desc = "Search & Replace" },
      { "<leader>RG", "<cmd>GrugFar<cr>", desc = "Open" },
      { "<leader>Rg", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Open (Limit to current file)"},
      { "<leader>Rw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Search word under cursor", },
      { "<leader>Rs", mode = "v", "<cmd>lua require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })<cr>", desc = "Search selection", },
      -- stylua: ignore end
    },
  },

  
-- Позволяет ровнять текст по определённым символам или шаблонам с режимом предпросмотра.
    -- Визуальный режим: ga — выравнивание по шаблону.
    -- Визуальный режим: gA — выравнивание с предпросмотром.

  {
    "nvim-mini/mini.align",
    keys = {
      { "ga", mode = { "v" }, desc = "Align" },
      { "gA", mode = { "v" }, desc = "Align with Preview" },
    },
    opts = {},
  },
}
