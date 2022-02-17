local fn = vim.fn;
local cmd = vim.cmd;
local api = vim.api;

local ddc = {
        patch_global = fn['ddc#custom#patch_global'];
        patch_filetype = fn['ddc#custom#patch_filetype'];
}

ddc.patch_global('sources',{'file','around'});
ddc.patch_filetype({'vim'},'sources',{'nvim-lsp','necovim','file','cmdline-history','around'});
ddc.patch_filetype({'lua','cpp','typescript'},'sources',{'nvim-lsp','file','around'});
ddc.patch_filetype({'glsl'},'sources',{'around'});

ddc.patch_global('sourceOptions',{
        _ = {
                matchers = {'matcher_fuzzy','matcher_length'};
                sorters = {'sorter_fuzzy','sorter_rank'};
                converters = {'converter_fuzzy','converter_remove_overlap'};
        };
        around = {
                mark = 'A';
        };
        line = {
                mark = 'line';
        };
        skkeleton = {
                mark = 'skk';
                matchers = {'skkeleton'};
                sorters = {};
        };
        file = {
                mark = 'F';
                isVolatile = true;
                minAutoCompleteLength = 1000;
                forceCompletionPattern = [[\S/\S*]];
        };
        ['cmdline-history'] = {
                mark = 'history';
        };
});

ddc.patch_global('filterParams',{
        matcher_fuzzy = {
                splitMode = 'character';
        };
        converter_fuzzy = {
                hlGroup = 'UnderLine';
        };
});

ddc.patch_global('autoCompleteEvents',{
        'InsertEnter','TextChangedI','TextChangedP','CmdlineEnter','CmdlineChanged'
});

ddc.patch_global('backspaceCompletion',true);
ddc.patch_global('completionMenu','pum.vim');

local prev_cmdbuffer_config;
function _G.ddc_commandline_pre ()
        prev_cmdbuffer_config = fn['ddc#custom#get_buffer']();
        fn['ddc#custom#patch_buffer']('sources',{'necovim','file','cmdline-history','around'});
        cmd('autocmd CmdlineLeave * ++once call v:lua.ddc_commandline_post()');
        fn['ddc#enable_cmdline_completion']();
end
function _G.ddc_commandline_post ()
        fn['ddc#custom#set_buffer'](prev_cmdbuffer_config);
end

local prev_skkbuffer_config;
function _G.ddc_skkeleton_pre ()
        prev_skkbuffer_config = fn['ddc#custom#get_buffer']();
        fn['ddc#custom#patch_buffer']('sources',{'skkeleton'});
end
function _G.ddc_skkeleton_post ()
        fn['ddc#custom#set_buffer'](prev_skkbuffer_config);
end
cmd('autocmd User skkeleton-enable-pre call v:lua.ddc_skkeleton_pre()');
cmd('autocmd User skkeleton-disenable-pre call v:lua.ddc_skkeleton_post()');


api.nvim_set_keymap('i','<TAB>',[[pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ? '<TAB>' : ddc#manual_complete()]],{noremap = true,expr = true});
api.nvim_set_keymap('!','<S-TAB>','<Cmd>call pum#map#insert_relative(-1)<CR>',{noremap = true});
api.nvim_set_keymap('c','<TAB>',[[pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#manual_complete()]],{noremap = true,expr = true});
api.nvim_set_keymap('n',':','<Cmd>call v:lua.ddc_commandline_pre()<CR>:',{noremap = true});

fn['ddc#enable']();
