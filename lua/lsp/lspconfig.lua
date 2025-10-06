-- LSP Configuration
-- local remap = require("me.util").remap

---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(_, bufnr)
--  -- Mappings.
--  -- See `:help vim.lsp.*` for documentation on any of the below functions
--  local bufopts = { noremap=true, silent=true, buffer=bufnr }
--  --gD: Перейти к объявлению (declaration) переменной/функции.
--  remap('n', 'gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
--  --gd: Перейти к определению (definition).
--  remap('n', 'gd', vim.lsp.buf.definition, bufopts, "Go to definition")
--  --gi: Перейти к реализации (implementation) интерфейса.
--  remap('n', 'gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
--  --K (Shift + k): Показать всплывающую документацию для слова под курсором.
--  remap('n', 'K', vim.lsp.buf.hover, bufopts, "Hover text")
--  --<C-k> (Ctrl + k): Показать подсказку по аргументам функции.
--  remap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
----Добавить папку в workspace LSP
--  remap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
--  --Удалить папку из workspace
--  remap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
----Вывести список папок в workspace
--  remap('n', '<space>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, bufopts, "List workspace folders")
--  --Переход к определению типа
--  remap('n', '<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
--  --Переименовать символ (переименует во всех файлах!)
--  remap('n', '<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
--  --	Выполнить действие (рефакторинг, исправление ошибок и т.д.)
--  remap('n', '<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
--  --Форматировать файл асинхронно
--  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
--    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
--  remap('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
--end

-- add completion capability
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- local lspconfig = require('lspconfig')

-- lspconfig['ltex'].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" },
--   settings = {
--     ltex = {
--       language = "en-CA",
--     }
--   }
-- }

-- lspconfig['gopls'].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--       },
--       staticcheck = true,
--     },
--   }
-- }

-- lspconfig['pyright'].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     pyright = {
--       analysis = {
--         useLibraryCodeForTypes = true,
--       },
--     },
--   }
-- }

-- lspconfig['rust_analyzer'].setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig['solargraph'].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig['ts_ls'].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
local on_lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "go", function()
    telescope.lsp_type_definitions()
  end, opts)
  vim.keymap.set("n", "gR", function()
    telescope.lsp_references()
  end, opts)
  vim.keymap.set("n", "gi", function()
    telescope.lsp_implementations()
  end, opts)
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set("n", "ge", function()
    telescope.diagnostics()
  end, opts)
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "gn", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "gp", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>xca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>xrn", function()
    vim.lsp.buf.rename()
  end, opts)
end

return {
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("symbol-usage").setup()
		end,
	},
	{
		"towolf/vim-helm",
		ft = "helm",
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
    opts = {
      registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
      },
    }
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lsp_signature_help" },
          per_filetype = {
            codecompanion = { "codecompanion" },
          }
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
			})
			require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/snippets" } })
		end,
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				on_lsp_attach(client, bufnr)
			end)
			lsp_zero.set_server_config({
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					helm_ls = function()
						require("lspconfig").helm_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								["helm-ls"] = {
									yamlls = {
										path = "yaml-language-server",
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
  {
  "seblj/roslyn.nvim",
  ft = "cs",
  -- enabled = false,
  opts = {
    config = {
      on_attach = function (client, bufnr)

        -- let client know we got this
        client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, {
          semanticTokensProvider = {
            full = true,
        }})

        -- Save the original request method
        local original_request = client.request

        -- Override the client's request method
        client.request = function(method, params, handler, ctx, config)
          -- Log all LSP requests to a file
          -- local log_file = io.open("/tmp/nvim_lsp_debug.log", "a")
          -- if log_file then
          --   log_file:write(string.format("\n=== LSP Client Request at %s ===\n", os.date()))
          --   log_file:write("method: " .. method .. "\n")
          --   log_file:write("params: " .. vim.inspect(params) .. "\n")
          --   log_file:write("================================\n")
          --   log_file:close()
          -- end

          if method == "textDocument/semanticTokens/full" then
            -- Modify the request to a range request covering the entire document

            -- Convert URI to buffer number
            local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)

            -- Ensure the buffer is loaded
            if not vim.api.nvim_buf_is_loaded(target_bufnr) then
              vim.notify("[LSP] Buffer not loaded for URI: " .. params.textDocument.uri, vim.log.levels.WARN)
              return original_request(method, params, handler, ctx, config)
            end

            -- Get the total number of lines in the buffer
            local line_count = vim.api.nvim_buf_line_count(target_bufnr)

            -- Get the last line's content
            local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1] or ""

            -- Calculate the end character (0-based index)
            local end_character = #last_line

            -- Construct the range
            local range = {
              start = { line = 0, character = 0 },
              ["end"] = { line = line_count - 1, character = end_character },
            }

            -- Construct the new params for the range request
            local new_params = {
              textDocument = params.textDocument,
              range = range,
            }

            -- Log the modification
            -- local log_file_range = io.open("/tmp/nvim_lsp_debug.log", "a")
            -- if log_file_range then
            --   log_file_range:write("Modified to 'textDocument/semanticTokens/range' with range: " .. vim.inspect(range) .. "\n")
            --   log_file_range:close()
            -- end

            -- Send the modified range request
            return original_request("textDocument/semanticTokens/range", new_params, handler, ctx, config)
          end

          -- Call the original request method for all other methods
          return original_request(method, params, handler, ctx, config)
        end
      end,
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
          dotnet_enable_tests_code_lens = true,
        },
        ["csharp|completion"] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
          dotnet_show_name_completion_suggestions = true,
        },
        ["csharp|background_analysis"] = {
          background_analysis_dotnet_compiler_diagnostics_scope = "fullSolution",
        },
        ["csharp|symbol_search"] = {
          dotnet_search_reference_assemblies = true,
        },
      },
    },
  },
},
}

