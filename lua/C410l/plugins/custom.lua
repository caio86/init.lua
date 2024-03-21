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

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixpkgs_fmt" },
        -- Conform can also run multiple formatters sequentially
        python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { { "prettierd", "prettier" } },
      },
    },
  },
}

return plugins
