-- Настройка цветовой схемы rose-pine
require("rose-pine").setup({
	variant = "auto", -- auto, main, moon, or dawn
	dark_variant = "main", -- main, moon, or dawn
	dim_inactive_windows = false,
	extend_background_behind_borders = true,

	enable = {
		terminal = true,
		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
		migrations = true, -- Handle deprecated options automatically
	},

	styles = {
		bold = true,
		italic = true,
		transparency = false,
	},

	groups = {
		border = "muted",
		link = "iris",
		panel = "surface",

		error = "love",
		hint = "iris",
		info = "foam",
		note = "pine",
		todo = "rose",
		warn = "gold",

		git_add = "foam",
		git_change = "rose",
		git_delete = "love",
		git_dirty = "rose",
		git_ignore = "muted",
		git_merge = "iris",
		git_rename = "pine",
		git_stage = "iris",
		git_text = "rose",
		git_untracked = "subtle",

		h1 = "iris",
		h2 = "foam",
		h3 = "rose",
		h4 = "gold",
		h5 = "pine",
		h6 = "foam",
	},

	palette = {
		-- Override the builtin palette per variant
		-- moon = {
		--     base = '#18191a',
		--     overlay = '#363738',
		-- },
	},

	highlight_groups = {
		-- Comment = { fg = "foam" },
		-- VertSplit = { fg = "muted", bg = "muted" },
	},

	before_highlight = function(group, highlight, palette)
		-- Disable all undercurls
		-- if highlight.undercurl then
		--     highlight.undercurl = false
		-- end
		--
		-- Change palette colour
		-- if highlight.fg == palette.pine then
		--     highlight.fg = palette.foam
		-- end
	end,
})

-- Установка цветовой схемы
vim.cmd("colorscheme rose-pine-main")

-- Настройка курсора
vim.opt.guicursor = ""
vim.cmd([[
    highlight Cursor guifg=NONE guibg=NONE
    highlight! link Cursor Cursor
]])

-- Настройка indent-blankline.nvim
require("ibl").setup({
	-- Настройка цвета полос отступов
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
	},
	indent = {
		char = "│",
		tab_char = "│",
	},
	whitespace = {
		highlight = {
			"IndentBlanklineSpaceChar",
			"IndentBlanklineSpaceCharBlankline",
		},
	},
	exclude = {
		filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
	},
})

-- Настройка цветов для indent-blankline.nvim
vim.cmd([[
    highlight IndentBlanklineChar guifg=#555555 gui=nocombine
    highlight IndentBlanklineContextChar guifg=#333333 gui=nocombine
    highlight IndentBlanklineSpaceChar guifg=#555555 gui=nocombine
    highlight IndentBlanklineSpaceCharBlankline guifg=#555555 gui=nocombine
]])
