vim.cmd([[
autocmd ColorScheme * highlight IndentLineRed    guifg=#960000 ctermfg=88  gui=nocombine
autocmd ColorScheme * highlight IndentLineOrange guifg=#964800 ctermfg=94  gui=nocombine
autocmd ColorScheme * highlight IndentLineYellow guifg=#969600 ctermfg=100 gui=nocombine
autocmd ColorScheme * highlight IndentLineGreen  guifg=#009600 ctermfg=106 gui=nocombine
autocmd ColorScheme * highlight IndentLineAqua   guifg=#009696 ctermfg=74  gui=nocombine
autocmd ColorScheme * highlight IndentLineBLue   guifg=#004896 ctermfg=56  gui=nocombine
autocmd ColorScheme * highlight IndentLinePurple guifg=#000096 ctermfg=54  gui=nocombine
autocmd ColorScheme * highlight SpaceCharRed    guifg=#B83232 ctermfg=88  gui=nocombine
autocmd ColorScheme * highlight SpaceCharOrange guifg=#B86432 ctermfg=94  gui=nocombine
autocmd ColorScheme * highlight SpaceCharYellow guifg=#B8B832 ctermfg=100 gui=nocombine
autocmd ColorScheme * highlight SpaceCharGreen  guifg=#32B832 ctermfg=106 gui=nocombine
autocmd ColorScheme * highlight SpaceCharAqua   guifg=#32B8B8 ctermfg=74  gui=nocombine
autocmd ColorScheme * highlight SpaceCharBLue   guifg=#32B8B8 ctermfg=56  gui=nocombine
autocmd ColorScheme * highlight SpaceCharPurple guifg=#3232B8 ctermfg=54  gui=nocombine
]])

require('indent_blankline').setup({
        char_highlight_list = {
                'IndentLineRed',
                'IndentLineOrange',
                'IndentLineYellow',
                'IndentLineGreen',
                'IndentLineAqua',
                'IndentLineBLue',
                'IndentLinePurple',
        };
        space_char_highlight_list = {
                'SpaceCharRed',
                'SpaceCharOrange',
                'SpaceCharYellow',
                'SpaceCharGreen',
                'SpaceCharAqua',
                'SpaceCharBLue',
                'SpaceCharPurple',
        };
        use_treesitter = true;
        filetype_exclude = {'help'},
        buftype_exclude = {'terminal'},
});
