augroup conf 
        autocmd!
augroup END
"autocmd conf ColorScheme * hi Normal guibg=none
"autocmd conf ColorScheme * hi NonText ctermbg=NONE guibg=NONE
"autocmd conf ColorScheme * hi SpecialKey ctermbg=NONE guibg=NONE
"autocmd conf ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE

command! OjTest !oj t -N -d tests
command! Compile !g++ %
command! Submit !acc submit
command! Apply runtime init.vim
