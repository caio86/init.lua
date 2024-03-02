-- create helper function
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- tmux-sessionizer to ctrl+f
map("n", "<C-f>", function()
  if not os.getenv("TMUX") then
    -- not in Tmux
    os.execute("tmux-sessionizer")
  else
    -- On Tmux
    os.execute("tmux neww tmux-sessionizer")
  end
end, { desc = "Tmux sessionizer" })

-- keymaps
map("n", "<leader>e", vim.cmd.Ex, { desc = "File Explorer" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
