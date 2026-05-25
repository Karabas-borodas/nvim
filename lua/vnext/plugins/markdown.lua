return {
  -- Beautiful, rich in-buffer rendering of markdown documents
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    ft = { "markdown", "codecompanion" },
    keys = {
      {
        "<leader>um",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Markdown Rendering",
        ft = "markdown",
      },
    },
    opts = {
      heading = {
        sign = false,
        icons = { "❶ ", "❷ ", "❸ ", "❹ ", "❺ ", "❻ " },
      },
      code = {
        style = "full",
        position = "left",
        width = "block",
        left_pad = 2,
        right_pad = 2,
      },
      checkbox = {
        enabled = true,
      },
    },
  },

  -- Preview markdown in the web browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview (Browser)",
        ft = "markdown",
      },
    },
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
