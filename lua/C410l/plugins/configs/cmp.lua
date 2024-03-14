local cmp = require "cmp"

local cmp_ui = {
  icons = true,
  lspkind_text = true,
  style = "atom", -- default/flat_light/flat_dark/atom/atom_colored
  border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
  selected_item_bg = "simple", -- colored / simple
}
local cmp_style = cmp_ui.style

local field_arrangement = {
  atom = { "kind", "abbr", "menu" },
  atom_colored = { "kind", "abbr", "menu" },
}

local formatting_style = {
  -- default fields order i.e completion word + item.kind + item.kind icons
  fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

  format = require("lspkind").cmp_format({ with_text = true, maxheight = 20, maxwidth = 50, menu = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    path = "[Path]",
    luasnip = "[LuaSnip]",
    nvim_lua = "[Lua]",
  }}),
}

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local options = {
  -- window = {
  --   completion = {
  --     side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
  --     winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
  --     scrollbar = true,
  --   },
  --   documentation = {
  --     border = border "CmpDocBorder",
  --     winhighlight = "Normal:CmpDoc",
  --   },
  -- },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- experimental = {
  --   native_menu = false,
  --   ghost_text = false,
  -- },

  formatting = formatting_style,

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "crates" },
  },
}

if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
  options.window.completion.border = border "CmpBorder"
end

return options
