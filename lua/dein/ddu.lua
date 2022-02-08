local fn = vim.fn;
local api = vim.api;
local cmd = vim.cmd;
local o = vim.o

local ddu = {
        patch_global = fn['ddu#custom#patch_global'];
        start = fn['ddu#start'];
}

ddu.patch_global({
        ui = 'ff';
        uiParams = {
                ff = {
                        filterSplitDirection = 'floating';
                        split = 'floating';
                        winWidth = math.floor(o.columns*0.70710678);
                        winHeight = math.floor(o.lines*0.70710678);
                        winCol = math.floor((o.columns-o.columns*0.70710678)/2);
                        winRow = math.floor((o.lines-o.lines*0.70710678)/2);
                }
        };
        kindOptions = {
                _ = {
                        matchers = {'matcher_substring','matcher_fzf',};
                };
                file = {
                        defaultAction = 'open';
                };
                word = {
                        defaultAction = 'append';
                };
        };
        sourceOptions = {
                _ = {
                        matchers = {'matcher_substring','matcher_fzf',};
                };
        };
})


--_G.ddu_set_window_config = function ()
--        api.nvim_win_set_config(0,{border = 'rounded'});
--end


api.nvim_set_keymap('n','<Leader>d','<Cmd>Ddu file_rec<CR>',{noremap = true});
--api.nvim_set_keymap('n','/',[[&filetype == 'ddu-ff' ? '<Cmd>call ddu#ui#ff#do_action("openFilterWindow")<CR>' : '/']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','q',[[&filetype == 'ddu-ff' ? '<Cmd>call ddu#ui#ff#do_action("quit")<CR>' : '<CR>']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','<CR>',[[&filetype == 'ddu-ff' ? '<Cmd>call ddu#ui#ff#do_action("itemAction")<CR>' : '<CR>']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','<Space>',[[&filetype == 'ddu-ff' ? '<Cmd>call ddu#ui#ff#do_action("toggleSelectItem")<CR>' : '<CR>']],{noremap = true,expr = true});
cmd([[
autocmd BufWinEnter ddu-ff-default call nvim_win_set_config(0,{'border' : 'rounded'})

autocmd FileType ddu-ff nnoremap <buffer> / <Cmd>call ddu#ui#ff#do_action("openFilterWindow")<CR><Cmd>setlocal winblend=0<CR>
autocmd FileType ddu-ff nnoremap <buffer> q <Cmd>call ddu#ui#ff#do_action("quit")<CR>
autocmd FileType ddu-ff nnoremap <buffer> <CR> <Cmd>call ddu#ui#ff#do_action("itemAction")<CR>
autocmd FileType ddu-ff nnoremap <buffer> p <Cmd>call ddu#ui#ff#do_action("preview")<CR>
autocmd FileType ddu-ff nnoremap <buffer><nowait> <Space> <Cmd>call ddu#ui#ff#do_action("toggleSelectItem")<CR>

autocmd BufWinEnter ddu-ff-filter lua vim.api.nvim_win_set_config(0,{border = 'rounded'});
autocmd FileType ddu-ff-filter inoremap <buffer> <CR> <Esc><Cmd>close<CR>
autocmd FileType ddu-ff-filter nnoremap <buffer> <CR> <Cmd>close<CR>
]]);
