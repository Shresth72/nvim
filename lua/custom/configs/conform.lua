local conform = require "conform"

-- state variable
local conform_enabled = true

-- wrapper around format_on_save
conform.setup {
  -- Custom formatters
  formatters = {
    uncrustify = {
      command = "uncrustify",
      args = {
        "-c",
        vim.fn.expand("~/.config/uncrustify/uncrustify.cfg"),
        "--no-backup",
        "--replace",
        "$FILENAME",
      },
      stdin = false,
    },
  },

  formatters_by_ft = {
    c = { "uncrustify" },
    cpp = { "uncrustify" },

    lua = { "stylua" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    rust = { "rustfmt" },
    haskell = { "fourmolu" },
    go = { "golines" },
    sh = { "shellharden" },
    yaml = { "yamlfmt" },
    cs = { "csharpier" },
    python = { "black" },
    -- python = { "ruff" },
    proto = { "buf" },
    java = { "google-java-format" },
    sql = { "sqlfmt" },
    php = { "phpcbf" },
    terraform = { "terraform_fmt" },
  },
  format_on_save = function(bufnr)
    if not conform_enabled then
      return
    end
    return {
      lsp_format = "fallback",
      timeout_ms = 1000,
    }
  end,
}

-- user command to toggle on/off
vim.api.nvim_create_user_command("ConformDisable", function()
  conform_enabled = false
  print "Conform autoformat disabled"
end, {})

vim.api.nvim_create_user_command("ConformEnable", function()
  conform_enabled = true
  print "Conform autoformat enabled"
end, {})

vim.api.nvim_create_user_command("ConformToggle", function()
  conform_enabled = not conform_enabled
  print("Conform autoformat " .. (conform_enabled and "enabled" or "disabled"))
end, {})
