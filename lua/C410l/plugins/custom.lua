local plugins = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
    cmd = "WhickKey"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = function()
      return require("C410l.plugins.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      local builtin = require("telescope.builtin")
      local wk = require("which-key")

      wk.register({
        f = {
          name = "+File",
          f = { builtin.find_files, "Find File" },
          b = { builtin.buffers, "Find Buffer" },
          g = { builtin.live_grep, "Find with Grep" },
          h = { builtin.help_tags, "Find Help" },
        },
      }, { prefix = "<leader>" })
    end
  },
}

return plugins
