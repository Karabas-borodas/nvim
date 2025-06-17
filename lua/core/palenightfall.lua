local highlight = require('palenightfall.internal').highlight

local M = {}


---Color definitions.
---
---@type table<string, string>
M.colors = {
  background = '#252837',
  foreground = '#a6accd',

  background_darker = '#232534',
  highlight = '#2b2f40',
  references = '#2e2e41',  -- Mix 19 background / 1 purple
  selection = '#343A51',
  statusline = '#1d1f2b',
  foreground_darker = '#7982b4',
  line_numbers = '#4e5579',
  comments = '#676e95',

  red = '#ff5370',
  orange = '#f78c6c',
  yellow = '#ffcb6b',
  green = '#c3e88d',
  cyan = '#89ddff',
  blue = '#82aaff',
  paleblue = '#b2ccd6',
  purple = '#D49BFD',
  brown = '#c17e70',
  pink = '#f07178',
  violet = '#bb80b3',

  -- Mix 6 background / 10 color
  red_dark = '#9e4057',
  orange_dark = '#9a6054',
  blue_dark = '#5970a6',
  green_dark = '#7d9367',

  -- Diff change
  -- Mix 7 background / 1 #00BE6A
  diff_add_background = '#203b3d',
  -- Mix 2 background / 1 #00BE6A
  diff_add_highlight = '#1c4e44',
  -- Mix 5 background / 1 red
  diff_delete_background = '#492f41',
  -- Mix 2 background / 1 red
  diff_delete_hightlight = '#6e364a',
}

---Configure the colors used for highlights.
---
---@param overrides table<string, string> Color overrides following the same
---format as `colors`
function M.configure_colors(overrides)
  M.colors = vim.tbl_deep_extend('force', M.colors, overrides or {})
end

---Table of all highlights that this plugin sets up.
---
---Can be customized with `configure_highlights`.
---
---@type PalenightfallHighlightConfig
M.highlights = nil

---Configure highlights and override the given ones
---
---@param overrides PalenightfallHighlightConfig Will be merged reqursively 
---with the defaults
---@param transparent ?boolean
function M.configure_highlights(overrides, transparent)
  local c = M.colors

  ---@type PalenightfallHighlightConfig
  local default_highlights = {
    -- UI elements
  
  }

  M.highlights = vim.tbl_deep_extend('force', default_highlights, overrides or {})
end
---Configure and enable the colorscheme.
--
---@param opts PalenightfallOpts
function M.setup(opts)
  opts = opts or {}

  if vim.g.colors_name then
    vim.cmd [[hi clear]]
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'palenightfall'

  if opts.color_overrides ~= nil then
    M.configure_colors(opts.color_overrides or {})
  end
  M.configure_highlights(opts.highlight_overrides or {}, opts.transparent)

  for group, hls in pairs(M.highlights) do
    highlight(group, hls)
  end
end

return M
