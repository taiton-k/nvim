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
                on_ft = tslist,
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
                hook_post_source = function ()
                        require('configs.lspconfig')
                        vim.cmd("LspStart")
                end,
        },

        ['glepnir/lspsaga.nvim'] = {
                lazy = true,
                on_source = 'nvim-lspconfig',
                hook_post_source = function () require('configs.lspsaga') end
        },

        ["matsui54/denops-popup-preview.vim"] = {
                lazy = true,
                depends = "denops.vim",
                hook_post_source = "call popup_preview#enable()"
        },

        ["matsui54/denops-signature_help"] = {
                lazy = true,
                on_source = "nvim-lspconfig",
                depends = "denops-popup-preview.vim",
                hook_post_source = "call signature_help#enable()"
        },
}



local snippets_plugins = {

        ["hrsh7th/vim-vsnip"] = {
                lazy = true,
                on_source = "ddc.vim"
        },

        ["hrsh7th/vim-vsnip-integ"] = {
                lazy = true,
                on_source = "nvim-lspconfig, ddc.vim",
                depends = "vim-vsnip",
        },

        ["rafamadriz/friendly-snippets"] = {},
}



local ddu_child_opts = {
        lazy = true,
        on_source = "ddu.vim"
}
local ddu_plugins = {

        ["Shougo/ddu.vim"] = {
                lazy = true,
                depends = "denops.vim",
                on_source = "denops.vim",
                hook_add = require("configs.ddu").hook_add,
                hook_post_source = require("configs.ddu").hook_post_source,
                ftplugin = require("configs.ddu").ftplugin
        },

        ["Shougo/ddu-commands.vim"] = {
                lazy = true,
                depends = "ddu.vim",
                on_cmd = "Ddu"
        },

        ["Shougo/ddu-ui-ff"] = ddu_child_opts,

        ["Shougo/ddu-ui-filer"] = ddu_child_opts,

        ["Shougo/ddu-kind-file"] = ddu_child_opts,

        ["Shougo/ddu-kind-word"] = ddu_child_opts,

        ["shun/ddu-source-buffer"] = ddu_child_opts,

        ["Shougo/ddu-source-file"] = ddu_child_opts,

        ["Shougo/ddu-source-file_rec"] = ddu_child_opts,

        ["matsui54/ddu-source-help"] = ddu_child_opts,

        ["yuki-yano/ddu-filter-fzf"] = ddu_child_opts,

        ["Shougo/ddu-column-filename"] = ddu_child_opts,

        ["4513ECHO/ddu-source-source"] = ddu_child_opts,

        ["Shougo/ddu-source-action"] = ddu_child_opts,

        ["ryota2357/ddu-column-icon_filename"] = ddu_child_opts
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
                hook_add = function ()
                        require("kanagawa").setup({
                                overrides = {
                                        Normal = {
                                                bg = "NONE"
                                        }
                                }
                        })

                        vim.cmd("colorscheme kanagawa")
                end
        },

        ["windwp/nvim-autopairs"] = {
                lazy = true,
                on_event = "InsertEnter",
                hook_post_source = function ()
                        require('nvim-autopairs').setup({
                                map_c_h = true;
                                map_cr = true;
                        })
                end
        },

        ["vim-denops/denops.vim"] = {
                lazy = true,
                on_event = "CursorHold",
                hook_post_source = function ()
                        require("configs.denops")
                end
        },

        ["Shougo/pum.vim"] = {
                lazy = true,
                hook_post_source = function ()
                        vim.fn["pum#set_option"]({
                                max_width = 50,
                                pudding = true,
                        })
                end
        },

        ["akinsho/toggleterm.nvim"] = {
                lazy = true,
                on_event = "VimEnter",
                hook_post_source = function ()
                        require("toggleterm").setup({
                                size = vim.o.lines / 4,
                                open_mapping = "<C-t>",
                                direction = "horizontal"
                        })

                        vim.api.nvim_create_autocmd("BufEnter", {
                                callback = function ()
                                        if vim.o.filetype == "toggleterm" then
                                                vim.cmd("startinsert")
                                        end
                                end
                        })
                end
        },
}



local union = function (list1, list2)
        for item, value in pairs(list2) do
                list1[item] = value
        end
end

union(pluginlist, treesitter_plugins)
union(pluginlist, lsp_plugins)
union(pluginlist, require("configs.ddc"))
union(pluginlist, ddu_plugins)
union(pluginlist, snippets_plugins)

return {
        pluginlist = pluginlist,
        tslist = tslist,
        lsplist = lsplist,
}
