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
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "delve",
          "codelldb",
          "local-lua-debugger-vscode",
        },
      })
      require("nvim-dap-virtual-text").setup({
        -- NOTE: TJ DeVries: This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        --
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }

      -- Evgeny Koltsov: This is config for Lua from ChatGPT. Doesn't work yet.
      -- -- Configure the Lua Debugger Adapter (local-lua-debugger-vscode)
      -- dap.adapters.lua = {
      --   type = "server",
      --   host = "127.0.0.1", -- Debugger server will run on localhost
      --   port = 8086, -- Default port for local-lua-debugger-vscode, change if necessary
      --   executable = {
      --     command = "~/.local/share/nvim/lazy/local-lua-debugger-vscode", -- Replace with the path to the debugger binary
      --     args = { "--server" }, -- Arguments to run the debugger in server mode
      --   },
      -- }
      --
      -- -- Lua Debugger launch configuration
      -- dap.configurations.lua = {
      --   {
      --     type = "lua",
      --     request = "launch",
      --     name = "Launch Lua file",
      --     program = "${file}", -- Program to run (current file)
      --   },
      -- }

      local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
      if elixir_ls_debugger ~= "" then
        dap.adapters.mix_task = {
          type = "executable",
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = "mix_task",
            name = "phoenix server",
            task = "phx.server",
            request = "launch",
            projectDir = "${workspaceFolder}",
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
          },
        }
      end

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
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
    end,
  },
}
