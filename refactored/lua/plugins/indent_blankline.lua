vim.api.nvim_create_autocmd(
        'ColorScheme',
        {
                pattern = '*',
                callback = function ()
                        vim.cmd('highlight IndentLineRed    guifg=#960000')
                        vim.cmd('highlight IndentLineOrange guifg=#964800')
                        vim.cmd('highlight IndentLineYellow guifg=#969600')
                        vim.cmd('highlight IndentLineGreen  guifg=#009600')
                        vim.cmd('highlight IndentLineAqua   guifg=#009696')
                        vim.cmd('highlight IndentLineBLue   guifg=#004896')
                        vim.cmd('highlight IndentLinePurple guifg=#000096')
                        vim.cmd('highlight SpaceCharRed     guifg=#B80808')
                        vim.cmd('highlight SpaceCharOrange  guifg=#B86408')
                        vim.cmd('highlight SpaceCharYellow  guifg=#B8B808')
                        vim.cmd('highlight SpaceCharGreen   guifg=#08B808')
                        vim.cmd('highlight SpaceCharAqua    guifg=#08B8B8')
                        vim.cmd('highlight SpaceCharBLue    guifg=#08B8B8')
                        vim.cmd('highlight SpaceCharPurple  guifg=#0808B8')
                end
        }
)

vim.api.nvim_create_autocmd(
        'CursorMoved',
        {
                pattern = '*',
                command = 'IndentBlanklineRefresh'
        }
)

vim.api.nvim_create_autocmd(
        'CursorMovedI',
        {
                pattern = '*',
                command = 'IndentBlanklineRefresh'
        }
)

require('indent_blankline').setup({
        char_highlight_list = {
                'IndentLineRed',
                'IndentLineOrange',
                'IndentLineYellow',
                'IndentLineGreen',
                'IndentLineAqua',
                'IndentLineBLue',
                'IndentLinePurple',
        },
        space_char_highlight_list = {
                'SpaceCharRed',
                'SpaceCharOrange',
                'SpaceCharYellow',
                'SpaceCharGreen',
                'SpaceCharAqua',
                'SpaceCharBLue',
                'SpaceCharPurple',
        },
        use_treesitter = true,
        show_trailing_blankline_indent = false,
        filetype_exclude = {'help'},
        buftype_exclude = {'terminal'},
})
