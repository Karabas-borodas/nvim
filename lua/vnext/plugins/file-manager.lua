return {
  {
    -- Файловый менеджер (проводник) запуск на "-"
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    keys = {
      { "-", "<cmd>Fyler<cr>", desc = "Open Fyler" },
    },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "\\", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle Filetree" },
      { "<leader>fg", "<cmd>Neotree float grep<cr>", desc = "Grep (float)" },
      { "<leader>ft", "<cmd>Neotree float terminal<cr>", desc = "Terminal (float)" },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        indent = {
          with_markers = false,
        },
        name = {
          highlight_opened_files = true,
        },
      },
      filesystem = {
        commands = {
          delete = function(state)
            local path = state.tree:get_node().path
            vim.fn.system({ "trash", vim.fn.fnameescape(path) })
            require("neo-tree.sources.manager").refresh(state.name)
          end,
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if vim.fn.executable("open") == 1 then
              vim.api.nvim_command("silent !open -g " .. path)
            elseif vim.fn.executable("xdg-open") == 1 then
              vim.api.nvim_command("silent !xdg-open " .. path)
            else
              vim.notify("Could not determine OS", vim.log.levels.ERROR)
            end
          end,
        },
        window = {
          mappings = {
            ["o"] = "system_open",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["<C-x>"] = "clear_filter",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["<space>"] = {
              "toggle_node",
              nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["R"] = "refresh",
            ["a"] = {
              "add",
              config = {
                show_path = "none",
              },
            },
            ["A"] = "add_directory",
            ["d"] = "noop",
            ["dd"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          },
        },
        hijack_netrw_behavior = "open_current",
      },
      -- Настройка для плавающих окон
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["g"] = "noop",
          ["G"] = "noop",
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "",
            renamed   = "",
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
        },
      },
      -- Настройка для плавающих окон grep и терминала
      float = {
        enable = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = function() return math.floor(vim.o.columns * 0.8) end,
          height = function() return math.floor(vim.o.lines * 0.8) end,
          row = function() return math.floor((vim.o.lines - vim.o.lines * 0.8) / 2) end,
          col = function() return math.floor((vim.o.columns - vim.o.columns * 0.8) / 2) end,
          style = "minimal",
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}

