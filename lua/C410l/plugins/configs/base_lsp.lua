local M = {}

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  -- local opts = { desc = "teste",  buffer = bufnr, remap = false }
  -- create helper function
  local function map(mode, lhs, rhs, opts)
    local options = { buffer = bufnr, remap = false }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
  end

  map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Goto Definition" })
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Goto References" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Goto Implementation" })
  map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Goto T[y]pe Definition" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  map("n", "<leader>cw", vim.lsp.buf.workspace_symbol, { desc = "Workspace" })
  map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
  map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
  map("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })
  map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
  map(
    "n",
    "<leader>cA",
    function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source",
          },
          diagnostics = {},
        },
      })
    end,
    { desc = "Source Action" }
  )
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return M
