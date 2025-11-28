-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Create a dedicated group to manage our autocommands

-- Automatically toggle highlight search
local ns = vim.api.nvim_create_augroup("AutoSearchHighlight", { clear = true })
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = ns,
  callback = function()
    local cmd_type = vim.fn.getcmdtype()
    if cmd_type == "/" or cmd_type == "?" then
      vim.opt.hlsearch = true
    end
  end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
  group = ns,
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.opt.hlsearch = false
      pcall(function()
        require("noice").cmd("dismiss")
      end)
    end
  end,
})

-- Automatically apply chezmoi config
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ChezmoiConfigHook", { clear = true }),
  pattern = { "*/chezmoi/chezmoi.toml", "*/.local/share/chezmoi/*" },
  callback = function(ev)
    local args = { "chezmoi", "apply" }

    -- Optimization: If you are editing a specific source file (not the main config),
    -- only apply that specific file. This is faster.
    local file = ev.match
    if not file:match("chezmoi.toml") then
      table.insert(args, "--source-path")
      table.insert(args, file)
    end

    -- Run the command
    vim.fn.jobstart(args, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Chezmoi applied successfully!", vim.log.levels.INFO)
        else
          vim.notify("Chezmoi failed to apply. Check :messages", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})
