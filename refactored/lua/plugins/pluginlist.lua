local tslist = {
        'cpp',
        'vim',
        'lua',
        'markdown',
}

local lsplist = {
        'cpp',
        'vim',
        'lua',
        'haskell',
}

local pluginlist = {
        {
                'tani/vim-jetpack',
                opt = 1
        },
        {
                'vim-jp/vimdoc-ja'
        },
        {
                'lukas-reineke/indent-blankline.nvim',
                post = function ()
                        require('plugins.indent_blankline')
                end
        },
        {
                'nvim-treesitter/nvim-treesitter',
                ft = tslist;
                post = function ()
                        require('plugin.treesitter')
                end
        },
        {
                'yioneko/nvim-yati',
                requires = 'nvim-treesitter/nvim-treesitter'
        },
}

return {
        pluginlist = pluginlist,
        tslist = tslist,
        lsplist = lsplist
}
