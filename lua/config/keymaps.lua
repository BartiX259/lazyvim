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

-- We will delete any existing mapping that starts with these keys
local prefixes = {
  -- "<leader>f",
  "<leader>x",
  "<leader>g",
  -- not bound by lazyvim
  -- "<leader>r"
  -- "<leader>t"
}

local mappings = vim.api.nvim_get_keymap("n")

for _, mapping in ipairs(mappings) do
  local lhs = mapping.lhs
  if lhs == nil then
    goto continue
  end
  for _, prefix in ipairs(prefixes) do
    if
      lhs:match("^" .. prefix)
      or lhs:match("^" .. prefix:gsub("<leader>", "<Space>"))
      or lhs:match("^" .. prefix:gsub("<leader>", " "))
    then
      del("n", lhs)
    end
  end
  ::continue::
end

map("n", "<leader>f", function()
  Snacks.picker.files({ cwd = vim.fn.getcwd() })
end, { desc = "Find Files" })
map("n", "<leader>g", function()
  Snacks.picker.grep({ cwd = vim.fn.getcwd() })
end, { desc = "Grep (Root Dir)" })
map("n", "<leader>x", function()
  Snacks.bufdelete.delete()
end, { desc = "Close Buffer" })
map("n", "<leader>r", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>t", function()
  Snacks.picker.buffers()
end, { desc = "Find Open Buffers" })
