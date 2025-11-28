return {
  -- 1. Disable Todo-comments keys (xt, xT)
  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>xt", false },
      { "<leader>xT", false },
    },
  },

  -- 2. Disable Trouble keys (xx, xX, xq, xl, etc)
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", false },
      { "<leader>xX", false },
      { "<leader>xq", false },
      { "<leader>xQ", false },
      { "<leader>xl", false },
      { "<leader>xL", false },
    },
  },
}
