local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilites = require("plugins.configs.lspconfig").capabilities

---@diagnostic disable-next-line: missing-fields
local client = vim.lsp.start {
  name = "mylsp",
  cmd = { "/home/shrestha/go_lang/lsp/main" },
  on_attach = on_attach,
  capabilities = capabilities,
}

if not client then
  vim.notify "my lsp client not started"
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})
