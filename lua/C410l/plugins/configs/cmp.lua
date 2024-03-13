-- local cmp = require("cmp")
--
-- local cmp_ui = {
--   icons = true,
--   lspkind_text = true,
--   style = "default"
-- }
-- local cmp_style = cmp_ui.style
--
-- local field_arrangement = {
--   atom = { "kind", "abbr", "menu" },
--   atom_colored = { "kind", "abbr", "menu" },
-- }
--
-- local formatting_style = {
--   -- default fields order i.e completion word + item.kind + item.kind icons
--   fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
--
--   format = function(_, item)
--     local icons = require "nvchad.icons.lspkind"
--     local icon = (cmp_ui.icons and icons[item.kind]) or ""
--
--     if cmp_style == "atom" or cmp_style == "atom_colored" then
--       icon = " " .. icon .. " "
--       item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
--       item.kind = icon
--     else
--       icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
--       item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
--     end
--
--     return item
--   end,
-- }
--
-- local function border(hl_name)
--   return {
--     { "╭", hl_name },
--     { "─", hl_name },
--     { "╮", hl_name },
--     { "│", hl_name },
--     { "╯", hl_name },
--     { "─", hl_name },
--     { "╰", hl_name },
--     { "│", hl_name },
--   }
-- end

local options = function()
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require("cmp")
  local defaults = require("cmp.config.default")()
  return {
    completion = {
      completeopt = "menu,menuone,noinsert"
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp" },
    }, {
      { name = "buffer" },
    }),
    -- formatting = {
    --   format = function(_, item)
    --     local icons = require("lazyvim.config").icons.kinds
    --     if icons[item.kind] then
    --       item.kind = icons[item.kind] .. item.kind
    --     end
    --     return item
    --   end,
    -- },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  }
  end

return options
