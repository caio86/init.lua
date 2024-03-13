-- plugins related to the editor

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = function()
      return require("C410l.plugins.configs.telescope")
    end,
    config = function(_, opts)
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      local telescope = require("telescope")
      telescope.setup(opts.options)

      wk.register({
        ["<space>"] = {opts.project_files, "Find File"},
        f = {
          f = { builtin.find_files, "Find File" },
          b = { builtin.buffers, "Find Buffer" },
          g = { builtin.live_grep, "Find with Grep" },
          h = { builtin.help_tags, "Find Help" },
          w = { builtin.grep_string, "Find Word"},
        },
        s = {
        },
        g = {

        },
      }, { prefix = "<leader>" })
    end
  },
  { "mbbill/undotree" },
  {
    "theprimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      local wk = require("which-key")

      wk.register({
        ["<leader>a"] = { mark.add_file, "Harpoon Add File"},
        ["<C-e>"] = { ui.toggle_quick_menu, "Harpoon Toggle Quick Menu"},

        ["<leader>1"] = { function()
          ui.nav_file(1)
        end, "Harpoon File 1"},

        ["<leader>2"] = { function()
          ui.nav_file(2)
        end, "Harpoon File 2"},

        ["<leader>3"] = { function()
          ui.nav_file(3)
        end, "Harpoon File 3"},
      })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    --
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require("C410l.plugins.configs.others").gitsigns
    end,
    config = function (_, opts)
      require("gitsigns").setup(opts)
    end
  }
}
