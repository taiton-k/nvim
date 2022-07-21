vim.g["dein#auto_recache"] = true
vim.g["dein#install_max_process"] = 16
vim.g["dein#auto_remote_plugins"] = false

local dein_dir = vim.fn.expand("~/.cache/deinre/")
local dein_repo_dir = dein_dir .. "repos/github.com/Shougo/dein.vim"

if not string.match(vim.o.runtimepath, "/dein.vim") then
        if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
                os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir)
        end
        vim.o.runtimepath = vim.fn.fnamemodify(dein_repo_dir, ":p") .. ',' .. vim.o.runtimepath
end



if vim.fn["dein#min#load_state"](dein_dir) == 1 then
        vim.fn["dein#begin"](dein_dir)

        vim.fn["dein#add"](dein_repo_dir)

        local plugins = require("configs.dein.wrapper").plugins

        for repo, opts in pairs(plugins) do

                local opts_is_empty = true
                for _, _ in pairs(opts) do
                        opts_is_empty = false
                        break
                end

                if opts_is_empty then
                        vim.fn["dein#add"](repo)
                else
                        vim.fn["dein#add"](repo, opts)
                end
        end

        vim.fn["dein#end"]()
        vim.fn["dein#save_state"]()
else
        vim.fn["dein#begin"](dein_dir)
        vim.fn["dein#end"]()
end



vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

if vim.fn["dein#check_install"]() == 1 then
        print(vim.fn.exists(":DeinUpdate") == 1)
        if vim.fn.exists(":DeinUpdate") == 1 then
                vim.cmd("DeinUpdate")
        else
                vim.fn["dein#install"]()
        end
end

vim.api.nvim_create_autocmd("VimEnter", {
        callback = function ()
                vim.fn["dein#call_hook"]("post_source")
        end
})
