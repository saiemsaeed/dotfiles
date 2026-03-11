return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require("fff.download").download_or_build_binary()
  end,
  -- if you are using nixos
  -- build = "nix run .#release",
  opts = { -- (optional)
    promt = "🔍",
    debug = {
      enabled = true, -- we expect your collaboration at least during the beta
      show_scores = false, -- to help us optimize the scoring system, feel free to share your scores!
    },
    layout = {
      prompt_position = "top", -- or 'top'
    },
  },
  lazy = false,
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "FFF Find Files",
    },
    -- Replace default live_grep
    {
      "<leader>sg",
      function()
        require("fff").live_grep()
      end,
      desc = "FFF Live Grep",
    },
    -- Replace default buffers
    {
      "<leader><space>",
      function()
        require("fff").find_files()
      end,
      desc = "FFF Buffers",
    },
  },
}
