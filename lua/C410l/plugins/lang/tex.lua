return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy loading will disable inverse search
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_mappings_disable = { ["n"] = { "k" } }
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    end,
    keys = {
      { "<localleader>l", "", desc = "+vimtex", ft = "tex" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          keys = {
            { "<leader>K", "<plug>(vimtex-doc-packages)", desc = "Vimtex Docs", silent = true },
          },
        },
      },
    },
  },
}
