return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      picker = {
        win = {
          input = {
            keys = {
              -- Close the picker on Esc in both normal (n) and insert (i) mode
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
    },
  },
}
