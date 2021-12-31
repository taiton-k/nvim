" Shougo/ddc-around
" Shougo/ddc-nvim-lsp :LSPをddcでも使えるようにしてくれる
" LumaKernel/ddc-file :ファイルの補完
" vim-skk/denops-skkeleton.vim :SKKをddcでも使えるようにしてくれる
call ddc#custom#patch_global('sources', ['around','file'])

call ddc#custom#patch_filetype(['vim'],'sources',['nvim-lsp','necovim','file','around'])
call ddc#custom#patch_filetype(['lua','cpp','typescript'],'sources',['nvim-lsp','around','file'])
call ddc#custom#patch_filetype(['glsl'],'sources',['around'])


" Use matcher_head and sorter_rank.
" Shougo/ddc-matcher_head
" Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
                \ 'matchers': ['matcher_fuzzy'],
                \ 'sorters': ['sorter_fuzzy'],
                \ 'converters': ['converter_fuzzy','converter_remove_overlap'],
                \},
        \ 'around': {
                \ 'mark': 'A',
                \ },
        \
        \ 'nvim-lsp': {
                \ 'mark': 'lsp',
                \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*'
                \},
        \
        \ 'skkeleton': {
                \ 'mark': 'skk',
                \ 'matchers': ['skkeleton'],
                \ 'sorters': []
                \ },
        \ 'file': {
                \ 'mark': 'F',
                \ 'isVolatile': v:true,
                \ 'minAutoCompleteLength': 1000,
                \ 'forceCompletionPattern': '\S/\S*'
                \ },
        \ 'cmdline-history': {'mark': 'history'},
        \ })

call ddc#custom#patch_global('filterParams',{
        \'maatcher_fuzzy':{
                \'splitMode':'character',
                \},
        \'converter_fuzzy':{
                \'hlGroup':'UnderLined',
                \},
        \})

" 補完が発火するタイミング
call ddc#custom#patch_global('autoCompleteEvents', [
        \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
        \ 'CmdlineEnter', 'CmdlineChanged',
        \ ])

" バックスペースキーを押しても補完がでるようにする
call ddc#custom#patch_global('backspaceCompletion', v:true)

" 補完ウィンドウをpum.vimのにする
call ddc#custom#patch_global('completionMenu', 'pum.vim')


        " Use ddc.
        call ddc#enable()

" Mappings

" <TAB>: completion for pum.vim.
inoremap <silent><expr> <TAB>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<TAB>' : ddc#manual_complete()

" <TAB>: completion for ddc native popup.
"inoremap <silent><expr> <TAB>
"\ pumvisible() ? '<C-n>' :
"\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back for pum.vim.
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
"
" <S-TAB>: completion back for ddc native popup.
"inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'


" Skkleleton が有効なときのみ Skkleleton のソースを有効にする"
autocmd! conf User skkeleton-enable-pre call s:skkeleton_pre()
function! s:skkeleton_pre() abort
        " Overwrite sources
        let s:prev_buffer_config = ddc#custom#get_buffer()
        call ddc#custom#patch_buffer('sources', ['skkeleton'])
endfunction
autocmd! conf User skkeleton-disable-pre call s:skkeleton_post()
function! s:skkeleton_post() abort
        " Restore sources
        call ddc#custom#set_buffer(s:prev_buffer_config)
endfunction






