-- debug-java.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-jdtls", -- Для интеграции с Java
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- Настройка Mason для DAP
      require("mason-nvim-dap").setup({
        ensure_installed = { "javadbg", "javatest" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      -- Конфигурация Java Debug Adapter
      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Current File",
          mainClass = function()
            -- Получаем главный класс из текущего файла
            local current_file = vim.fn.expand("%:t:r")
            return current_file
          end,
          projectName = function()
            -- Автоматически определяем имя проекта
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
        },
        {
          type = "java",
          request = "launch",
          name = "Launch Main Class",
          mainClass = function()
            -- Запрашиваем у пользователя главный класс
            return vim.fn.input("Main class: ", "", "file")
          end,
          projectName = function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
        },
        {
          type = "java",
          request = "attach",
          name = "Attach to Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
        {
          type = "java",
          request = "attach",
          name = "Attach to Process",
          hostName = "127.0.0.1",
          port = function()
            return vim.fn.input("Port: ", "5005")
          end,
        },
      }

      -- Настройка клавиш
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

      -- Автоматическое открытие/закрытие UI
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

  -- Настройка JDTLS с поддержкой дебаггера
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      -- Функция для настройки при открытии Java файлов
      local function setup_jdtls()
        local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
        local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace/" .. vim.fn.fnamemodify(root_dir, ":t")

        -- Путь к java-debug и java-test
        local bundles = {}
        local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")

        -- java-debug
        vim.list_extend(
          bundles,
          vim.split(vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true), "\n")
        )

        -- java-test
        vim.list_extend(
          bundles,
          vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true), "\n")
        )

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration", mason_path .. "/packages/jdtls/config_linux",
            "-data", workspace_dir,
          },
          root_dir = root_dir,
          init_options = {
            bundles = bundles,
          },
          on_attach = function(client, bufnr)
            -- Настройка дебаггера для Java
            jdtls.setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()

            -- Добавляем команды для тестов
            vim.keymap.set("n", "<leader>tc", jdtls.test_class, { buffer = bufnr, desc = "Test Class" })
            vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, { buffer = bufnr, desc = "Test Method" })
          end,
        }

        jdtls.start_or_attach(config)
      end

      -- Автокоманда для настройки при открытии Java файлов
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = setup_jdtls,
      })
    end,
  },
}
