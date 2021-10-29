augroup conf 
        autocmd!
augroup END

" 大事な大事な背景を透明にしちゃうわぜ…"
autocmd conf ColorScheme * hi Normal guibg=none
autocmd conf ColorScheme * hi NonText ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * hi SpecialKey ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE

" Markdown のファイルが開かれたら、set wrap する"
autocmd conf FileType markdown set wrap

" Leader キーにスペースを割り当てる"
let mapleader = "\<Space>"

" set wrap されてても見ため通りに動く"
nnoremap <silent>j gj
nnoremap <silent>k gk

" jj でノーマルモードに戻っちゃうんだぜ！"
inoremap <silent> jj <esc> 
#vnoremap <silent> jj <esc> 

" ターミナルで Esc キー二度押しでノーマルモード！"
tnoremap <silent><Esc><Esc> <C-\><C-N>

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" For 競プロ"
command! OjTest belowright new term:// oj t -N -d tests
command! Compile belowright new term:// g++ %
command! Submit belowright new term:// acc submit
command! Apply runtime init.vim
