return {
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  --   keys = {
  --     { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" },
  --   },
  --   opts = {
  --     ui = {
  --       icons = {
  --         package_pending = " ",
  --         package_installed = "󰄳 ",
  --         package_uninstalled = " 󰚌",
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = function()
  --     return require("C410l.plugins.configs.mason")
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     -- Useful status updates for LSP.
  --     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  --     { "j-hui/fidget.nvim", opts = {} },
  --
  --     -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
  --     -- used for completion, annotations and signatures of Neovim apis
  --     { "folke/neodev.nvim", opts = {} },
  --   },
  --   keys = {
  --     { "<leader>cl", "<cmd>LspInfo<CR>", desc = "LSP Info" },
  --   },
  --   config = function()
  --     require("C410l.plugins.configs.lspconfig")
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        keys = {
          { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" },
        },
        opts = {
          ui = {
            icons = {
              package_pending = " ",
              package_installed = "󰄳 ",
              package_uninstalled = " 󰚌",
            },
          },
        },
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { "folke/neodev.nvim", opts = {} },
    },
    keys = {
      { "<leader>cl", "<cmd>LspInfo<CR>", desc = "LSP Info" },
    },
    config = function()
      require("C410l.plugins.configs.lsp-config")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),

        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged, TextChangedI" },
        config = function(_, opts)
          require("C410l.plugins.configs.others").luasnip(opts)
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
      },
    },
    opts = function()
      return require("C410l.plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
}
