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
        ['Shougo/dein.vim'] = {},
        ['wsdjeg/dein-ui.vim'] = {
                lazy = true,
                on_cmd = 'DeinUpdate',
        },
        ['vim-jp/vimdoc-ja'] = {},
        ['lukas-reineke/indent-blankline.nvim'] = {
                hook_add = function () require('plugins.indent_blankline') end
        },

        ['nvim-treesitter/nvim-treesitter'] = {
                lazy = true,
                on_ft = tslist,
                hook_post_update = 'TSUpdate',
                hook_post_source = function () require('plugins.treesitter') end
        },
        ['yioneko/nvim-yati'] = {
                lazy = true,
                on_source = 'nvim-treesitter',
        },
        ['nvim-treesitter/playground'] = {
                lazy = true,
                on_source = 'nvim-treesitter',
        },


        ['neovim/nvim-lspconfig'] = {
                lazy = true,
                ft = lsplist,
                hook_post_source = function () require('plugins.lspconfig') end
        },
        ['glepnir/lspsaga.nvim'] = {
                lazy = true,
                on_source = 'nvim-lspconfig',
                hook_post_source = function () require('plugins.lspsaga') end
        },

        ['rebelot/kanagawa.nvim'] = {
                hook_add = 'colorscheme kanagawa'
        },
}



return {
        pluginlist = pluginlist,
        tslist = tslist,
        lsplist = lsplist
}
