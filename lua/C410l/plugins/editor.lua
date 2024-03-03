-- plugins related to the editor

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      local config = require("C410l.plugins.configs.telescope")

      wk.register({
        ["<space>"] = { config.project_files, "Find File"},
        f = {
          name = "+File",
          f = { builtin.find_files, "Find File" },
          b = { builtin.buffers, "Find Buffer" },
          g = { builtin.live_grep, "Find with Grep" },
          h = { builtin.help_tags, "Find Help" },
        },
        s = {
        },
        g = {

        },
      }, { prefix = "<leader>" })
    end
  },
  {
    "theprimeagen/harpoon",
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
}
