-- map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- edit netrw browser
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local opt = vim.opt

-- line numbers
opt.nu = true
opt.relativenumber = true
opt.numberwidth = 2

-- set identation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

-- disable wrap
opt.wrap = false

-- make undo file
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- enable true colors
opt.termguicolors = true

-- redefine splitting priority
opt.splitbelow = true
opt.splitright = true

-- misc
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.statuscolumn = [[%!v:lua.require('C410l.statuscolumn').myStatusColumn()]]
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.updatetime = 50
opt.pumheight = 14

opt.colorcolumn = "80"
