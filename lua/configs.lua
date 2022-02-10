local cmd = vim.cmd;
local api = vim.api;

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

autocmd InsertEnter * highlight ModeMsg gui=bold guifg=#A3BE8C
autocmd InsertLeave * highlight ModeMsg gui=bold guifg=#88C0D0

"for jumpcursor.vim"
autocmd ColorScheme * highlight! link ErrorMsg Todo

autocmd TermOpen * startinsert
autocmd BufEnter * if &buftype == 'terminal' | startinsert
]]);

api.nvim_set_keymap('n','<Leader>a','ggVG',{noremap = true});
api.nvim_set_keymap('n','j','gj',{noremap = true});
api.nvim_set_keymap('n','k','gk',{noremap = true});
api.nvim_set_keymap('n','<Leader>w','<Cmd>update<CR>',{noremap = true});
api.nvim_set_keymap('n','<Leader>W','<Cmd>write<CR>',{noremap = true});
api.nvim_set_keymap('i','<C-Space>','<C-[>',{noremap = true});
api.nvim_set_keymap('n','<Esc><Esc>','<Cmd>set nohlsearch!<CR>',{noremap = true});
api.nvim_set_keymap('t','<Esc><Esc>',[[<C-\><C-N>]],{noremap = true});

api.nvim_add_user_command('H','vert help <args>',{nargs = '*',complete = 'help'});
api.nvim_add_user_command('OjTest','FlTermRun oj t -N -d tests',{});
api.nvim_add_user_command('Compile','!g++ -Wall -Wextra -O0 %',{});
api.nvim_add_user_command('Submit','FlTermRun acc submit',{});
api.nvim_add_user_command('Acc','FlTermRun acc <args>',{nargs = '*'});
