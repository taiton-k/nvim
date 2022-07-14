local autocmd = vim.api.nvim_create_autocmd

autocmd(
        "WinEnter",
        {
                callback = function ()
                        vim.wo.cursorline = true
                        vim.wo.cursorcolumn = true
                end
        }
)

autocmd(
        "WinLeave",
        {
                callback = function ()
                        vim.wo.cursorline = false
                        vim.wo.cursorcolumn = false
                end
        }
)

autocmd(
        "TermOpen",
        {
                command = 'startinsert'
        }
)

autocmd(
        "BufEnter",
        {
                callback = function ()
                        if vim.o.buftype == "terminal" then
                                vim.cmd("startinsert")
                        end
                end
        }
)
