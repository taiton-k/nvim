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

" Markdown のファイルが開かれたら、set wrap する"
autocmd conf FileType markdown setlocal wrap

" Markdown ファイルのハイライトの設定"
autocmd conf FileType markdown highlight link markdownCodeDelimiter Comment
autocmd conf FileType markdown highlight link markdownCodeBlock String
autocmd conf FileType markdown highlight link markdownCode String

" Leader キーにスペースを割り当てる"
"let g:mapleader = "\<Space>"

" 全選択"
nnoremap <silent> <Leader>a ggVG



" set wrap されてても見ため通りに動く"
nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> <Leader>w <Cmd>update<CR>
nnoremap <silent> <Leader>W <Cmd>write<CR>

imap <silent> <C-h> <BS>

" jj でノーマルモードに戻っちゃうんだぜ！"
"inoremap <silent> jj <esc> 
"vnoremap <silent> jj <esc> 


let s:TerminalWindowAlreadyOpened = v:false
let s:TerminalBufferAlreadyExist = v:false
let s:TerminalWinID = -1
let s:TerminalBufnumber = -1

function! s:TerminalOpen() abort
        let s:TerminalBufferAlreadyExist = bufexists(s:TerminalBufnumber)
        botright split
        if s:TerminalBufferAlreadyExist == v:true
                execute 'buffer ' . s:TerminalBufnumber
        else
                "execute 'edit term://' . exepath('fish')
                terminal
        endif
        resize 15
        let s:TerminalWinID = win_getid()
        let s:TerminalBufnumber = bufnr()
        let s:TerminalWindowAlreadyOpened = v:true
        let s:TerminalBufferAlreadyExist = v:true
endfunction

function! s:TerminalClose() abort
        call win_execute(s:TerminalWinID,'close')
        let s:TerminalWindowAlreadyOpened = v:false
endfunction

function! s:TerminalToggle() abort
        if s:TerminalWindowAlreadyOpened == v:true
                call s:TerminalClose()
        else
                call s:TerminalOpen()
        endif
endfunction

" ターミナルを開いたとき、自動でインサートモードにする"
autocmd conf TermOpen * startinsert
autocmd BufEnter * if &buftype == 'terminal' | startinsert

" ターミナルの背景を透明にする"
autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE

" ターミナルが開かれたら、set nonumber する"
autocmd conf TermOpen * setlocal nonumber

" T でターミナルを開く"
command! T call s:TerminalToggle()

" ターミナルで Esc キー二度押しでノーマルモード！"
tnoremap <silent><Esc><Esc> <C-\><C-N>

" <C-t> でターミナルを開く"
nnoremap <silent><C-t> <Cmd>T<CR>
tnoremap <silent><C-t> <Cmd>T<CR>


" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

inoremap <C-@> <Nop>

" For 競プロ"
command! OjTest belowright new term:// oj t -N -d tests
command! Compile !g++ -Wall -Wextra -O0 %
command! Submit belowright new term:// acc submit
command! Apply runtime init.vim

command! -nargs=* H vert help <args>

" For OpenGL Programming
command! -nargs=* Make !make <args>
command! Execute !./a.out


" 実験"
"autocmd conf InsertEnter * echomsg "InsertEnter"
"autocmd conf InsertChange echomsg "InsertChange"
"autocmd conf InsertEnter * normal <CR>a

autocmd conf BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp,*.vs,*.fs, setlocal filetype=glsl

