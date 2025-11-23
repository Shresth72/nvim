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
    "echasnovski/mini.icons",
    version = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  --======== GITHUB COPILOT =========
  {
    "github/copilot.vim",
    lazy = false,
    config = function() end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      window = {
        layout = "vertical",
        width = 40,
      },
    },
    keys = {
      { "<leader>c",  "<cmd>CopilotChatToggle<CR>",   mode = "n", desc = "Open Copilot Chat" },
      { "<leader>ze", "<cmd>CopilotChatExplain<CR>",  mode = "v", desc = "Explain Selected Code" },
      { "<leader>zr", "<cmd>CopilotChatReview<CR>",   mode = "v", desc = "Review Selected Code" },
      { "<leader>zf", "<cmd>CopilotChatFix<CR>",      mode = "v", desc = "Fix Code Issues" },
      { "<leader>zo", "<cmd>CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
      { "<leader>zd", "<cmd>CopilotChatDocs<CR>",     mode = "v", desc = "Generate Docs" },
      { "<leader>zt", "<cmd>CopilotChatTests<CR>",    mode = "v", desc = "Generate Tests" },
      { "<leader>zm", "<cmd>CopilotChatCommit<CR>",   mode = "n", desc = "Generate Commit Message" },
      { "<leader>zs", "<cmd>CopilotChatCommit<CR>",   mode = "v", desc = "Generate Commit for Selection" },
    },
  },
  --======== MASON PACKAGES =========
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "typescript-language-server",
        "gradle-language-server",
        "eslint-lsp",
        "glsl_analyzer",
        "prettier",
        "tailwindcss-language-server",
        "yaml-language-server",
        "clangd",
        "lua-language-server",
        "clang-format",
        "python-lsp-server",
        "codelldb",
        "gopls",
        "gofumpt",
        "golines",
        "asm-lsp",
        "terraform-ls",
        "shfmt",
      },
    },
  },
  --=========== TMUX ============
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  --=========== SESSIONS ============
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Session Search" },
    },
    config = function()
      require("auto-session").setup()
    end,
  },
  --========= CODE FORMATTERS ===========
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "custom.configs.conform"
    end,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },
  --========== UTILS ============
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "VeryLazy",
    opts = {
      window = {
        blend = 0,
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      "<space>m",
      "<space>j",
      "<space>s",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {}
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "mm",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<leader>v",
        mode = { "n" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {
      signs = true, -- show icons in the sign column
      keywords = {
        TODO = { icon = " ", color = "info" },
        FIX = { icon = " ", color = "error" },
        HACK = { icon = " ", color = "warning" },
        NOTE = { icon = " ", color = "hint" },
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)

      -- telescope integration
      vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "List TODOs in Telescope" })
      vim.keymap.set("n", "<leader>tq", "<cmd>TodoQuickFix<CR>", { desc = "QuickFix TODOs" })
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
