-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Create a dedicated group to manage our autocommands
local ns = vim.api.nvim_create_augroup("AutoSearchHighlight", { clear = true })

-- 1. Enable hlsearch when searching (/ or ?)
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = ns,
  callback = function()
    local cmd_type = vim.fn.getcmdtype()
    if cmd_type == "/" or cmd_type == "?" then
      vim.opt.hlsearch = true
    end
  end,
})

-- 2. Disable hlsearch when moving the cursor OFF a match
vim.api.nvim_create_autocmd("CursorMoved", {
  group = ns,
  callback = function()
    -- If highlight is ON and we are NOT on a match -> turn it OFF
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.opt.hlsearch = false
      pcall(function()
        require("noice").cmd("dismiss")
      end)
    end
  end,
})
