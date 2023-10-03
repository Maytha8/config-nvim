-- LEADER KEY
vim.g.mapleader = " "

-- TRUECOLOR
vim.opt.termguicolors = true

-- Dadbod UI
vim.g.db_ui_use_nerd_fonts = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- Highlight active line
vim.opt.cursorline = true

-- Mouse support
vim.opt.mouse = "nvi"

-- Indentation
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

-- Encoding
vim.opt.encoding = "utf-8"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Don't wrap long lines
vim.opt.wrap = false

-- Undo
vim.opt.undofile = true

-- Scroll off
vim.opt.scrolloff = 8

-- Themes and Fonts
vim.opt.guifont = "DejaVu Sans Mono for Powerline"

-- Netrw builtin file tree
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 15

-- Close tags
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.vue,*.svelte"
