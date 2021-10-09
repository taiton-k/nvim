require("bufferline").setup{
        options = {
                -- Style
                separator_style = "padded_slant",

                -- Buffer Numbers setting For 8.2
                numbers = function(opts)
                        return string.format('%s', opts.ordinal)
                end,

                -- LSP Diafnostics
                diagnostics = "nvim-lsp",
                diagnostics_indicator = function(count, level)
                        local icon = level:matche("error") and " " or " "
                        return " " .. icon .. count
                end,

                always_show_bufferline = false,

                -- Groups Setting
                groups = {
                        items = {
                                {
                                        name = "Vim",
                                        -- highlight = {gui = "undercurl", guisp = "blue"},
                                        auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
                                        matcher = function(buf) -- Mandatory
                                                return buf.filename:match('%.vim')
                                        end,
                                },
                                {
                                        name = "Lua",
                                        -- highlight = {gui = "undercurl", guisp = "blue"},
                                        auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
                                        matcher = function(buf) -- Mandatory
                                                return buf.filename:match('%.lua')
                                        end,
                                },
                                {
                                        name = "Toml",
                                        -- highlight = {gui = "undercurl", guisp = "blue"},
                                        auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
                                        matcher = function(buf) -- Mandatory
                                                return buf.filename:match('%.toml')
                                        end,
                                }

                        }
                }
        }
}
