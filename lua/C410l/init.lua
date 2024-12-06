-- Get system information
local system_name = vim.loop.os_uname().sysname

if system_name == "Linux" then
  local file = io.open("/etc/os-release", "r")
  if file then
    local content = file:read("*all")
    file:close()
    if string.find(content, "ID=nixos") then
      vim.g.is_nixos = true
    end
  end
end

require("C410l.set")
require("C410l.remaps")
require("C410l.lazy")

local on_attach = require("C410l.plugins.configs.base-lsp").on_attach

local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(e)
    local buffer = e.buf
    local client = vim.lsp.get_client_by_id(e.data.client_id)
    if client then
      return on_attach(client, buffer)
    end
  end,
})
