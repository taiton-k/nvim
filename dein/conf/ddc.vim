"call ddc#custom#patch_global('completionMode','inline')
call ddc#custom#patch_global('backspaceCompletion', v:true)
call ddc#custom#patch_global('completionMenu', 'native')

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around','skkeleton','file'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
                \ 'matchers': ['matcher_head'],
                \ 'sorters': ['sorter_rank'],
                \},
        \ 'around': {'mark': 'A'},
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
                \ }
        \ })

call ddc#custom#patch_filetype(['cpp','vim','lua'],'sources',['around','nvim-lsp','skkeleton'])

"

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()
