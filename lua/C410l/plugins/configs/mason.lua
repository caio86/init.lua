local base = require("C410l.plugins.configs.lspconfig")
local capabilities = base.capabilities
local on_attach = base.on_attach

local options = {
  -- auto install lsps
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "pyright",
  },

  -- auto-install configured servers (with lspconfig)
  automatic_installation = true,

  handlers = {
    function(server_name) -- default handler
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    ["lua_ls"] = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              disable = { "different-requires" },
            },
          },
        },
      })
    end,
  },
}

return options
