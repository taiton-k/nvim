augroup conf 
        autocmd!
augroup END

" 大事な大事な背景を透明にしちゃうわぜ…"
autocmd conf ColorScheme * highlight Normal ctermbg=NONE guibg=none
autocmd conf ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight SpecialKey ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight CursorLine ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight Folded ctermbg=NONE guibg=NONE
autocmd conf ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

" Markdown のファイルが開かれたら、set wrap する"
autocmd conf FileType markdown set wrap

" Markdown ファイルのハイライトの設定"
autocmd conf FileType markdown highlight link markdownCodeDelimiter Comment
autocmd conf FileType markdown highlight link markdownCodeBlock String
autocmd conf FileType markdown highlight link markdownCode String

" Leader キーにスペースを割り当てる"
let mapleader = "\<Space>"

" 全選択"
nnoremap <silent><Leader>a ggVG



" set wrap されてても見ため通りに動く"
nnoremap <silent>j gj
nnoremap <silent>k gk

" jj でノーマルモードに戻っちゃうんだぜ！"
"inoremap <silent> jj <esc> 
"vnoremap <silent> jj <esc> 


" ターミナルで Esc キー二度押しでノーマルモード！"
tnoremap <silent><Esc><Esc> <C-\><C-N>

" <Leader>t でターミナルを開く"
nnoremap <silent><Leader>t <Cmd>T<CR>


" ターミナルを開いたとき、自動でインサートモードにする"
"autocmd conf TermOpen * startinsert
autocmd BufEnter * if &buftype == 'terminal' | startinsert

" ターミナルが開かれたら、set nonumber する"
autocmd conf TermOpen * set nonumber

" T でターミナルを開く"
command! T belowright new term://fish

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" For 競プロ"
command! OjTest belowright new term:// oj t -N -d tests
command! Compile !g++ -Wall -Wextra -Werror %
command! Submit belowright new term:// acc submit
command! Apply runtime init.vim
