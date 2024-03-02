-- map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- line numbers
opt.nu = true
opt.relativenumber = true

-- set identation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- enable true colors
opt.termguicolors = true

-- misc
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
