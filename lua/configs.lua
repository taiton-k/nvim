local cmd = vim.cmd;
local api = vim.api;
local fn = vim.fn;

cmd([[
augroup conf
        autocmd!
augroup END
]]);

cmd([[
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=none
autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight SpecialKey ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight CursorLine ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight Folded ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight! link FloatBorder VertSplit
autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight Pmenu ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight LocalFloating guibg=NONE
autocmd ColorScheme * highlight LocalSelected guibg=NONE guifg=#A3BE8C

autocmd InsertEnter * highlight ModeMsg gui=bold guifg=#A3BE8C
autocmd InsertLeave * highlight ModeMsg gui=bold guifg=#88C0D0

"for jumpcursor.vim"
autocmd ColorScheme * highlight! link ErrorMsg Todo

autocmd TermOpen * startinsert
autocmd BufEnter * if &buftype == 'terminal' | startinsert

" Enable nim-lang"
autocmd FileType nim setlocal tabstop=8 shiftwidth=8 softtabstop=8
]]);

local function nkey (lhs,rhs,opts)
        api.nvim_set_keymap('n',lhs,rhs,opts);
end
local function ikey (lhs,rhs,opts)
        api.nvim_set_keymap('i',lhs,rhs,opts);
end
local function tkey (lhs,rhs,opts)
        api.nvim_set_keymap('t',lhs,rhs,opts);
end

nkey('<Leader>a','ggVG',{noremap = true});
nkey('j','gj',{noremap = true});
nkey('k','gk',{noremap = true});
nkey('<Leader>w','<Cmd>update<CR>',{noremap = true});
nkey('<Leader>W','<Cmd>write<CR>',{noremap = true});
ikey('<C-Space>','<C-[>',{noremap = true});
nkey('<Esc><Esc>','<Cmd>set nohlsearch!<CR>',{noremap = true});
tkey('<Esc><Esc>',[[<C-\><C-N>]],{noremap = true});

api.nvim_add_user_command('H','vert help <args>',{nargs = '*',complete = 'help'});
api.nvim_add_user_command('OjTest','FlTermRun oj t -N -d tests',{});
api.nvim_add_user_command('Compile','!g++ -Wall -Wextra -O0 <args> %',{nargs = '*'});
api.nvim_add_user_command('Execute','!./a.out',{});
api.nvim_add_user_command('Submit','FlTermRun acc submit',{});
api.nvim_add_user_command('Acc','FlTermRun acc <args>',{nargs = '*'});


-- Emacs Keybinds
-- For completion plugin (ddc.vim)
ikey('<C-b>','<Esc>i',{noremap = true});
ikey('<C-f>','<Esc>la',{noremap = true});
ikey('<C-p>','<Esc>gja',{noremap = true});
ikey('<C-n>','<Esc>gka',{noremap = true});

ikey('<C-a>','<Esc>_i',{noremap = true});
ikey('<C-e>','<Esc>$a',{noremap = true});



-- Making Colorscheme

function _G.SynGroup()
        local s = fn.synID(fn.line('.'), fn.col('.'), 1);
        print(fn.synIDattr(s, 'name') .. ' -> ' .. fn.synIDattr(fn.synIDtrans(s), 'name'));
end
nkey('<Leader>r','<Cmd>lua SynGroup()<CR>',{noremap = true});
