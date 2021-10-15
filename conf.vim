au ColorScheme * hi Normal guibg=none
au ColorScheme * hi NonText ctermbg=NONE guibg=NONE
au ColorScheme * hi SpecialKey ctermbg=NONE guibg=NONE
au ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE

command! OjTest !oj t -N -d tests
command! Compile !g++ %
command! Submit !acc submit
command! Apply runtime init.vim
