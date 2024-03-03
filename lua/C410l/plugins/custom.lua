local plugins = {
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      local wk = require("which-key")

      wk.register({
        ["<leader>a"] = { mark.add_file, "Harpoon Add File"},
        ["<leader>h"] = { ui.toggle_quick_menu, "Harpoon Toggle Quick Menu"},
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

return plugins
