return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  opts = {
    fuzzy = {
      implementation = "prefer_rust",
    },
    signature = { enabled = true },
    completion = {
      menu = { border = nil },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = "none" },
      },
      ghost_text = { enabled = true },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      sources = { "buffer", "cmdline" },
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },
  },
}
