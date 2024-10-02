local plugins = {
  --======== LUA =========--
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "wbthomason/packer.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  --======== MASON PACKAGES =========
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "typescript-language-server",
        "eslint-lsp",
        "glsl_analyzer",
        "glslls",
        "prettier",
        "haskell-language-server",
        "hlint",
        "fourmolu",
        "tailwindcss-language-server",
        "yaml-language-server",
        "clangd",
        "lua-language-server",
        "clang-format",
        "codelldb",
        "gopls",
        "gofumpt",
        "golines",
        "goimports-reviser",
        "terraform-ls",
        "ast-grep",
        "shfmt",
      },
    },
  },
  --=========== TMUX ============
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  --========= NULL LS ===========
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  --========== RUST ============
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  --============= Python ==============
  {
    "luk400/vim-jukit",
    lazy = true,
    -- config = function ()
    --   require("custom.configs.jukit")
    -- end
  },
  --============= Kubernetes ==============
  {
    "arjunmahishi/k8s.nvim",
    ft = {
      "yaml",
      "yml",
    },
    config = function()
      require("k8s").setup {
        kube_config_dir = "/tmp/kubeconfig",
      }
    end,
  },
  --======== AutoTag Completion ===========
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "css",
        "rust",
      }
      return opts
    end,
  },
  --============ MarkDown ==============
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require "custom.configs.todoconfig"
    end,
  },
  --=========== Debugger ===============
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
}
return plugins
