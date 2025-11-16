

-- Этот фрагмент — часть конфигурации LSP/diagnostic в Neovim, которая:
-- Визуально выделяет проблемные строки.
-- Позволяет удобно переключаться между ошибками.
-- Даёт быстрый доступ к дополнительной информации по ошибкам.
-- Помогает эффективно отслеживать состояние кода во время работы
-- Горячие клавиши для работы с диагностикой:
-- <leader>dj — перейти к следующей диагностике.
-- <leader>dk — перейти к предыдущей диагностике.
-- <leader>dc — открыть всплывающее окно с информацией о диагностике в текущем месте.
-- <leader>dd — вывести список диагностик в quickfix списке.

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

--- highligh line number according to diagnostics
vim.diagnostic.config({
  signs = {
    -- text = {
    --   [vim.diagnostic.severity.ERROR] = "",
    --   [vim.diagnostic.severity.WARN] = "",
    --   [vim.diagnostic.severity.INFO] = "",
    --   [vim.diagnostic.severity.HINT] = "",
    -- },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
})

-- stylua: ignore start
map("n", "<leader>dj", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next Diagnostic" })
map("n", "<leader>dk", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
map("n", "<leader>dc", function() vim.diagnostic.open_float() end, { desc = "Toggle current diagnostic" })
map("n", "<leader>dd", function() vim.diagnostic.setqflist() end, { desc = "Open quickfix" })
-- stylua: ignore end
