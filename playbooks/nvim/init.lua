require('config.lazy')
require('config.lsp')
require('config.fzf')
vim.cmd.colorscheme "catppuccin-macchiato"
vim.g.mapleader = " "
local fzf_lua = require("fzf-lua")

-- determine context root for fzf picks/searches (git project root for example)
local git_dir = vim.fs.find(".git", {
  upward = true,
  type = "directory",
})[1]
local project_root = git_dir and vim.fs.dirname(git_dir) or vim.loop.os_homedir()
-- 

-- Setting calls for fast file search folder-local/project-wide
vim.keymap.set({ "n" }, "<Leader>p",
  function()
    local parent_dir_abs_path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    require("fzf-lua").files({ cwd = parent_dir_abs_path })
  end, 
  { silent = true }
)

vim.keymap.set({ "n" }, "<Leader>P",
  function()
    local git_dir = vim.fs.find(".git", {
      upward = true,
      type = "directory",
    })[1]
    local project_root = git_dir and vim.fs.dirname(git_dir) or vim.loop.os_homedir()

    require("fzf-lua").files({cwd = project_root })
  end, 
  { silent = true }
)
-- 

vim.keymap.set({ "n" }, "<Leader>H",
  function()
    local git_dir = vim.fs.find(".git", {
      upward = true,
      type = "directory",
    })[1]
    local project_root = git_dir and vim.fs.dirname(git_dir) or vim.loop.os_homedir()

    require("fzf-lua").live_grep({cwd = project_root })
  end, 
  { silent = true }
)

vim.keymap.set({ "n" }, "<Leader>b", fzf_lua.buffers, {silent = true})
vim.keymap.set({ "n" }, "<Leader>gs", fzf_lua.git_status, {silent = true})