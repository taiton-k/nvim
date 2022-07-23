local hook_post_source = function ()

        vim.fn["ddc#custom#patch_global"]({
                sources = {
                        "around",
                        "file",
                },
                sourceOptions = {
                        _ = {
                                matchers = {"matcher_fuzzy"},
                                sorters = {"sorter_fuzzy"},
                                converters = {"converter_fuzzy", "converter_remove_overlap"},
                                ignoreCase = true
                        },
                        around = {
                                mark = 'A',
                        },
                        skkeleton = {
                                mark = "skk",
                                matchers = {"skkeleton"},
                                sorters = {}
                        },
                        file = {
                                mark = 'F',
                                isVolatile = true,
                                minAutoCompleteLength = 1000,
                                forceCompletionPattern = [[\S/\S*]],
                        },
                        necovim = {
                                mark = "vim"
                        },
                        ["cmdline-history"] = {
                                mark = "H"
                        },
                        ["nvim-lsp"] = {
                                mark = 'L',
                                forceCompletionPattern = [[\S.]],
                                timeout = 1000,
                        },
                        vsnip = {
                                mark = "S",
                        },
                },
                autoCompleteEvents = {
                        "InsertEnter",
                        "TextChangedI",
                        "TextChangedP",
                        "CmdlineEnter",
                        "CmdlineChanged",
                },
                backspaceCompletion = true,
                completionMenu = "pum.vim"
        })

        vim.fn["ddc#custom#patch_filetype"]({"vim"}, "sources", {
                "nvim-lsp",
                "necovim",
                "file",
                "cmdline-history",
                "around"
        })

        vim.fn["ddc#custom#patch_filetype"](vim.fn["dein#get"]("nvim-lspconfig").on_ft, "sources", {
                "nvim-lsp",
                "file",
                "around"
        })



        local pum = {
                is_visible = function ()
                        return vim.fn["pum#visible"]() == 1
                end,
                insert_relative = function (num)
                        vim.fn["pum#map#insert_relative"](num)
                end,
                confirm = function ()
                        vim.fn["pum#map#confirm"]()
                end
        }

        local set_keymap = function (mode, lhs, rhs, opts)
                if opts then
                        if not opts.expr then opts.expr = true end
                else
                        opts = {
                                expr = true
                        }
                end

                vim.keymap.set(mode, lhs, rhs, opts)
        end

        set_keymap("!", "<Plug>DdcManualComplete;", "ddc#map#manual_complete()")

        set_keymap("!", "<Plug>DdcExtend;", "ddc#map#extend()")

        set_keymap("i", "<Tab>",
                function()
                        if pum.is_visible() then
                                pum.insert_relative(1)
                        else
                                if vim.fn.col('.') <= 1 or vim.api.nvim_eval("getline('.')[col('.') - 2] =~# '\\s'") == 0 then
                                        return "<Plug>DdcManualComplete;"
                                else
                                        return "<Tab>"
                                end
                        end
                end,
                {
                        remap = true
                }
        )

        set_keymap('c', "<Tab>",
                function ()
                        if pum.is_visible() then
                                pum.insert_relative(1)
                        else
                                return "<Plug>DdcManualComplete;"
                        end
                end,
                {
                        remap = true
                }
        )

        set_keymap({"i", "c"}, "<S-Tab>",
                function ()
                        if pum.is_visible() then
                                pum.insert_relative(-1)
                        end
                end,
                {
                        remap = true
                }
        )

        set_keymap({"i", "c"}, "<C-y>",
                function ()
                        pum.confirm()
                end,
                {
                        remap = true
                }
        )

        set_keymap("i", "<C-l>","<Plug>DdcExtend;",
                {
                        remap = true
                }
        )

        vim.fn["ddc#enable"]()
end

local hook_add = function ()

        local prev_buffer_config = nil

        vim.api.nvim_create_autocmd("CmdlineEnter", {
                callback = function (arg)

                        local mode = arg.match

                        vim.fn["dein#source"]("ddc.vim")

                        vim.o.wildchar = vim.fn.char2nr("<C-t>")
                        vim.o.wildcharm = vim.fn.char2nr("<C-t>")

                        if prev_buffer_config == nil then
                                prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
                        end

                        if mode == ':' then
                                vim.fn["ddc#custom#patch_buffer"]({
                                        cmdlineSources = {
                                                "cmdline",
                                                "cmdline-history",
                                                "around",
                                                "necovim",
                                                "file",
                                        },
                                        keywordPattern = "[0-9a-zA-Z_:#]*",
                                })
                        else
                                vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", {"around"})
                        end

                        vim.fn["ddc#enable_cmdline_completion"]()
                end
        })

        vim.api.nvim_create_autocmd("CmdlineLeave", {
                callback = function ()

                        if prev_buffer_config then
                                vim.fn["ddc#custom#set_buffer"](prev_buffer_config)
                                prev_buffer_config = nil
                        else
                                print("ddc some error occurred")
                                vim.fn["ddc#custom#set_buffer"]()
                        end

                        vim.o.wildchar = vim.fn.char2nr("<Tab>")
                        vim.o.wildcharm = vim.fn.char2nr("<Tab>")
                end
        })
end

local ddc_plugins = {

        ["Shougo/ddc.vim"] = {
                lazy = true,
                on_event = {"InsertEnter", "CursorHold"},
                depends = {"denops.vim", "pum.vim"},
                hook_post_source = hook_post_source,
                hook_add = hook_add,
        },

        ["Shougo/ddc-nvim-lsp"] = {},

        ["Shougo/ddc-around"] = {},

        ["LumaKernel/ddc-file"] = {},

        ["Shougo/ddc-cmdline"] = {},

        ["Shougo/neco-vim"] = {},

        ["Shougo/ddc-cmdline-history"] = {},

        ["Shougo/ddc-converter_remove_overlap"] = {},

        ["tani/ddc-fuzzy"] = {},
}

for _, opts in pairs(ddc_plugins) do

        local opts_is_empty = true

        for _, _ in pairs(opts) do
                opts_is_empty = false
                break
        end

        if opts_is_empty then
                opts = {
                        lazy = true,
                        on_source = "ddc.vim"
                }
        end
end

return ddc_plugins
