return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    prompt = "  ",
    debug = {
      enabled = false,
      show_scores = false,
    },
    layout = {
      prompt_position = "top",
      preview_position = "right",
      preview_size = 0.45,
      -- on narrow screens, move preview above results instead of squishing side-by-side
      flex = {
        size = 140,
        wrap = "top",
      },
      show_scrollbar = true,
      path_shorten_strategy = "middle_number",
    },
    preview = {
      enabled = true,
      line_numbers = true,
      wrap_lines = false,
      filetypes = {
        markdown = { wrap_lines = true },
        text = { wrap_lines = true },
      },
    },
    -- git status colors on filenames in the picker
    git = {
      status_text_color = true,
    },
    grep = {
      smart_case = true,
      time_budget_ms = 150,
      modes = { "plain", "regex", "fuzzy" },
    },
    frecency = { enabled = true },
    history = { enabled = true },
  },
  lazy = false,
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "Find Files (FFF)",
    },
    {
      "<leader>sg",
      function()
        require("fff").live_grep()
      end,
      desc = "Live Grep (FFF)",
    },
    {
      "<leader><space>",
      function()
        require("fff").find_files()
      end,
      desc = "Find Files (FFF)",
    },
    -- find files relative to the current buffer's directory
    {
      "<leader>fd",
      function()
        local dir = vim.fn.expand("%:p:h")
        require("fff").find_files_in_dir(dir)
      end,
      desc = "Find Files in Buffer Dir (FFF)",
    },
  },
}
