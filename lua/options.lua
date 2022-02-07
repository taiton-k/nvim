local g = vim.g;
local o = vim.o;

g.did_install_default_menus = 1;
g.did_install_syntax_menu   = 1;
g.did_indent_on             = 1;
g.did_load_filetypes        = 1;
g.did_load_ftplugin         = 1;
g.loaded_gzip               = 1;
g.loaded_tarPlugin          = 1;
g.loaded_tar                = 1;
g.loaded_zipPlugin          = 1;
g.loaded_zip                = 1;
--g.loaded_matchparen         = 1;
g.loaded_netrwPlugin        = 1;
g.loaded_netrw              = 1;
g.loaded_vimballPlugin      = 1;
g.loaded_vimball            = 1;
g.loaded_2html_plugin       = 1;
g.loaded_man                = 1;
g.loaded_matchit            = 1;
g.loaded_remote_plugins     = 1;
g.loaded_shada_plugin       = 1;
g.loaded_spellfile_plugin   = 1;
g.loaded_tutor_mode_plugin  = 1;
g.skip_loading_mswin        = 1;

g.mapleader = [[ ]];

o.mouse = 'nv';
o.wrap = false;
o.wrapscan = true;
o.whichwrap = 'b,s,h,l,[,],<,>,~';

local tab_width = 8;
o.tabstop = tab_width;
o.shiftwidth = tab_width;
o.softtabstop = tab_width;
o.expandtab = true;
o.shiftround = true;
o.autoindent = true;
o.smarttab = true;
o.smartindent = true;

g.vim_indent_cont = vim.fn.shiftwidth();

o.fileencoding = 'utf-8';
o.fileencodings = 'utf-8,cp932,euc-jp,ucs-boms';
o.fileformats = 'unix,dos,mac';

o.ambiwidth = 'single';

o.incsearch = true;
o.ignorecase = true;
o.smartcase = true;
o.hlsearch = true;

o.termguicolors = true;

o.pumblend = 25;
o.pumheight = 30;
o.pumwidth = 10;

o.winblend = 5;

o.hidden = true;

o.splitright = true;
o.splitbelow = true;

o.clipboard = 'unnamedplus,' .. o.clipboard;

o.list = true;
o.listchars = 'eol:↴'
--'eol:⋅';
--;space:↴';

o.signcolumn = 'no';
o.laststatus = 0;
o.showtabline = 0;
o.showcmd = false;
o.showmode = false;
o.display = 'lastline';
o.shortmess = 'aTcF';
o.ruler = true;

o.lazyredraw = true;
o.ttyfast = true;

o.history = 2000;

o.matchpairs = o.matchpairs .. [[,<:>,':',":"]];
o.showmatch = true;
o.matchtime = 1;

o.sidescroll = 1;
o.sidescrolloff = 8;
o.scrolloff = 16;

o.modeline = false;
o.modelines = 0;

o.helplang='ja';
