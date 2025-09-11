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
  }
}
