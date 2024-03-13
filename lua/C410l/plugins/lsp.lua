return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    keys = {
      { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" }
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
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      return require("C410l.plugins.configs.mason")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    keys = {
      { "<leader>cl", "<cmd>LspInfo<CR>", desc = "LSP Info" }
    },
    config = function()
      require("C410l.plugins.configs.base_lsp")
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencias = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged, TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require("C410l.plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end
  },
}
