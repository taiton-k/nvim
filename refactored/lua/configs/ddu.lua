local ddu = {}

ddu.hook_add = function ()
        vim.keymap.set("n", "<Leader>d", "<Cmd>Ddu source<CR>")
        vim.keymap.set("n", "<Leader>df", "<Cmd>Ddu file_rec -ui=filer<CR>")
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
                                winWidth = vim.o.columns / 4
                        }
                },
                kindOptions = {
                        file = {
                                defaultAction = "open"
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
                },
                sourceOptions = {
                        _ = {
                                matchers = {"matcher_fzf"},
                                ignoreCase = true,
                        },
                        dein = {
                                defaultAction = "cd"
                        },
                        file_rec = {
                                columns = {"icon_filename"}
                        }
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
                local set_action = function (lhs, action)
                        vim.keymap.set('n', lhs,
                                function ()
                                        vim.fn["ddu#ui#filer#do_action"](action)
                                end,
                                {buffer = true}
                        )
                end

                set_action("<CR>", "itemAction")
                set_action("q", "quit")
                set_action("p", "preview")
                set_action("<Tab>", "toggleSelectItem")
                set_action("c", "chooseAction")
        end
}


return ddu
