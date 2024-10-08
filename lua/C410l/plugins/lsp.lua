return {
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
      vim.g.codeium_enabled = true

      local function add_codeium(sources)
        table.insert(sources, { name = "codeium", priority = 101, group_index = 1 })
      end

      local function remove_codeium(sources)
        for i = #sources, 1, -1 do
          if sources[i].name == "codeium" then
            table.remove(sources, i)
          end
        end
      end

      vim.api.nvim_create_user_command("ToggleCodeium", function()
        local Util = require("lazy.core.util")
        local cmp = require("cmp")
        local sources = cmp.get_config().sources

        if vim.g.codeium_enabled then
          remove_codeium(sources)
          Util.warn("Disabled codeium", { title = "Option" })
        else
          add_codeium(sources)
          Util.info("Enabled codeium", { title = "Option" })
        end
        vim.g.codeium_enabled = not vim.g.codeium_enabled

        cmp.setup({ sources = sources })
      end, { desc = "Toggle codeium source for cmp" })

      require("cmp").setup(opts)
    end,
  },
}
