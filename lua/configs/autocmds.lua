local autocmd = vim.api.nvim_create_autocmd

local enableCursorHighlight = function ()
        vim.wo.cursorline = true
        vim.wo.cursorcolumn = true
end

local disableCursorHighlight = function ()
        vim.wo.cursorline = false
        vim.wo.cursorcolumn = false
end

autocmd({"CursorHold", "CursorHoldI"}, {
        callback = enableCursorHighlight
})
autocmd("WinLeave", {
        callback = disableCursorHighlight
})

local afterWinEnter
autocmd("WinEnter", {
        callback = function ()
                enableCursorHighlight()
                afterWinEnter = true
        end
})

autocmd({"CursorMoved", "CursorMovedI"}, {
        callback = function ()
                if not afterWinEnter then
                        disableCursorHighlight()
                else
                        afterWinEnter = false
                end
        end
})

autocmd("TermOpen", {
        command = 'startinsert'
})

autocmd("BufEnter", {
        callback = function ()
                if vim.o.buftype == "terminal" then
                        vim.cmd("startinsert")
                end
        end
})
