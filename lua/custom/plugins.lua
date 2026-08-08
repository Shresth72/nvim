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
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  --   config = function() end,
  -- },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   lazy = false,
  --   dependencies = {
  --     { "github/copilot.vim" },
  --     { "nvim-lua/plenary.nvim", branch = "master" },
  --   },
  --   build = "make tiktoken",
  --   opts = {
  --     window = {
  --       layout = "vertical",
  --       width = 40,
  --     },
  --   },
  --   keys = {
  --     { "<leader>c", "<cmd>CopilotChatToggle<CR>", mode = "n", desc = "Open Copilot Chat" },
  --     { "<leader>ze", "<cmd>CopilotChatExplain<CR>", mode = "v", desc = "Explain Selected Code" },
  --     { "<leader>zr", "<cmd>CopilotChatReview<CR>", mode = "v", desc = "Review Selected Code" },
  --     { "<leader>zf", "<cmd>CopilotChatFix<CR>", mode = "v", desc = "Fix Code Issues" },
  --     { "<leader>zo", "<cmd>CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
  --     { "<leader>zd", "<cmd>CopilotChatDocs<CR>", mode = "v", desc = "Generate Docs" },
  --     { "<leader>zt", "<cmd>CopilotChatTests<CR>", mode = "v", desc = "Generate Tests" },
  --     { "<leader>zm", "<cmd>CopilotChatCommit<CR>", mode = "n", desc = "Generate Commit Message" },
  --     { "<leader>zs", "<cmd>CopilotChatCommit<CR>", mode = "v", desc = "Generate Commit for Selection" },
  --   },
  -- },
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
      "<space>sp",
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
      return require "custom.configs.rust"
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
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("dap-python").setup("/usr/bin/python3", {
        adapter = "debugpy",
      })

      require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 25 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
          stopOnEntry = true,
          console = "integratedTerminal",
        },
      }

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DiagnosticError", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      -- vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    end,
  },
}
return plugins
