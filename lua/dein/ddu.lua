local fn = vim.fn;
local api = vim.api;
local cmd = vim.cmd;

local ddu = {
        patch_global = fn['ddu#custom#patch_global'];
        start = fn['ddu#start'];
}


ddu.patch_global({
        ui = 'std';
        uiParams = {
                displaySourceName = 'long';
--               filterSplitDirection = 'floating';
--               split = 'floating';
--               previewFloating = true;
--               winCol = 50;
--               winRow = 50;
        };
        kindOptions = {
                _ = {
                        matchers = {'matcher_fzf'};
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
                        matchers = {'matcher_fzf'};
                };
        };
})


api.nvim_set_keymap('n','<Leader>d','<Cmd>Ddu file_rec<CR>',{noremap = true});
--api.nvim_set_keymap('n','/',[[&filetype == 'ddu-std' ? '<Cmd>call ddu#ui#std#do_action("openFilterWindow")<CR>' : '/']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','q',[[&filetype == 'ddu-std' ? '<Cmd>call ddu#ui#std#do_action("quit")<CR>' : '<CR>']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','<CR>',[[&filetype == 'ddu-std' ? '<Cmd>call ddu#ui#std#do_action("itemAction")<CR>' : '<CR>']],{noremap = true,expr = true});
--api.nvim_set_keymap('n','<Space>',[[&filetype == 'ddu-std' ? '<Cmd>call ddu#ui#std#do_action("toggleSelectItem")<CR>' : '<CR>']],{noremap = true,expr = true});
cmd([[
autocmd FileType ddu-std nnoremap <buffer> / <Cmd>call ddu#ui#std#do_action("openFilterWindow")<CR>
autocmd FileType ddu-std nnoremap <buffer> q <Cmd>call ddu#ui#std#do_action("quit")<CR>
autocmd FileType ddu-std nnoremap <buffer> <CR> <Cmd>call ddu#ui#std#do_action("itemAction")<CR>
autocmd FileType ddu-std nnoremap <buffer><nowait> <Space> <Cmd>call ddu#ui#std#do_action("toggleSelectItem")<CR>

autocmd FileType ddu-std-filter inoremap <buffer> <CR> <Esc><Cmd>close<CR>
autocmd FileType ddu-std-filter nnoremap <buffer> <CR> <Cmd>close<CR>
]]);
