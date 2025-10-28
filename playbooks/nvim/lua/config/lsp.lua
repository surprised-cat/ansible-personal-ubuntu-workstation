local lsp_keybindings = function(client, bufnr)
  -- use buffer-local keymaps so they only apply when LSP is active
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
end

vim.lsp.config('terraformls', {
  on_attach = lsp_keybindings,
  root_markers = { '.terraform', '.git', 'versions.tf' }
})
vim.lsp.enable('terraformls')

vim.lsp.config('gopls', {
  on_attach = lsp_keybindings,
})
vim.lsp.enable('gopls')