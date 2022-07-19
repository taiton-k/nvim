vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu   = 1
vim.g.did_indent_on             = 1
vim.g.did_load_filetypes        = 1
vim.g.did_load_ftplugin         = 1
vim.g.loaded_gzip               = 1
vim.g.loaded_tarPlugin          = 1
vim.g.loaded_tar                = 1
vim.g.loaded_zipPlugin          = 1
vim.g.loaded_zip                = 1
vim.g.loaded_netrwPlugin        = 1
vim.g.loaded_netrw              = 1
vim.g.loaded_vimballPlugin      = 1
vim.g.loaded_vimball            = 1
vim.g.loaded_2html_plugin       = 1
vim.g.loaded_man                = 1
vim.g.loaded_matchit            = 1
vim.g.loaded_remote_plugins     = 1
vim.g.loaded_shada_plugin       = 1
vim.g.loaded_spellfile_plugin   = 1
vim.g.loaded_tutor_mode_plugin  = 1
vim.g.skip_loading_mswin        = 1
vim.g.loaded_matchparen         = 0

vim.g.mapleader = " "

local set = vim.o

set.cursorline = true
set.cursorcolumn = true

set.mouse = "nvr"

set.wrap = false

set.wrapscan = true

set.whichwrap = "b,s,h,l,[,],<,>,~"

local tabwidth = 8
set.tabstop = tabwidth
set.softtabstop = tabwidth
set.shiftwidth = tabwidth
set.expandtab = true
set.shiftround = true
set.autoindent = true
set.smartindent = true
set.smarttab = true
vim.g.vim_indent_cont = tabwidth

set.fileencoding = "utf-8"
set.fileencodings = "utf-8,cp932,euc-jp,ucs-boms"
set.fileformats = "unix,dos,mac"

set.ambiwidth = "single"
set.emoji = true

set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = true

set.termguicolors = true

set.pumblend = 15
set.pumheight = 30
set.pumwidth = 10
set.winblend = 15

set.hidden = true

set.splitright = true
set.splitbelow = true

set.clipboard = "unnamedplus," .. set.clipboard

set.list = true
set.listchars = "eol:↴,tab:  "

set.signcolumn = "no"
set.laststatus = 0
set.showtabline = 0
set.showcmd = false
set.showmode = false
set.cmdheight = 0
set.desplay = "lastline"
set.shortmess = "aTcF"
set.ruler = true

set.lazyredraw = true
set.ttyfast = true

set.history = 2000

set.matchpairs = set.matchpairs .. ",<:>"
set.showmatch = false

set.sidescroll = 1
set.sidescrolloff = 16
set.scrolloff = math.floor(set.lines / 6)

set.modeline = false
set.modelines = 0

set.helplang = "ja"

set.updatetime = 750
set.updatecount = 50
