vim.g["dein#auto_recache"] = true
vim.g["dein#install_max_process"] = 16
vim.g["dein#auto_remote_plugins"] = false

local dein_dir = vim.fn.expand("~/.cache/deinre")
local dein_repo_dir = dein_dir .. "repos/github.com/Shougo/dein.vim"

if not string.match(vim.o.runtimepath, "/dein.vim") then
        if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
                os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir)
        end
        vim.o.runtimepath = vim.fn.fnamemodify(dein_repo_dir, ":p") .. ',' .. vim.o.runtimepath
end


if vim.fn["dein#load_state"](dein_dir) == 1 then
        vim.fn["dein#begin"](dein_dir)

        local plugins = require("plugins.pluginlist").pluginlist

        for repo, opts in pairs(plugins) do

                local is_opts_empty = true

                for name, value in pairs(opts) do

                        if is_opts_empty then is_opts_empty = false end

                        if type(value) == "function" then
                                if name == "hook_add" then
                                        value = "lua require('plugins.pluginlist').pluginlist[i].hook_add()"
                                elseif name == "hook_source" then
                                        value = "lua require('plugins.pluginlist').pluginlist[i].hook_source()"
                                elseif name == "hook_post_source" then
                                        value = "lua require('plugins.pluginlist').pluginlist[i].hook_post_source()"
                                elseif name == "hook_post_update" then
                                        value = "lua require('plugins.pluginlist').pluginlist[i].hook_post_update()"
                                elseif name == "hook_done_update" then
                                        value = "lua require('plugins.pluginlist').pluginlist[i].hook_done_update()"
                                end
                        end
                end

                if is_opts_empty then
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
        if vim.fn.exists(":DeinUpdate") == 1 then
                vim.cmd("DeinUpdate")
        else
                vim.fn["dein#install"]()
        end
end
