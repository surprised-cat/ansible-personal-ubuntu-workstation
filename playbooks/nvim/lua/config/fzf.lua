local actions = require("fzf-lua").actions
require('fzf-lua').setup {
  keymap = {
    builtin = {
      ["<S-j>"]    = "preview-down",
      ["<S-k>"]      = "preview-up",
      ["<S-h>"]    = "preview-half-page-up",
      ["<S-l>"]   = "preview-half-page-down",
    },

    fzf = {
      ["ctrl-a"]       = 'select-all',
    },

    -- This is required to make delta be invoked by git, not fzf
    -- if invoked by fzf it fails to display word based diff and renders diff always by line
    -- I.E even if 1 symbol is changed the whole line diff is displayed(like default behavior)
    git = {
      git = {
        status = {
          pager = true,
        },
        diff = {
          pager = true,
        },
      }
    }
  }
}
