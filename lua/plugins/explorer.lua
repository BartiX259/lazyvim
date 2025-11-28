return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            -- Close the explorer after opening a file
            jump = { close = true },
          },
        },
      },
    },
  },
}
