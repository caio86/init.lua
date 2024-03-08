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
  }
}
