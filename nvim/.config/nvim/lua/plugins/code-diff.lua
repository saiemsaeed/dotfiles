return {
  "esmuellert/codediff.nvim",
  enabled = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  config = function()
    require("codediff").setup({
      diff = {
        disable_inlay_hints = true,
      },
      keymaps = {
        view = {
          next_file = "<Tab>", -- Next file in explorer mode
          prev_file = "<S-Tab>", -- Previous file in explorer mode
        },
        conflict = {
          accept_incoming = "<leader>ct", -- Accept all incoming (theirs/left) changes
          accept_current = "<leader>co", -- Accept all current (ours/right) changes
          accept_both = "<leader>cb", -- Accept both changes (incoming first)
          discard = "<leader>cx", -- Discard both, keep base
          next_conflict = "]x", -- Jump to next conflict
          prev_conflict = "[x", -- Jump to previous conflict
        },
      },
    })
  end,
}
