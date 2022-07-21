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
                }
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

vim.fn["ddc#custom#patch_filetype"](require("configs.pluginlist").lsplist, "sources", {
        "nvim-lsp",
        "file",
        "around"
})






local prev_buffer_config = nil

local ddcCmdLinePost = function ()

        if prev_buffer_config then
                vim.fn["ddc#custom#set_buffer"](prev_buffer_config)
                prev_buffer_config = nil
        else
                vim.fn["ddc#custom#set_buffer"]()
                print("ddc some error occurred")
        end

        vim.o.wildchar = vim.fn.char2nr("<Tab>")
        vim.o.wildcharm = vim.fn.char2nr("<Tab>")
end

local ddcCmdLinePre = function (mode)

        vim.o.wildchar = vim.fn.char2nr("<C-t>")
        vim.o.wildcharm = vim.fn.char2nr("<C-t>")

        if prev_buffer_config == nil then
                prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
        end

        if mode == ':' then
                vim.fn["ddc#custom#patch_buffer"]({
                        cmdlineSources = {
                                "necovim",
                                "file",
                                "cmdline-history",
                                "around"
                        },
                        keywordPattern = "[0-9a-zA-Z_:#]*",
                })
        else
                vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", {"around"})
        end

        vim.api.nvim_create_autocmd("CmdlineLeave", {
                once = true,
                callback = function ()
                        ddcCmdLinePost()
                end
        })

        vim.fn["ddc#enable_cmdline_completion"]()
end






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

vim.keymap.set("i", "<Plug>DdcManualComplete;",
        "ddc#map#manual_complete()",
        {
                expr = true
        }
)

vim.keymap.set("i", "<Plug>DdcExtend;",
        "ddc#map#extend()",
        {
                expr = true
        }
)

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






set_keymap('n', ':',
        function()
                ddcCmdLinePre(':')
                return ':'
        end
)

set_keymap('n', '?',
        function ()
                ddcCmdLinePre('?')
                return '?'
        end
)

set_keymap("i", "<Tab>",
        function()
                if pum.is_visible() then
                        pum.insert_relative(1)
                else
                        if vim.fn.col('.') <= 1 or vim.fn.getline('.')[vim.fn.col('.') - 1] == "\\s" then
                                return "<Tab>"
                        else
                                return "<Plug>DdcManualComplete;"
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
