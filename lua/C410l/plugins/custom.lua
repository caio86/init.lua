MyUtils = require("C410l.util.init")

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

  { "christoomey/vim-tmux-navigator" },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "towolf/vim-helm",
    ft = "helm",
  },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      modes = { "n", "i", "no", "c" },
      hybrid_modes = { "i" },

      -- This is nice to have
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "nc"
        end,
      },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>D", "<cmd>DBUI<cr>", desc = "Database UI" },
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "Exafunction/codeium.nvim",
    enabled = false,
    event = "VeryLazy",
    build = ":Codeium Auth",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      enable_chat = true,
    },
    config = function(_, opts)
      require("codeium").setup(opts)
    end,
  },

  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>cs", ":CodeSnap<CR>", desc = "Snapshot", mode = { "v" } },
    },
    opts = {
      mac_window_bar = true,
      title = "CodeSnap.nvim",
      code_font_family = "CaskaydiaCove Nerd Font",
      watermark_font_family = "Pacifico",
      watermark = "",
      bg_theme = "default",
      breadcrumbs_separator = "/",
      has_breadcrumbs = false,
      has_line_number = false,
      show_workspace = false,
      min_width = 0,
      bg_x_padding = 122,
      bg_y_padding = 82,
      save_path = os.getenv("XDG_PICTURES_DIR") or (os.getenv("HOME") .. "/Pictures"),
    },
  },
}

return plugins
