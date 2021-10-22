" コマンドライン補完"
nnoremap :       <Cmd>call CommandlinePre()<CR>:

" 色々マッピング"
cnoremap <silent><expr> <Tab>
\ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
\ ddc#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

function! CommandlinePre() abort


        " ddc.vim を"
        call dein#source('ddc.vim')

        " Overwrite sources
        let s:prev_buffer_config = ddc#custom#get_buffer()
        call ddc#custom#patch_buffer('sources', ['cmdline-history','necovim', 'around'])

        autocmd conf CmdlineLeave * ++once call CommandlinePost()

        " Enable command line completion
        call ddc#enable_cmdline_completion()
        call ddc#enable()
endfunction
function! CommandlinePost() abort
        " Restore sources
        call ddc#custom#set_buffer(s:prev_buffer_config)
endfunction
