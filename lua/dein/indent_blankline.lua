vim.cmd([[
autocmd ColorScheme * highlight IndentLineRed    guifg=#960000 ctermfg=88  gui=nocombine
autocmd ColorScheme * highlight IndentLineOrange guifg=#964800 ctermfg=94  gui=nocombine
autocmd ColorScheme * highlight IndentLineYellow guifg=#969600 ctermfg=100 gui=nocombine
autocmd ColorScheme * highlight IndentLineGreen  guifg=#009600 ctermfg=106 gui=nocombine
autocmd ColorScheme * highlight IndentLineAqua   guifg=#009696 ctermfg=74  gui=nocombine
autocmd ColorScheme * highlight IndentLineBLue   guifg=#004896 ctermfg=56  gui=nocombine
autocmd ColorScheme * highlight IndentLinePurple guifg=#000096 ctermfg=54  gui=nocombine
autocmd ColorScheme * highlight SpaceCharRed    guifg=#B80808 ctermfg=88  gui=nocombine
autocmd ColorScheme * highlight SpaceCharOrange guifg=#B86408 ctermfg=94  gui=nocombine
autocmd ColorScheme * highlight SpaceCharYellow guifg=#B8B808 ctermfg=100 gui=nocombine
autocmd ColorScheme * highlight SpaceCharGreen  guifg=#08B808 ctermfg=106 gui=nocombine
autocmd ColorScheme * highlight SpaceCharAqua   guifg=#08B8B8 ctermfg=74  gui=nocombine
autocmd ColorScheme * highlight SpaceCharBLue   guifg=#08B8B8 ctermfg=56  gui=nocombine
autocmd ColorScheme * highlight SpaceCharPurple guifg=#0808B8 ctermfg=54  gui=nocombine

autocmd CursorMoved * IndentBlanklineRefresh
autocmd CursorMovedI * IndentBlanklineRefresh
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
        using_treesitter = true,
        show_trailing_blankline_indent = false,
        filetype_exclude = {'help'},
        buftype_exclude = {'terminal'},
});
