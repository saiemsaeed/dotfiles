return {
  "folke/flash.nvim",
  opts = {
    -- You can customize which keys to use for labeling
    labels = "hjklyuionmefc",

    -- Exclude specific keys from triggering flash
    -- modes = {
    --   char = {
    --     enabled = false, -- disable for 'f', 'F', 't', 'T' motions
    --   },
    -- },
  },
  keys = {
    -- Disable the default 's' mapping if you want
    -- { "s", mode = { "n", "x", "o" }, false },

    -- Or remap to a different key
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
