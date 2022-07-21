local ddu = {}

ddu.hook_add = function ()
        vim.keymap.set("n", "<Leader>d", "<Cmd>Ddu source<CR>")
        vim.keymap.set("n", "<Leader>df", "<Cmd>Ddu file -ui=filer<CR>")
end

ddu.hook_post_source = function ()
        vim.fn["ddu#custom#patch_global"]({
                ui = "ff",
                uiParams = {
                        ff = {
                                autoResize = true,
                                split = "floating",
                                filterSplitDirection = "floating",
                                previewFloating = true,
                        },
                        filer = {
                                split = "vertical",
                                splitDirection = "topleft",
                                winWidth = vim.o.columns / 5
                        }
                },
                kindOptions = {
                        file = {
                                defaultAction = "open",
                                columns = {"icon_filename"}
                        },
                        word = {
                                defaultAction = "append"
                        },
                        action = {
                                defaultAction = "do"
                        },
                        source = {
                                defaultAction = "execute"
                        },
                        help = {
                                defaultAction = "open"
                        }
                },
                sourceOptions = {
                        _ = {
                                matchers = {"matcher_fzf"},
                                ignoreCase = true,
                        },
                        dein = {
                                defaultAction = "cd"
                        },
                        file = {
                                columns = {"icon_filename"}
                        },
                },
                filterParams = {
                        matcher_fzf = {
                                highlightMatched = "Search",
                        }
                },
        })
end

ddu.ftplugin = {

        ["ddu-ff"] = function ()
                local set_action = function (lhs, action)
                        vim.keymap.set('n', lhs,
                                function ()
                                        vim.fn["ddu#ui#ff#do_action"](action)
                                end,
                                {buffer = true}
                        )
                end

                set_action("<CR>", "itemAction")
                set_action("/", "openFilterWindow")
                set_action("q", "quit")
                set_action("p", "preview")
                set_action("<Tab>", "toggleSelectItem")
                set_action("c", "chooseAction")
        end,

        ["ddu-ff-filter"] = function ()
                vim.keymap.set("i", "<CR>",
                        function ()
                                vim.cmd("stopinsert")
                                vim.fn["ddu#ui#ff#close"]()
                        end,
                        {
                                buffer = true
                        }
                )

                vim.keymap.set("n", "<CR>",
                        function ()
                                vim.fn["ddu#ui#ff#close"]()
                        end,
                        {
                                buffer = true,
                        }
                )
        end,

        ["ddu-filer"] = function ()
                vim.cmd("IndentBlanklineDisable")

                local do_action = function (action, params)
                        if params then
                                vim.fn["ddu#ui#filer#do_action"](action, params)
                        else
                                vim.fn["ddu#ui#filer#do_action"](action)
                        end
                end

                local set_action = function (lhs, action, params)
                        vim.keymap.set('n', lhs,
                                function ()
                                        do_action(action, params)
                                end,
                                {buffer = true}
                        )
                end

                vim.keymap.set("n", "<CR>",
                        function ()
                                if vim.fn["ddu#ui#filer#is_directory"]() then
                                        do_action("expandItem", {mode = "toggle"})
                                else
                                        do_action("itemAction")
                                end
                        end,
                        {buffer = true}
                )
                set_action("q", "quit")
                set_action("p", "preview")
                set_action("<Tab>", "toggleSelectItem")
                set_action("c", "chooseAction")
        end
}



return ddu
