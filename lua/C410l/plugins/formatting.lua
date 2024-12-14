return {
  { -- Autoformat
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "VimEnter",
    cmd = "ConformInfo",
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
          return
        end
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
        sh = { "shfmt" },
        -- Conform can also run multiple formatters sequentially
        python = { "isort", "black" },
      },
      formatters = {
        injected = { options = { ignore_erros = true } },
      },
    },
    keys = {
      {
        "<leader>uf",
        function()
          local Util = require("lazy.core.util")
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          if vim.g.disable_autoformat then
            Util.warn("Disabled auto formatting", { title = "Option" })
          else
            Util.info("Enabled auto formatting", { title = "Option" })
          end
        end,
        desc = "Toggle auto formatting",
      },
      {
        "<leader>cf",
        function()
          require("conform").format({})
        end,
        mode = { "n", "v" },
        desc = "Code Format",
      },
    },
  },
}
