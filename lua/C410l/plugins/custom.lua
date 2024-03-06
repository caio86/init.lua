local plugins = {
  {
    "Eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = { "Window left" } },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = { "Window right" } },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = { "Window down" } },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = { "Window up" } },
    },
  },
}

return plugins
