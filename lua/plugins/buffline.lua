-- Файл: lua/plugins/bufferline.lua

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "tabs", -- Устанавливает режим на "tabs" для использования вкладок
				numbers = "none", -- Отключает отображение номеров буферов
				close_command = "bdelete! %d", -- Команда для закрытия буфера
				right_mouse_command = "tabnew | b %d", -- Команда для правой кнопки мыши, открывает файл в новой вкладке
				left_mouse_command = "tabnew | b %d", -- Команда для левой кнопки мыши, открывает файл в новой вкладке
				middle_mouse_command = nil, -- Команда для средней кнопки мыши
				indicator = {
					icon = "▎", -- Иконка для индикатора
					style = "icon", -- Стиль индикатора
				},
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15, -- Применяется только когда powerline отключен
				tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true, -- Буферы будут сохранять свой порядок
				separator_style = "thin", -- Стиль разделителя: "slant" | "thick" | "thin" | { 'any', 'any' }
				enforce_regular_tabs = false,
				always_show_bufferline = true,
			},
			highlights = {
				fill = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				background = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				buffer_visible = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				close_button = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				close_button_visible = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				tab_selected = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				tab = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				tab_close = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				duplicate_selected = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
					gui = "italic",
				},
				duplicate_visible = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
					gui = "italic",
				},
				duplicate = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
					gui = "italic",
				},
				modified = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				modified_selected = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
				},
				modified_visible = {
					guifg = { attribute = "fg", highlight = "Normal" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				separator = {
					guifg = { attribute = "bg", highlight = "StatusLine" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				separator_selected = {
					guifg = { attribute = "bg", highlight = "StatusLine" },
					guibg = { attribute = "bg", highlight = "StatusLineNC" },
				},
				indicator_selected = {
					guifg = { attribute = "fg", highlight = "DiagnosticInfo" },
					guibg = { attribute = "bg", highlight = "StatusLine" },
					gui = "bold",
				},
			},
		})
	end,
}
