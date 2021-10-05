call ddc#custom#patch_global('completionMode','inline')

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank']},
        \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
        \ 'around': {'mark': 'A'},
        \ })
call ddc#custom#patch_global('sourceParams', {
        \ 'around': {'maxSize': 500},
        \ })

call ddc#custom#patch_global('sources', ['nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
        \ 'nvim-lsp': {
        \   'mark': 'lsp',
        \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
        \ })
" Use Customized labels
call ddc#custom#patch_global('sourceParams', {
        \ 'nvim-lsp': { 'kindLabels': { 'Class': 'c' } },
        \ })

call ddc#custom#patch_global('sources', ['skkeleton'])
call ddc#custom#patch_global('sourceOptions', {
        \   'skkeleton': {
        \     'mark': 'skkeleton',
        \     'matchers': ['skkeleton'],
        \     'sorters': []
        \   },
        \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()
