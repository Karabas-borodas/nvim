-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, C, and C++, but can
-- be extended to other languages as well.

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "vadimcn/vscode-lldb",
      "jay-babu/mason-nvim-dap.nvim",
      "tomblind/local-lua-debugger-vscode",
    },
config = function()
  local dap = require("dap")
  local ui = require("dapui")

  require("dapui").setup()
  require("dap-go").setup()

  require("mason-nvim-dap").setup({
    -- конфигурация mason-nvim-dap ...
  })

  require("nvim-dap-virtual-text").setup({
    -- конфигурация виртуального текста ...
  })

  -- Здесь должна быть вся настройка адаптеров
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch file',
      type = 'cppdbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
      runInTerminal = true,  -- Включает запуск в терминале nvim
    },
    {
      name = 'Attach to process',
      type = 'cppdbg',
      request = 'attach',
      processId = require('dap.utils').pick_process,
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
    },
  }

  dap.configurations.c = dap.configurations.cpp

  -- Далее настройка клавиш и слушателей тоже должна быть внутри функции
  vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
  vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

  vim.keymap.set("n", "<space>?", function()
    require("dapui").eval(nil, { enter = true })
  end)

  vim.keymap.set("n", "<F1>", dap.continue)
  vim.keymap.set("n", "<F2>", dap.step_into)
  vim.keymap.set("n", "<F3>", dap.step_over)
  vim.keymap.set("n", "<F4>", dap.step_out)
  vim.keymap.set("n", "<F5>", dap.step_back)
  vim.keymap.set("n", "<F6>", dap.restart)
  vim.keymap.set("n", "<F8>", dap.terminate)
  vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)

  dap.listeners.before.attach.dapui_config = function()
    ui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    ui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
  end
end,  -- конец функции config
  },
}
