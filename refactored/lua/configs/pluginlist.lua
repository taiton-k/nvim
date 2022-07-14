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



local treesitter_plugins = {

        ['nvim-treesitter/nvim-treesitter'] = {
                lazy = true,
                hook_post_update = 'TSUpdate',
                hook_post_source = function ()
                        require('configs.treesitter')
                        vim.g.inden_blangline_use_treesitter = true
                end
        },

        ['yioneko/nvim-yati'] = {
                lazy = true,
                on_source = 'nvim-treesitter',
        },

        ['nvim-treesitter/playground'] = {
                lazy = true,
                on_source = 'nvim-treesitter',
        },
}

local lsp_plugins = {

        ['neovim/nvim-lspconfig'] = {
                lazy = true,
                on_ft = lsplist,
                hook_post_source = function () require('configs.lspconfig') end
        },

        ['glepnir/lspsaga.nvim'] = {
                lazy = true,
                on_source = 'nvim-lspconfig',
                hook_post_source = function () require('configs.lspsaga') end
        },
}

local pluginlist = {

        ['wsdjeg/dein-ui.vim'] = {
                lazy = true,
                on_cmd = 'DeinUpdate',
        },

        ['vim-jp/vimdoc-ja'] = {},

        ['kyazdani42/nvim-web-devicons'] = {
                hook_add = function () require("nvim-web-devicons").setup({}) end
        },

        ['lukas-reineke/indent-blankline.nvim'] = {
                hook_add = function () require('configs.indent_blankline') end
        },

        ['rebelot/kanagawa.nvim'] = {
                hook_add = "colorscheme kanagawa"
        },
}



local union = function (list1, list2)
        for item, value in pairs(list2) do
                list1[item] = value
        end
end

union(pluginlist, treesitter_plugins)
union(pluginlist, lsp_plugins)

return {
        pluginlist = pluginlist,
        tslist = tslist,
        lsplist = lsplist,
}
