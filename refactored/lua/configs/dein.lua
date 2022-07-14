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



local pluginlist = require("configs.pluginlist")
local plugins = pluginlist.pluginlist
pluginlist.hook_functions = {}
local hook_functions = pluginlist.hook_functions
local is_opts_empty = {}

for repo, opts in pairs(plugins) do

        is_opts_empty[repo] = true

        for name, value in pairs(opts) do

                if is_opts_empty[repo] then is_opts_empty[repo] = false end

                if type(value) == "function" then

                        hook_functions[name], opts[name] = opts[name], nil

                        opts[name] = "lua require('configs.pluginlist').hook_functions['" .. name .. "']()"
                end
        end
end



if vim.fn["dein#load_state"](dein_dir) == 1 then
        vim.fn["dein#begin"](dein_dir)

        vim.fn["dein#add"](dein_repo_dir)

        for repo, opts in pairs(plugins) do
                if is_opts_empty[repo] then
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
