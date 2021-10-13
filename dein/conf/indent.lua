--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent1 ctermfg=88 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent2 ctermfg=94 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent3 ctermfg=100 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent4 ctermfg=106 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent5 ctermfg=74 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent6 ctermfg=56 cterm=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent7 ctermfg=54 cterm=nocombine]]

--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[au ColorScheme * hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.cmd [[au ColorScheme * hi char1 guifg=#640000 ctermfg=88  gui=nocombine]]
vim.cmd [[au ColorScheme * hi char2 guifg=#643200 ctermfg=94  gui=nocombine]]
vim.cmd [[au ColorScheme * hi char3 guifg=#646400 ctermfg=100 gui=nocombine]]
vim.cmd [[au ColorScheme * hi char4 guifg=#006400 ctermfg=106 gui=nocombine]]
vim.cmd [[au ColorScheme * hi char5 guifg=#006464 ctermfg=74  gui=nocombine]]
vim.cmd [[au ColorScheme * hi char6 guifg=#000064 ctermfg=56  gui=nocombine]]
vim.cmd [[au ColorScheme * hi char7 guifg=#640064 ctermfg=54  gui=nocombine]]

vim.cmd [[au ColorScheme * hi context1 guifg=#963232 ctermfg=124  gui=nocombine]]
vim.cmd [[au ColorScheme * hi context2 guifg=#966432 ctermfg=130  gui=nocombine]]
vim.cmd [[au ColorScheme * hi context3 guifg=#969632 ctermfg=136 gui=nocombine]]
vim.cmd [[au ColorScheme * hi context4 guifg=#329632 ctermfg=82 gui=nocombine]]
vim.cmd [[au ColorScheme * hi context5 guifg=#329696 ctermfg=86  gui=nocombine]]
vim.cmd [[au ColorScheme * hi context6 guifg=#323296 ctermfg=68  gui=nocombine]]
vim.cmd [[au ColorScheme * hi context7 guifg=#963296 ctermfg=90  gui=nocombine]]

require("indent_blankline").setup {
        char_highlight_list = {
                "char1",
                "char2",
                "char3",
                "char4",
                "char5",
                "char6",
                "char7",
        },
        indent_level = 20,
        max_indent_increase = 1,
        --filetype_exclude = 'help',
        --buftype_exclude = 'terminal',
        --show_current_context = true,
        --[[context_highlight_list = {
                "context1",
                "context2",
                "context3",
                "context4",
                "context5",
                "context6",
                "context7",
        } ]]
}

