local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.fourmolu,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.csharpier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.sqlfmt,
    null_ls.builtins.formatting.phpcbf,
    null_ls.builtins.formatting.terraform_fmt,
    -- null_ls.builtins.formatting.asmfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

return opts
