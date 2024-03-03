-- plugins related to the editor

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
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
}
