vim.cmd [[autocmd conf ColorScheme * hi char1 guifg=#960000 ctermfg=88  gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char2 guifg=#964800 ctermfg=94  gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char3 guifg=#969600 ctermfg=100 gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char4 guifg=#009600 ctermfg=106 gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char5 guifg=#009696 ctermfg=74  gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char6 guifg=#000096 ctermfg=56  gui=nocombine]]
vim.cmd [[autocmd conf ColorScheme * hi char7 guifg=#960096 ctermfg=54  gui=nocombine]]

--vim.cmd [[au conf ColorScheme * hi blank1 guifg=#640000 ctermfg=124  gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank2 guifg=#643200 ctermfg=130  gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank3 guifg=#646400 ctermfg=136 gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank4 guifg=#006400 ctermfg=82 gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank5 guifg=#006464 ctermfg=86  gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank6 guifg=#000064 ctermfg=68  gui=nocombine]]
--vim.cmd [[au conf ColorScheme * hi blank7 guifg=#640064 ctermfg=90  gui=nocombine]]

        --max_indent_increase = 1,
        --use_treesitter = true,
        --show_current_context = true,
        --[[context_highlight_list = {
                "context1",
                "context2",
                "context3",
                "context4",
                "context5",
                "context6",
                "context7",
        }]]

require("indent_blankline").setup {
        -- char = '>', -- the character to be used as indent line.
        --space_char = 'c',
        char_highlight_list = {
                "char1",
                "char2",
                "char3",
                "char4",
                "char5",
                "char6",
                "char7",
        },
        --[[ char_blankline_highlight_list = {
                "blank1",
                "blank2",
                "blank3",
                "blank4",
                "blank5",
                "blank6",
                "blank7",
        }, ]]
        filetype_exclude = {'help'},
        buftype_exclude = {'terminal'},
}

