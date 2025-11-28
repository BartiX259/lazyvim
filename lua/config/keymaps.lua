-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>")
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>")
map("n", "n", function()
  vim.cmd("normal! n")
  vim.opt.hlsearch = true
end)
map("n", "N", function()
  vim.cmd("normal! N")
  vim.opt.hlsearch = true
end)
del("n", "<leader>xl")
del("n", "<leader>xq")
map("n", "<leader>x", "<cmd>bdelete<cr>")
