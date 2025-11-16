return {
  {
-- Это расширение обёртка над Git, позволяющая выполнять команды git прямо из Neovim, интегрируя взаимодействие с git в редактор.
    -- <leader>gg — открыть панель Fugitive (:G).
    -- <leader>gl — отобразить лог изменений (:GcLog).
    -- <leader>gD — открыть diff в вертикальном сплите (:Gvdiffsplit).
    -- <leader>gf — показать лог изменений файла (:0GcLog).

    "tpope/vim-fugitive",
    cmd = "G",
    config = function()
      local fugitive = vim.api.nvim_create_augroup("Fugitive", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = fugitive,
        pattern = { "fugitiveblame", "fugitive" },
        callback = function()
          vim.api.nvim_buf_set_keymap(0, "n", "q", "gq", {})
        end,
        desc = "Close fugitive with q instead of gq",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = fugitive,
        pattern = { "git" },
        callback = function()
          vim.opt_local.foldmethod = "syntax"
          vim.opt_local.foldlevel = 0
          vim.opt_local.foldenable = true
        end,
      })

      vim.api.nvim_create_user_command("Gcn", function(opts)
        local branch_name = opts.args
        if branch_name == "" then
          vim.api.nvim_err_writeln("Error: Branch name is required")
          return
        end
        vim.cmd("Git checkout -b " .. branch_name)
      end, {
        nargs = 1,
        desc = "Create and checkout new git branch",
      })
    end,
    keys = {
      { "<leader>gg", "<cmd>G<cr>", desc = "G" },
      { "<leader>gl", "<cmd>GcLog<cr>", desc = "Difflog" },
      { "<leader>gD", "<cmd>Gvdiffsplit<cr>", desc = "Diffsplit" },
      { "<leader>gf", "<cmd>0GcLog<cr>", desc = "Difflog file" },
    },
  },

-- Плагин отображает изменения git (добавления, изменения, удаления) прямо в редакторе рядом с номерами строк.
-- В функции on_attach устанавливаются локальные биндинги клавиш для работы с «хуками» (частями изменений):
    -- gj — перейти к следующему изменённому участку (hunk).
    -- gk — перейти к предыдущему.
    -- <leader>gs — зафиксировать текущий хук (stage hunk).
    -- <leader>gu — отменить фиксацию в визуальном режиме.
    -- <leader>gr — сбросить изменения хвоста (reset hunk).
    -- <leader>gS — зафиксировать весь буфер (stage buffer).
    -- <leader>gR — сбросить весь буфер (reset buffer).
    -- <leader>gp — показать превью изменений.
    -- <leader>gb — включить/выключить отображение blame на текущей строке.
    -- <leader>gd — показать удалённые изменения inline.

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = {
        delay = 0,
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.silent = true
          vim.keymap.set(mode, l, r, opts)
        end
      -- stylua: ignore start
      map("n", "gj", function() gs.nav_hunk("next") end, { desc = "Git Next hunk" })
      map("n", "gk", function() gs.nav_hunk("prev") end, { desc = "Git previous hunk" })
      map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      map("v", "<leader>gu", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Undo stage hunk" })
      map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
      map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Blame line" })
      -- map("n", "<leader>gD", gs.diffthis, {desc="Diff"})
      map("n", "<leader>gd", gs.preview_hunk_inline, { desc = "Show deleted" })
      end,
      -- stylua: ignore end
    },
    keys = {
      { "<leader>g", "", desc = "+Git" },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
