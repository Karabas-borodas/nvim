return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<leader>Dc", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<leader>Do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<leader>Di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<leader>DO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>Dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>Du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>Dg", function() require("dap-go").debug_test() end, desc = "Debug: Go Test" },
      { "<F1>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F2>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F3>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F4>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<F5>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<F6>", function() require("dap").terminate() end, desc = "Debug: Stop/Terminate" },
      { "<F7>", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<F8>", function() require("dap-go").debug_test() end, desc = "Debug: Go Test" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      local dlv_path = "dlv"
      local mason_dlv = vim.fn.stdpath("data") .. "/mason/bin/dlv"
      local go_dlv = vim.fn.expand("~/go/bin/dlv")
      if vim.fn.executable(mason_dlv) == 1 then
        dlv_path = mason_dlv
      elseif vim.fn.executable(go_dlv) == 1 then
        dlv_path = go_dlv
      end

      require("dap-go").setup({
        delve = {
          path = dlv_path,
          args = { "--check-go-version=false" },
        },
      })

      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "Visual", numhl = "" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
