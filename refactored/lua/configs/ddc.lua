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
        vim.keymap.del('c', "<Tab>", {buffer = true})

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

        vim.keymap.set(
                'c',
                "<Tab>",
                function ()
                        if vim.fn["pum#visible"] then
                                vim.fn["pum#map#insert_relative"](1)
                                return ""
                        else
                                if vim.fn.exists("b:ddc_cmdline_completion") then
                                        return vim.fn["ddc#manual_complete"]()
                                else
                                        return "<C-t>"
                                end
                        end
                end,
                {buffer = true, expr = true}
        )

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






vim.keymap.set('n', ':',
        function()
                ddcCmdLinePre(':')
                return ':'
        end,
        {expr = true}
)

vim.keymap.set('n', '?',
        function ()
                ddcCmdLinePre('?')
                return '?'
        end,
        {expr = true}
)

vim.keymap.set("i", "<Tab>",
        function()
                if vim.fn["pum#visible"]() then
                        vim.fn["pum#map#insert_relative"](1)
                        return ""
                else
                        if vim.fn.col('.') <= 1 or vim.fn.getline('.')[vim.fn.col('.') - 1] == "\\s" then
                                return "<Tab>"
                        else
                                return vim.fn["ddc#manual_complete"]()
                        end
                end
        end,
        {expr = true, silent = true}
)

vim.keymap.set("i", "<S-Tab>",
        function ()
                vim.fn["pum#map#insert_relative"](-1)
        end
)

vim.keymap.set("i", "<C-p>",
        function ()
                vim.fn["pum#map#insert_relative"](-1)
        end
)

vim.keymap.set("i", "<C-n>",
        function ()
                vim.fn["pum#map#insert_relative"](1)
        end
)

vim.keymap.set("i", "<C-y>",
        function ()
                vim.fn["pum#map#confirm"]()
        end
)

vim.keymap.set("i", "<C-e>",
        function ()
                vim.fn["pum#map#cancel"]()
        end
)

vim.keymap.set("i", "<C-l>",
        function ()
                vim.fn["ddc#map#extend"]()
        end,
        {expr = true, silent = true}
)

vim.keymap.set("c", "<Tab>",
        function ()
                if vim.fn["pum#visible"]() then
                        vim.fn["pum#map#insert_relative"](1)
                        return ""
                else
                        vim.fn["ddc#manual_complete"]()
                end
        end,
        {expr = true}
)



vim.fn["ddc#enable"]()
