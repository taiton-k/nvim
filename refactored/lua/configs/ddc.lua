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






local t = function (str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local keymap_ids = {}
local counter = 1
local keymap_callbacks = {}

local gen_keymap_id = function (mode, lhs, rhs)

        local str = ""

        if type(mode) == "string" then
                str = mode .. lhs
        elseif type(mode) == "table" then
                for i in ipairs(mode) do
                        str = str .. mode[i] .. lhs
                end
        end

        local id

        if keymap_ids[str] then
                id = keymap_ids[str]
        else
                id = counter
                counter = counter + 1
                keymap_ids[str] = id
        end

        keymap_callbacks[id] = function ()
                return rhs() or ""
        end

        return id
end

local call_keymap_callback = function (id)
        return keymap_callbacks[id]()
end

local set_keymap = function (mode, lhs, rhs, opts)
        if type(rhs) == "function" then
                if opts then
                        opts.expr = true
                else
                        opts = {
                                expr = true
                        }
                end

                local id = gen_keymap_id(mode, lhs, rhs)

                local command = "v:lua.require('configs.ddc').call_keymap_callback(" .. id .. ")"

                if type(mode) == "string" then
                        vim.api.nvim_set_keymap(mode, lhs, command, opts)
                else
                        for i in ipairs(mode) do
                                vim.api.nvim_set_keymap(mode[i], lhs, command, opts)
                        end
                end
        else
                vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
        end
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
                if vim.fn["pum#visible"]() == 1 then
                        return vim.fn["pum#map#insert_relative"](1)
                else
                        if vim.fn.col('.') <= 1 or vim.fn.getline('.')[vim.fn.col('.') - 1] == "\\s" then
                                return t"<Tab>"
                        else
                                return vim.fn["ddc#map#manual_complete"]()
                        end
                end
        end,
        {silent = true}
)

set_keymap('c', "<Tab>",
        function ()
                if vim.fn["pum#visible"]() == 1 then
                        return vim.fn["pum#map#insert_relative"](1)
                else
                        return vim.fn["ddc#map#manual_complete"]()
                end
        end
)

set_keymap({"i", "c"}, "<S-Tab>",
        function ()
                if vim.fn["pum#visible"]() == 1 then
                        return vim.fn["pum#map#insert_relative"](-1)
                end
        end
)

set_keymap({"i", "c"}, "<C-y>",
        function ()
                return vim.fn["pum#map#confirm"]()
        end
)

set_keymap("i", "<C-l>",
        function ()
                return vim.fn["ddc#map#extend"]()
        end,
        {silent = true}
)






vim.fn["ddc#enable"]()

return {
        call_keymap_callback = call_keymap_callback
}
