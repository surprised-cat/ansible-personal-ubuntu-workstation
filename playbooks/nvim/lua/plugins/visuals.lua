return {
  { 
    "catppuccin/nvim",
    name = "catppuccin", 
    priority = 1000,
  },

  {
    "neovim/nvim-lspconfig",
  },

  {"ibhagwan/fzf-lua"},
  
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go'
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "go", "lua", "vim", "bash" },
      highlight = { enable = true },
    },
  }
}