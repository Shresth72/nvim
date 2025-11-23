local config = require "plugins.configs.lspconfig"
local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
  "tailwindcss",
  "eslint",
  "cssls",
  "terraformls",
  "csharp_ls",
  "gradle_ls",
  "lemminx",
  "html",
  "protols",
  "sqlls",
  "intelephense",
  "zls",
  "kotlin_language_server",
  "cssmodules_ls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- lspconfig.pyright.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "python" },
-- }

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E302", "E261", "E262", "E501", "E402", "E251", "E225", "E226", "E701", "W503", "E203" },
        },
        pyflakes = {
          enabled = true,
          ignore = { "F401", "F841", "W503" }, -- Ignore unused import error (F401)
        },
      },
    },
  },
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  filetypes = { "c", "cpp" },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--log=verbose",
    "--header-insertion=iwyu",
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        useany = false,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    },
  },
}

lspconfig.hls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "haskell", "lhaskell", "cabal" },
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    schemaStore = {
      enable = true,
    },
  },
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
