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

vim.keymap.set({ "n" }, "<Leader>qf", fzf_lua.quickfix, {silent = true})
vim.keymap.set({ "n" }, "<Leader>qfs", fzf_lua.quickfix_stack, {silent = true})
vim.keymap.set("n", "<leader>qfr", function()
  local qf = vim.fn.getqflist({ title = 1 })
  local current_title = qf.title or "(no title)"
  vim.ui.input({ prompt = "Rename Quickfix List: ", default = current_title }, function(input)
    if input and input ~= "" then
      vim.fn.setqflist({}, 'a', { title = input })
      print("Quickfix renamed to: " .. input)
    end
  end)
end, { desc = "Rename Quickfix List" })


-- Better diff engine settings
vim.opt.diffopt:append({
  "internal",           -- use Neovim's internal diff (fast + consistent)
  "filler",             -- keep lines aligned
  "closeoff",           -- close other windows when entering diff
  "hiddenoff",          -- don't diff hidden buffers (avoids surprises)
  "vertical",           -- vertical splits by default
  "algorithm:histogram" -- cleaner hunks than default Myers
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "go" },
  highlight = { enable = true },
})

-- Intra-line (word-level) diff highlighting
-- Increase the number for “smarter” but slower matching (try 120+ on big files)
vim.opt.diffopt:append("linematch:80")
vim.opt.expandtab = true
vim.opt.foldenable = true       -- enable folding
vim.opt.foldlevelstart = 99     -- open all folds on file open
vim.opt.foldnestmax = 3    
vim.opt.number = true

vim.api.nvim_create_autocmd("FileType", {
 pattern = "go",
  callback = function()
    vim.opt_local.foldenable = true
    vim.opt_local.foldmethod = "expr"
    -- Prefer built-in foldexpr on newer Neovim, fall back to plugin one
    if pcall(function() return vim.treesitter.foldexpr end) then
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    end
    vim.opt_local.foldlevel = 99  -- show everything on open; use zM to close all
end,
})


local dap_go = require('dap-go')
local dap = require('dap')
dap_go.setup()
local dap, dapui = require("dap"), require("dapui")

require("dapui").setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F2>', dap.step_into)
vim.keymap.set('n', '<F3>', dap.step_over)
vim.keymap.set('n', '<F4>', dap.step_out)
vim.keymap.set('n', '<Leader>tb', dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
vim.keymap.set('n', '<Leader>dr', dap.repl.open)
vim.keymap.set('n', '<Leader>dl', dap.run_last)